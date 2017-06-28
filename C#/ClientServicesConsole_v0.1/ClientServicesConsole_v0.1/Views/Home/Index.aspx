<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Client Services Console
</asp:Content>
<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
            <hgroup class="title">
                <h1>
                    Client Services Console</h1>
					<br/>
                <h2>
                    <%: ViewBag.Message %>
				</h2>
            </hgroup>
            
</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <script runat="server">
      void Button_Click(Object sender, EventArgs e) 
      {
		Label1.Text = "You selected: " + ddlAction.SelectedItem.Text + ".";         
      }
   </script>
   <script language="javascript">
       function t1() {
           alert("blah");
       }
   </script>
    <form id="Form1" runat="server">
    <asp:DropDownList runat="server" ID="ddlAction" OnSelectedIndexChanged="Button_Click">
	    <asp:ListItem>New PI Publisher</asp:ListItem>
	     <asp:ListItem>Move client</asp:ListItem>
         <asp:ListItem>Other functionality</asp:ListItem>
    </asp:DropDownList>
    <br><br>
      <asp:Button id="Button1" Text="Submit" OnClick="Button_Click" runat="server"/>
      <br><br>
      <asp:Label id="Label1" runat="server" Text="Blah"/>
   </form>
<!--
http://www.w3schools.com/aspnet/control_dropdownlist.asp
http://www.codeproject.com/Articles/30514/Custom-membership-provider-for-the-ADO-NET-Entity
http://stackoverflow.com/questions/6600939/how-to-make-sql-membership-provider-and-entity-framework-work-using-my-database
http://www.asp.net/mvc/videos/iis/developing-and-deploying-in-a-shared-hosting
^interesting around 33:00
http://www.asp.net/mvc/videos/iis/troubleshooting-production-aspnet-apps
-->
</asp:Content>
