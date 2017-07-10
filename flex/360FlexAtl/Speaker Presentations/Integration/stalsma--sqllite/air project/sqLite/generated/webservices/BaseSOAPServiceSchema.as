package generated.webservices
{
	 import mx.rpc.xml.Schema
	 public class BaseSOAPServiceSchema
	{
		 public var schemas:Array = new Array();
		 public var targetNamespaces:Array = new Array();
		 public function BaseSOAPServiceSchema():void
{		
			 var xsdXML1:XML = <schema xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://components.sqLite" xmlns:intf="http://components.sqLite" xmlns:ns0="http://components.sqLite" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns1="http://rpc.xml.coldfusion" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" attributeFormDefault="unqualified" elementFormDefault="unqualified" targetNamespace="http://rpc.xml.coldfusion" xmlns="http://www.w3.org/2001/XMLSchema">
    <import namespace="http://components.sqLite"/>
    <import namespace="http://xml.apache.org/xml-soap"/>
    <import namespace="http://schemas.xmlsoap.org/soap/encoding/"/>
    <complexType name="CFCInvocationException">
        <sequence/>
    </complexType>
    <complexType name="QueryBean">
        <sequence>
            <element name="columnList" nillable="true" type="intf:ArrayOf_xsd_string"/>
            <element name="data" nillable="true" type="intf:ArrayOfArrayOf_xsd_anyType"/>
        </sequence>
    </complexType>
</schema>
;
			 var xsdSchema1:Schema = new Schema(xsdXML1);
			schemas.push(xsdSchema1);
			targetNamespaces.push(new Namespace('','http://rpc.xml.coldfusion'));
			 var xsdXML2:XML = <schema xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://components.sqLite" xmlns:intf="http://components.sqLite" xmlns:ns0="http://components.sqLite" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns1="http://rpc.xml.coldfusion" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" attributeFormDefault="unqualified" elementFormDefault="unqualified" targetNamespace="http://xml.apache.org/xml-soap" xmlns="http://www.w3.org/2001/XMLSchema">
    <import namespace="http://components.sqLite"/>
    <import namespace="http://rpc.xml.coldfusion"/>
    <import namespace="http://schemas.xmlsoap.org/soap/encoding/"/>
    <complexType name="mapItem">
        <sequence>
            <element name="key" nillable="true" type="xsd:anyType"/>
            <element name="value" nillable="true" type="xsd:anyType"/>
        </sequence>
    </complexType>
    <complexType name="Map">
        <sequence>
            <element maxOccurs="unbounded" minOccurs="0" name="item" type="apachesoap:mapItem"/>
        </sequence>
    </complexType>
</schema>
;
			 var xsdSchema2:Schema = new Schema(xsdXML2);
			schemas.push(xsdSchema2);
			targetNamespaces.push(new Namespace('','http://xml.apache.org/xml-soap'));
			 var xsdXML0:XML = <schema xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://components.sqLite" xmlns:intf="http://components.sqLite" xmlns:ns0="http://components.sqLite" xmlns:ns3="http://components.sqLite" xmlns:ns5="http://components.sqLite" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns1="http://rpc.xml.coldfusion" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" attributeFormDefault="unqualified" elementFormDefault="unqualified" targetNamespace="http://components.sqLite" xmlns="http://www.w3.org/2001/XMLSchema">
    <import namespace="http://xml.apache.org/xml-soap"/>
    <import namespace="http://rpc.xml.coldfusion"/>
    <import namespace="http://schemas.xmlsoap.org/soap/encoding/"/>
    <complexType name="ArrayOf_xsd_anyType">
        <complexContent>
            <restriction base="soapenc:Array">
                <attribute ref="soapenc:arrayType" wsdl:arrayType="xsd:anyType[]"/>
            </restriction>
        </complexContent>
    </complexType>
    <complexType name="ArrayOf_xsd_string">
        <complexContent>
            <restriction base="soapenc:Array">
                <attribute ref="soapenc:arrayType" wsdl:arrayType="xsd:string[]"/>
            </restriction>
        </complexContent>
    </complexType>
    <complexType name="ArrayOfArrayOf_xsd_anyType">
        <complexContent>
            <restriction base="soapenc:Array">
                <attribute ref="soapenc:arrayType" wsdl:arrayType="xsd:anyType[][]"/>
            </restriction>
        </complexContent>
    </complexType>
    <element name="getUsers">
        <complexType>
            <sequence/>
        </complexType>
    </element>
    <element name="getUsersResponse">
        <complexType>
            <sequence>
                <element form="unqualified" name="getUsersReturn" type="intf:ArrayOf_xsd_anyType"/>
            </sequence>
        </complexType>
    </element>
    <element name="getUsers">
        <complexType>
            <sequence/>
        </complexType>
    </element>
    <element name="getUsersResponse">
        <complexType>
            <sequence>
                <element form="unqualified" name="getUsersReturn" type="intf:ArrayOf_xsd_anyType"/>
            </sequence>
        </complexType>
    </element>
</schema>
;
			 var xsdSchema0:Schema = new Schema(xsdXML0);
			schemas.push(xsdSchema0);
			targetNamespaces.push(new Namespace('','http://components.sqLite'));
			xsdSchema1.addImport(new Namespace("http://components.sqLite"), xsdSchema0)
			xsdSchema2.addImport(new Namespace("http://rpc.xml.coldfusion"), xsdSchema1)
			xsdSchema0.addImport(new Namespace("http://rpc.xml.coldfusion"), xsdSchema1)
			xsdSchema2.addImport(new Namespace("http://components.sqLite"), xsdSchema0)
			xsdSchema1.addImport(new Namespace("http://xml.apache.org/xml-soap"), xsdSchema2)
			xsdSchema0.addImport(new Namespace("http://xml.apache.org/xml-soap"), xsdSchema2)
		}
	}
}