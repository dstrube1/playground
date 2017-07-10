<?xml version="1.0" encoding="UTF-8" standalone="no"?><wsdl:definitions xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://components.sqLite" xmlns:intf="http://components.sqLite" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xmlns:tns1="http://rpc.xml.coldfusion" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" targetNamespace="http://components.sqLite">
  <wsdl:types>
    <schema xmlns="http://www.w3.org/2001/XMLSchema" xmlns:ns3="http://components.sqLite" xmlns:ns5="http://components.sqLite" targetNamespace="http://components.sqLite">
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
  <xsd:element name="getUsers"><xsd:complexType><xsd:sequence/></xsd:complexType></xsd:element><xsd:element name="getUsersResponse"><xsd:complexType><xsd:sequence><xsd:element form="unqualified" name="getUsersReturn" type="ns3:ArrayOf_xsd_anyType"/></xsd:sequence></xsd:complexType></xsd:element><xsd:element name="getUsers"><xsd:complexType><xsd:sequence/></xsd:complexType></xsd:element><xsd:element name="getUsersResponse"><xsd:complexType><xsd:sequence><xsd:element form="unqualified" name="getUsersReturn" type="ns5:ArrayOf_xsd_anyType"/></xsd:sequence></xsd:complexType></xsd:element></schema>
    <schema xmlns="http://www.w3.org/2001/XMLSchema" targetNamespace="http://rpc.xml.coldfusion">
   <import namespace="http://components.sqLite"/>
   <import namespace="http://xml.apache.org/xml-soap"/>
   <import namespace="http://schemas.xmlsoap.org/soap/encoding/"/>
   <complexType name="CFCInvocationException">
    <sequence/>
   </complexType>
   <complexType name="QueryBean">
    <sequence>
     <element name="columnList" nillable="true" type="impl:ArrayOf_xsd_string"/>
     <element name="data" nillable="true" type="impl:ArrayOfArrayOf_xsd_anyType"/>
    </sequence>
   </complexType>
  </schema>
    <schema xmlns="http://www.w3.org/2001/XMLSchema" targetNamespace="http://xml.apache.org/xml-soap">
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
  </wsdl:types>
  <wsdl:message name="getUsersResponse">
    <wsdl:part name="getUsersReturn" type="impl:ArrayOf_xsd_anyType">
    </wsdl:part>
  </wsdl:message>
  <wsdl:message name="getUsersRequest">
  </wsdl:message>
  <wsdl:message name="CFCInvocationException">
    <wsdl:part name="fault" type="tns1:CFCInvocationException">
    </wsdl:part>
  </wsdl:message>
  <wsdl:portType name="UserService">
    <wsdl:operation name="getUsers">
      <wsdl:input message="impl:getUsersRequest" name="getUsersRequest">
    </wsdl:input>
      <wsdl:output message="impl:getUsersResponse" name="getUsersResponse">
    </wsdl:output>
      <wsdl:fault message="impl:CFCInvocationException" name="CFCInvocationException">
    </wsdl:fault>
    </wsdl:operation>
  </wsdl:portType>
  <wsdl:binding name="UserService.cfcSoapBinding" type="impl:UserService">
    <wsdlsoap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http"/>
    <wsdl:operation name="getUsers">
      <wsdlsoap:operation soapAction=""/>
      <wsdl:input name="getUsersRequest">
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://components.sqLite" use="encoded"/>
      </wsdl:input>
      <wsdl:output name="getUsersResponse">
        <wsdlsoap:body encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" namespace="http://components.sqLite" use="encoded"/>
      </wsdl:output>
      <wsdl:fault name="CFCInvocationException">
        <wsdlsoap:fault encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" name="CFCInvocationException" namespace="http://components.sqLite" use="encoded"/>
      </wsdl:fault>
    </wsdl:operation>
  </wsdl:binding>
  <wsdl:service name="UserServiceService">
    <wsdl:port binding="impl:UserService.cfcSoapBinding" name="UserService.cfc">
      <wsdlsoap:address location="http://localhost:8500/sqLite/components/UserService.cfc"/>
    </wsdl:port>
  </wsdl:service>
</wsdl:definitions>