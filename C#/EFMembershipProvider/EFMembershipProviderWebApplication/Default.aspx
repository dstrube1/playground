<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EFMembershipProviderWebApplication._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>SmartSoft - Membership Provider for the Entity Framework</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server">
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
        
        <asp:GridView ID="GridView1" runat="server" DataSourceID="MembershipDataSource">
        </asp:GridView>
        <asp:ObjectDataSource ID="MembershipDataSource" runat="server" 
        SelectMethod="GetAllUsers" TypeName="System.Web.Security.Membership">
        </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>
