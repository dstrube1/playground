//
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
// Copyright (c) 2006 Microsoft Corporation. All rights reserved.
//
// CSampleProvider implements ICredentialProvider, which is the main
// interface that logonUI uses to decide which tiles to display.
// In this sample, we have decided to show two tiles, one for
// Administrator and one for Guest.  You will need to decide what
// tiles make sense for your situation.  Can you enumerate the
// users who will use your method to log on?  Or is it better
// to provide a tile where they can type in their username?
// Does the user need to interact with something other than the
// keyboard before you can recognize which user it is (such as insert 
// a smartcard)?  We call these "event driven" credential providers.  
// We suggest that such credential providers first provide one basic tile which
// tells the user what to do ("insert your smartcard").  Once the
// user performs the action, then you can callback into LogonUI to
// tell it that you have new tiles, and include a tile that is specific
// to the user that the user can then interact with if necessary.

#include <credentialprovider.h>
#include "CSampleProvider.h"
#include "CSampleCredential.h"
#include "guid.h"
#include <wincred.h>

// CSampleProvider ////////////////////////////////////////////////////////

CSampleProvider::CSampleProvider():
    _cRef(1),
    _pkiulSetSerialization(NULL),
    _dwCredUIFlags(0),
    _bRecreateEnumeratedCredentials(true),
    _bAutoSubmitSetSerializationCred(false),
    _bDefaultToFirstCredential(false)
{
    DllAddRef();

    ZeroMemory(_rgpCredentials, sizeof(_rgpCredentials));
}

CSampleProvider::~CSampleProvider()
{
    _ReleaseEnumeratedCredentials();
    DllRelease();
}

void CSampleProvider::_ReleaseEnumeratedCredentials()
{
    for (int i = 0; i < ARRAYSIZE(_rgpCredentials); i++)
    {
        if (_rgpCredentials[i] != NULL)
        {
            _rgpCredentials[i]->Release();
        }
    }
}


// SetUsageScenario is the provider's cue that it's going to be asked for tiles
// in a subsequent call.
//
// This sample only handles the logon, unlock, and credui scenarios.
HRESULT CSampleProvider::SetUsageScenario(
    CREDENTIAL_PROVIDER_USAGE_SCENARIO cpus,
    DWORD dwFlags
    )
{
    HRESULT hr;

    _cpus = cpus;
    if (cpus == CPUS_CREDUI)
    {
        _dwCredUIFlags = dwFlags;  // currently the only flags ever passed in are only valid for the credui scenario
    }
    _bRecreateEnumeratedCredentials = true;

    // unlike SampleCredentialProvider, we're not going to enumerate here.  Instead, we'll store off the info
    // and then we'll wait for GetCredentialCount to enumerate.  That way we'll know at enumeration time
    // whether we have a SetSerialization cred to deal with.  That's a bit more important in the credUI case
    // than the logon case (although even in the logon case you could choose to only enumerate the SetSerialization
    // credential if there is one -- that's what the built-in password provider does).
    switch (cpus)
    {
    case CPUS_LOGON:
    case CPUS_UNLOCK_WORKSTATION:
    case CPUS_CREDUI:
        hr = S_OK;
        break;

    case CPUS_CHANGE_PASSWORD:
        hr = E_NOTIMPL;
        break;

    default:
        hr = E_INVALIDARG;
        break;
    }

    return hr;
}

