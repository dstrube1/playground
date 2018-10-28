#pragma once

class CLeakDlg;

// This structure is used to maintain a list of hooked elements,
//   along with the URL of the document to which each belongs.
//
struct Elem {
	Elem(IUnknown* unk, BSTR url) {
		this->unk = unk;
		this->url = url;
	}

	bool operator<(Elem const& other) const {
		return (unk < other.unk);
	}

	bool operator==(Elem const& other) const {
		return (unk == other.unk);
	}

	IUnknown*	unk;
	BSTR		url;
};

class __declspec(uuid("8340a7f2-413a-46dd-9f95-fbad5d455a90")) IJSHook: public IDispatch { };

// The JSHook class serves two purposes.  First, it implements a simple IDispatch interface
//   that is callable from JavaScript.  Its sole method, logElement(elem), is called whenever
//   an element is created dynamically.  Each such element is stored in a set, along with all
//   of the static elements.  When the user wants to detect leaks, this class goes through the
//   list, determining which elements have a reference count greater than 1 (JSHook keeps one
//   reference on all elements in order to keep them alive).
//
class JSHook: public IJSHook, public ATL::CComObjectRoot {
private:
	void addElement(MSHTML::IHTMLElement* elem);
	void addElement(MSHTML::IHTMLElement* elem, MSHTML::IHTMLDocument2* doc);
	void addElementRecursively(MSHTML::IHTMLElement* elem);
	void clearElements();

	std::set<Elem> m_elements;

public:
	virtual ~JSHook();

	void hookNewPage(MSHTML::IHTMLDocument2Ptr wnd);
	void addStaticElements(MSHTML::IHTMLWindow2Ptr wnd);
	void showLeaks(MSHTML::IHTMLWindow2Ptr wnd, CLeakDlg* dlg);
	bool hasElements();

	BEGIN_COM_MAP(JSHook)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(IJSHook)
	END_COM_MAP()

	STDMETHOD(GetTypeInfoCount)(UINT *pctinfo);
	STDMETHOD(GetTypeInfo)(UINT iTInfo, LCID lcid, ITypeInfo **ppTInfo);
	STDMETHOD(GetIDsOfNames)(REFIID iid, OLECHAR **names, UINT nameCount, LCID lcid, DISPID *dispIds);
	STDMETHOD(Invoke)(DISPID dispId, REFIID riid, LCID lcid, WORD flags, DISPPARAMS *dispParams, VARIANT *result,
		EXCEPINFO *exInfo, UINT *argErr);
};
