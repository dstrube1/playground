#include "stdafx.h"
#include "JSHook.hpp"
#include "LeakDlg.hpp"

JSHook::~JSHook() {
	// When the hook is destroyed, make sure all elements are released.
	//
	clearElements();
}

// IDispatch
//
STDMETHODIMP JSHook::GetTypeInfoCount(UINT *pctinfo) {
	// Don't need to provide type info to work in IE.
	//
	return E_NOTIMPL;
}

STDMETHODIMP JSHook::GetTypeInfo(UINT iTInfo, LCID lcid, ITypeInfo **ppTInfo) {
	// Don't need to provide type info to work in IE.
	//
	return E_NOTIMPL;
}

STDMETHODIMP JSHook::GetIDsOfNames(REFIID iid, OLECHAR **names, UINT nameCount, LCID lcid, DISPID *dispIds) {
	// The only member is 'logElement'.
	//
	bool failed = false;
	for (int i = 0; i < (int)nameCount; ++i) {
		if (!wcscmp(names[i], L"logElement"))
			dispIds[i] = 0;
		else {
			dispIds[i] = -1;
			failed = true;
		}
	}

	if (failed)
		return DISP_E_MEMBERNOTFOUND;
	return S_OK;
}

STDMETHODIMP JSHook::Invoke(DISPID dispId, REFIID riid, LCID lcid, WORD flags, DISPPARAMS *dispParams, VARIANT *result, EXCEPINFO *exInfo, UINT *argErr) {
	if (dispId == -1)
		return DISP_E_MEMBERNOTFOUND;

	// logElement() takes two arguments, elem and doc.
	//
	if (dispParams->cArgs != 2)
		return DISP_E_BADPARAMCOUNT;

	if (dispParams->rgvarg[0].vt != VT_DISPATCH)
		return DISP_E_BADVARTYPE;

	// Get the document and element, and add the element to the list.
	//
	MSHTML::IHTMLDocument2Ptr doc = dispParams->rgvarg[0].pdispVal;
	MSHTML::IHTMLElementPtr elem = dispParams->rgvarg[1].pdispVal;
	addElement(elem, doc);
	return S_OK;
}

// Add an element to the hook's list.  The element's URL will be retrieved from
//  its current document.
//
void JSHook::addElement(MSHTML::IHTMLElement* elem) {
	MSHTML::IHTMLDocument2Ptr doc = elem->document;
	addElement(elem, doc);
}

// Add an element to the hook's list.  The element's URL will be retrieved from
//  the specified document.
//
void JSHook::addElement(MSHTML::IHTMLElement* elem, MSHTML::IHTMLDocument2* doc) {
	// In order to ensure that we maintain a durable reference to the element (as
	//   opposed to a tear-off interface), we have to query for IUnknown.
	//
	IUnknown* unk = NULL;
	elem->QueryInterface(IID_IUnknown, (void**)&unk);
	m_elements.insert(Elem(unk, SysAllocString(doc->url)));
}

// This method is called when a document is finished loading.  It will hook the
//   document's createElement() method, passing all dynamically-created elements
//   to the hook as they are created.
//
void JSHook::hookNewPage(MSHTML::IHTMLDocument2Ptr doc) {
	MSHTML::IHTMLWindow2Ptr wnd = doc->parentWindow;

	// Create a temporary function to hook createElement().
	//
	wnd->execScript(
		L"function __drip_replaceCreateElement(jsHook) {"
		L"  var oldCE = document.createElement;"
		L"  document.createElement = function(tag) {"
		L"    var elem = oldCE(tag);"
		L"    jsHook.logElement(elem, document);"
		L"    return elem;"
		L"  };"
		L"}",
		L"javascript");

	// Create a parameter list containing the hook, then invoke the
	//   temporary function to attach it to the document.
	//
	VARIANT vHook;
	VariantInit(&vHook);
	vHook.vt = VT_DISPATCH;
	vHook.pdispVal = this;
	this->AddRef();

	DISPPARAMS params;
	memset(&params, 0, sizeof(DISPPARAMS));
	params.cArgs = 1;
	params.rgvarg = &vHook;

	CComPtr<IDispatch> scriptObj = doc->Script;

	DISPID dispId;
	OLECHAR *name = SysAllocString(L"__drip_replaceCreateElement");
	scriptObj->GetIDsOfNames(IID_NULL, &name, 1, LOCALE_SYSTEM_DEFAULT, &dispId);
	SysFreeString(name);

	scriptObj->Invoke(dispId, IID_NULL, LOCALE_SYSTEM_DEFAULT, DISPATCH_METHOD, &params, NULL, NULL, NULL);
	VariantClear(&vHook);
}

// Add all elements recursively from a given root element.
//
void JSHook::addElementRecursively(MSHTML::IHTMLElement* elem) {
	addElement(elem);

	MSHTML::IHTMLDOMNodePtr node = elem;
	MSHTML::IHTMLDOMNodePtr child = node->firstChild;
	while (child) {
		MSHTML::IHTMLElementPtr childElem = child;
		if (childElem)
			addElementRecursively(childElem);
		child = child->nextSibling;
	}
}

// Add all elements within a window, starting with its document's body.
//
void JSHook::addStaticElements(MSHTML::IHTMLWindow2Ptr wnd) {
	MSHTML::IHTMLElementPtr body = wnd->document->body;
	addElementRecursively(body);
}

// Collect all leaked elements, passing them to the specified leak dialog.
//
void JSHook::showLeaks(MSHTML::IHTMLWindow2Ptr wnd, CLeakDlg* dlg) {
	// Ensure that all garbage collection is completed so that elements will
	//   be released.
	//
	wnd->execScript(L"window.CollectGarbage()", L"javascript");

	for (std::set<Elem>::const_iterator it = m_elements.begin(); it != m_elements.end(); ++it) {
		Elem const& elem = *it;

		// For each element, AddRef() and Release() it.  The latter method will return
		//   the current ref count.
		//
		elem.unk->AddRef();
		int refCount = elem.unk->Release();

		// If any references (other than the one that we hold) are outstanding, then
		//   the element has been leaked.
		//
		if (refCount > 1)
			dlg->addElement(elem.unk, elem.url, refCount - 1);
	}

	// When finished, clear the element list.
	//
	clearElements();
}

// Returns true if the hook contains any elements.
//
bool JSHook::hasElements() {
	return (m_elements.size() > 0);
}

// Clear all elements in the hook.
//
void JSHook::clearElements() {
	for (std::set<Elem>::const_iterator it = m_elements.begin(); it != m_elements.end(); ++it) {
		Elem const& elem = *it;

		// Release the URL string and the element.
		//
		SysFreeString(elem.url);
		elem.unk->Release();
	}

	m_elements.clear();
}