// SetSerialization takes the kind of buffer that you would normally return to LogonUI for
// an authentication attempt.  It's the opposite of ICredentialProviderCredential::GetSerialization.
// GetSerialization is implement by a credential and serializes that credential.  Instead,
// SetSerialization takes the serialization and uses it to create a tile.
//
// SetSerialization is called for two main scenarios.  The first scenario is in the credui case
// where it is prepopulating a tile with credentials that the user chose to store in the OS.
// The second situation is in a remote logon case where the remote client may wish to 
// prepopulate a tile with a username, or in some cases, completely populate the tile and
// use it to logon without showing any UI.
//
STDMETHODIMP CSampleProvider::SetSerialization(
    const CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION* pcpcs
    )
{
    HRESULT hr = E_INVALIDARG;

    if ((CLSID_CSampleProvider == pcpcs->clsidCredentialProvider) || (CPUS_CREDUI == _cpus))
    {
        // Get the current AuthenticationPackageID that we are supporting
        ULONG ulAuthPackage;
        hr = RetrieveNegotiateAuthPackage(&ulAuthPackage);

        if (SUCCEEDED(hr))
        {
            if ((CPUS_CREDUI == _cpus) && (_dwCredUIFlags & CREDUIWIN_AUTHPACKAGE_ONLY) && 
                (ulAuthPackage == pcpcs->ulAuthenticationPackage))
            {
                // In the credui case, SetSerialization should only ever return S_OK if it is able to serialize the input cred.
                // Unfortunately, SetSerialization had to be overloaded to indicate whether or not it will be able to GetSerialization 
                // for the specific Auth Package that is being requested for CREDUIWIN_AUTHPACKAGE_ONLY to work, so when that flag is 
                // set, it should return S_FALSE unless it is ALSO able to serialize the input cred, then it can return S_OK.
                hr = S_FALSE;
            }
            if ((ulAuthPackage == pcpcs->ulAuthenticationPackage) &&
                (0 < pcpcs->cbSerialization && pcpcs->rgbSerialization))
            {
                KERB_INTERACTIVE_UNLOCK_LOGON* pkil = (KERB_INTERACTIVE_UNLOCK_LOGON*) pcpcs->rgbSerialization;
                if (KerbInteractiveLogon == pkil->Logon.MessageType)
                {
                    BYTE* rgbSerialization;
                    rgbSerialization = (BYTE*)HeapAlloc(GetProcessHeap(), 0, pcpcs->cbSerialization);
                    HRESULT hrCreateCred = rgbSerialization ? S_OK : E_OUTOFMEMORY;

                    if (SUCCEEDED(hrCreateCred))
                    {
                        CopyMemory(rgbSerialization, pcpcs->rgbSerialization, pcpcs->cbSerialization);
                        KerbInteractiveLogonUnpackInPlace((KERB_INTERACTIVE_UNLOCK_LOGON*)rgbSerialization);

                        if (_pkiulSetSerialization)
                        {
                            HeapFree(GetProcessHeap(), 0, _pkiulSetSerialization);
                        }
                        _pkiulSetSerialization = (KERB_INTERACTIVE_UNLOCK_LOGON*)rgbSerialization;
                        if (SUCCEEDED(hrCreateCred))
                        {
                            // we allow success to override the S_FALSE for the CREDUIWIN_AUTHPACKAGE_ONLY, but
                            // failure to create the cred shouldn't override that we can still handle
                            // the auth package
                            hr = hrCreateCred;
                        }
                    }
                }
            }
        }
        else
        {
            hr = E_INVALIDARG;
        }
    }

    return hr;
}

// Called by LogonUI to give you a callback.  Providers often use the callback if they
// some event would cause them to need to change the set of tiles that they enumerated
HRESULT CSampleProvider::Advise(
    ICredentialProviderEvents* pcpe,
    UINT_PTR upAdviseContext
    )
{
    UNREFERENCED_PARAMETER(pcpe);
    UNREFERENCED_PARAMETER(upAdviseContext);

    return E_NOTIMPL;
}

// Called by LogonUI when the ICredentialProviderEvents callback is no longer valid.
HRESULT CSampleProvider::UnAdvise()
{
    return E_NOTIMPL;
}

// Called by LogonUI to determine the number of fields in your tiles.  This
// does mean that all your tiles must have the same number of fields.
// This number must include both visible and invisible fields. If you want a tile
// to have different fields from the other tiles you enumerate for a given usage
// scenario you must include them all in this count and then hide/show them as desired 
// using the field descriptors.
HRESULT CSampleProvider::GetFieldDescriptorCount(
    DWORD* pdwCount
    )
{
    *pdwCount = SFI_NUM_FIELDS;

    return S_OK;
}

// Gets the field descriptor for a particular field
HRESULT CSampleProvider::GetFieldDescriptorAt(
    DWORD dwIndex, 
    CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR** ppcpfd
    )
{    
    HRESULT hr;

    // Verify dwIndex is a valid field.
    if ((dwIndex < SFI_NUM_FIELDS) && ppcpfd)
    {
        hr = FieldDescriptorCoAllocCopy(s_rgCredProvFieldDescriptors[dwIndex], ppcpfd);
    }
    else
    { 
        hr = E_INVALIDARG;
    }

    return hr;
}

// Sets pdwCount to the number of tiles that we wish to show at this time.
// Sets pdwDefault to the index of the tile which should be used as the default.
// The default tile is the tile which will be shown in the zoomed view by default. If 
// more than one provider specifies a default tile the behavior is the last cred prov
// get to specify the default tile.
// If *pbAutoLogonWithDefault is TRUE, LogonUI will immediately call GetSerialization
// on the credential you've specified as the default and will submit that credential
// for authentication without showing any further UI.
HRESULT CSampleProvider::GetCredentialCount(
    DWORD* pdwCount,
    DWORD* pdwDefault,
    BOOL* pbAutoLogonWithDefault
    )
{
    HRESULT hr = E_FAIL;
    if (_bRecreateEnumeratedCredentials)
    {
        _ReleaseEnumeratedCredentials();
        hr = _CreateEnumeratedCredentials();
        _bRecreateEnumeratedCredentials = false;
    }

    *pdwCount = 0;
    *pdwDefault = (_bDefaultToFirstCredential && _rgpCredentials[0]) ? 0 : CREDENTIAL_PROVIDER_NO_DEFAULT;
    *pbAutoLogonWithDefault = FALSE;

    if (SUCCEEDED(hr))
    {
        // TODO: it would probably be nicer to keep a count of the number of creds
        DWORD dwNumCreds = 0;
        for (int i = 0; i < MAX_CREDENTIALS; i++)
        {
            if (_rgpCredentials[i] != NULL)
            {
                dwNumCreds++;
            }
        }

        switch(_cpus)
        {
        case CPUS_LOGON:
            if (_bAutoSubmitSetSerializationCred)
            {
                *pdwCount = 1;
                *pbAutoLogonWithDefault = TRUE;
            }
            else
            {
                
                *pdwCount = dwNumCreds;
                // since we have more than one tile and don't keep track of who logged on last, we don't really have a default in this case
            }
            hr = S_OK;
            break;

        case CPUS_UNLOCK_WORKSTATION:
            // in the unlock case, you likely would want to only enumerate tiles for the logged on user (that could be used to unlock)
            // but that's a bit complicated for a sample, so we'll just use our normal tiles
            // that we already set up in the logon case.  The default out params set up at the top work for this case.
            *pdwCount = dwNumCreds;
            hr = S_OK;
            break;

        case CPUS_CREDUI:
            {
               *pdwCount = dwNumCreds;
                hr = S_OK;
            }
            break;

        default:
            hr = E_INVALIDARG;
            break;
        }
    }
    
    return hr;
}

// Returns the credential at the index specified by dwIndex. This function is called by logonUI to enumerate
// the tiles.
HRESULT CSampleProvider::GetCredentialAt(
    DWORD dwIndex, 
    ICredentialProviderCredential** ppcpc
    )
{
    HRESULT hr;

    // Validate parameters.
    if((dwIndex < ARRAYSIZE(_rgpCredentials)) && _rgpCredentials[dwIndex] != NULL && ppcpc)
    {
        hr = _rgpCredentials[dwIndex]->QueryInterface(IID_ICredentialProviderCredential, reinterpret_cast<void**>(ppcpc));
    }
    else
    {
        hr = E_INVALIDARG;
    }
        
    return hr;
}

// Creates a Credential with the SFI_USERNAME field's value set to pwzUsername.
HRESULT CSampleProvider::_EnumerateOneCredential(
    DWORD dwCredentialIndex,
    PCWSTR pwzUsername
    )
{
    HRESULT hr;

    // Allocate memory for the new credential.
    CSampleCredential* ppc = new CSampleCredential();
    
    if (ppc)
    {
        // Set the Field State Pair and Field Descriptors for ppc's fields
        // to the defaults (s_rgCredProvFieldDescriptors, and s_rgFieldStatePairs) and the value of SFI_USERNAME
        // to pwzUsername.
        hr = ppc->Initialize(s_rgCredProvFieldDescriptors, s_rgFieldStatePairs, pwzUsername);
        
        if (SUCCEEDED(hr))
        {
            _rgpCredentials[dwCredentialIndex] = ppc;
        }
        else
        {
            // Release the pointer to account for the local reference.
            ppc->Release();
        }
    }
    else
    {
        hr = E_OUTOFMEMORY;
    }

    return hr;
}

//
// Depending on whether SetSerialization has been called and what CPUS we're in
// creates the right set of credentials
//
HRESULT CSampleProvider::_CreateEnumeratedCredentials()
{
    HRESULT hr = E_INVALIDARG;
    switch(_cpus)
    {
    case CPUS_LOGON:
        if (_pkiulSetSerialization)
        {
            hr = _EnumerateSetSerialization();
        }
        else
        {
            hr = _EnumerateCredentials();
        }
        break;

    case CPUS_CHANGE_PASSWORD:
        break;

    case CPUS_UNLOCK_WORKSTATION:
        // a more advanced implementation would only enumerate tiles that could gather creds for the logged on user
        // since those are the only creds that will work to unlock the session
        // but we're going with this for simplicity
        hr = _EnumerateCredentials();  
        break;

    case CPUS_CREDUI:
        _bDefaultToFirstCredential = true;

        if (_pkiulSetSerialization)
        {
            hr = _EnumerateSetSerialization();
        }
        if (_dwCredUIFlags & CREDUIWIN_ADMINS_ONLY)
        {
            // this sample doesn't handle this particular case
            // You would want to handle this in order to participate
            // User Account Control elevations for a non-admin users (where all the
            // admins tiles are enumerated)
        }
		else if (!(_dwCredUIFlags & CREDUIWIN_IN_CRED_ONLY))
        {
            // if we're here, then we're supposed to enumerate whatever we should enumerate for the normal case.  
            // In our case, that's our 2 tiles.  We may already have one tile, though
            if (_pkiulSetSerialization && SUCCEEDED(hr))
            {
                hr = _EnumerateCredentials(true);
            }
            else
            {
                hr = _EnumerateCredentials(false);
            }
        }
        break;

    default:
        break;
    }
    return hr;
}


// Sets up the normal 2 tiles for this provider (Administrator and Guest)
HRESULT CSampleProvider::_EnumerateCredentials(bool bAlreadyHaveSetSerializationCred)
{
    DWORD dwStart = bAlreadyHaveSetSerializationCred ? 1 : 0;
    HRESULT hr = _EnumerateOneCredential(dwStart++, L"Administrator");
    if (SUCCEEDED(hr))
    {
        hr = _EnumerateOneCredential(dwStart++, L"Guest");
    }
    return hr;
}

// This enumerates a tile for the info in _pkiulSetSerialization.  See the SetSerialization function comment for
// more information.
HRESULT CSampleProvider::_EnumerateSetSerialization()
{
    KERB_INTERACTIVE_LOGON* pkil = &_pkiulSetSerialization->Logon;

    _bAutoSubmitSetSerializationCred = false;
    _bDefaultToFirstCredential = false;

    // Since this provider only enumerates local users (not domain users) we are ignoring the domain passed in.
    // However, please note that if you receive a serialized cred of just a domain name, that domain name is meant 
    // to be the default domain for the tiles (or for the empty tile if you have one).  Also, depending on your scenario,
    // the presence of a domain other than what you're expecting might be a clue that you shouldn't handle
    // the SetSerialization.  For example, in this sample, we could choose to not accept a serialization for a cred
    // that had something other than the local machine name as the domain.

    // Use a "long" (MAX_PATH is arbitrary) buffer because it's hard to predict what will be
    // in the incoming values.  A DNS-format domain name, for instance, can be longer than DNLEN.
    WCHAR wszUsername[MAX_PATH] = {0};
    WCHAR wszPassword[MAX_PATH] = {0};

    // since this sample assumes local users, we'll ignore domain.  If you wanted to handle the domain
    // case, you'd have to update CSampleCredential::Initialize to take a domain.
    HRESULT hr = StringCbCopyNW(wszUsername, sizeof(wszUsername), pkil->UserName.Buffer, pkil->UserName.Length);

    if (SUCCEEDED(hr))
    {
        hr = StringCbCopyNW(wszPassword, sizeof(wszPassword), pkil->Password.Buffer, pkil->Password.Length);

        if (SUCCEEDED(hr))
        {
            CSampleCredential* pCred = new CSampleCredential();

            if (pCred)
            {
                hr = pCred->Initialize(s_rgCredProvFieldDescriptors, s_rgFieldStatePairs, wszUsername, wszPassword);

                if (SUCCEEDED(hr))
                {
                    // for the purposes of this sample, when we enumerate the SetSerialization cred, we only enumerate
                    // that cred and no others, so we can assume it just goes in slot 0.
                    _rgpCredentials[0] = pCred;

                    //if we were able to create a cred, default to it
                    _bDefaultToFirstCredential = true;  
                }
            }
            else
            {
                hr = E_OUTOFMEMORY;
            }

            // If we were passed all the info we need (in this case username & password), we're going to automatically submit this credential.
            // (if we're in CPUS_LOGON that is.  In credUI we want the user to at least click the tile to choose to use those creds)
            if (SUCCEEDED(hr) && (0 < wcslen(wszPassword)))
            {
                _bAutoSubmitSetSerializationCred = true;
            }
        }
    }


    return hr;
}

// Boilerplate code to create our provider.
HRESULT CSampleProvider_CreateInstance(REFIID riid, void** ppv)
{
    HRESULT hr;

    CSampleProvider* pProvider = new CSampleProvider();

    if (pProvider)
    {
        hr = pProvider->QueryInterface(riid, ppv);
        pProvider->Release();
    }
    else
    {
        hr = E_OUTOFMEMORY;
    }
    
    return hr;
}
