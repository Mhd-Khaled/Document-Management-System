<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="AddUser.aspx.cs" Inherits="AddEmploayee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />

  <link rel="stylesheet" href="../Scripts/jquery-ui-1.11.4.custom/jquery-ui.css"/>
  <script type="text/javascript" src="../Scripts/jquery-ui-1.11.4.custom/external/jquery/jquery.js"></script>
  <script type="text/javascript"src="../Scripts/jquery-ui-1.11.4.custom/jquery-ui.js"></script>
  <script type="text/javascript">
      $(document).ready(function () {
          $("#<%=DateOfBirthTBox.ClientID %>").datepicker({ changeMonth: true, changeYear: true, "yearRange":
        '<%=(System.DateTime.Now.Year - 100).ToString()%> :<%=System.DateTime.Now.Year.ToString() %>'
          });
      });
  </script>    
  
  <style type="text/css">
        .style1
    {
        }
    .style2
    {
        width: 366px;
    }
    .style3
    {
        width: 109px;
    }
    .style4
    {
        width: 563px;
    }
        .style5
        {
            width: 97px;
        }
    </style>
    <script type="text/javascript">
        function Send() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are you sure that you want to add this user?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Panel ID="Panel1" runat="server" BackColor="#FDFFFF" ScrollBars="Vertical" 
        Width="448px" >
    <table class="CSSTableGenerator" >
    <tr>
        <td class="style5">
            &nbsp;</td>
        <td class="style2" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label11" runat="server" Text="Id user :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:TextBox ID="IdUserTBox" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="IdUserTBox" ErrorMessage="Please Enter The ID">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToValidate="IdUserTBox" ErrorMessage="Please Enter Number" 
                Operator="DataTypeCheck" Type="Integer">Please Enter Number</asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label7" runat="server" Text="FirstName :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:TextBox ID="FirstNameTBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="FirstNameTBox" ErrorMessage="Please Enter FirstName">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator1" runat="server" 
                ControlToValidate="FirstNameTBox" ErrorMessage="name can not have  numbers" 
                onservervalidate="CustomValidator1_ServerValidate">*</asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label1" runat="server" Text="LastName :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:TextBox ID="LastNameTBox" runat="server" 
                ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="LastNameTBox" ErrorMessage="Please Enter LastName">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator2" runat="server" 
                ErrorMessage="name can not have  numbers" 
                onservervalidate="CustomValidator2_ServerValidate">*</asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label2" runat="server" Text="Date Of Birth :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
                <asp:TextBox ID="DateOfBirthTBox" runat="server" 
                 ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="DateOfBirthTBox" ErrorMessage="Please Enter Date">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label5" runat="server" Text="Email :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:TextBox ID="EmailTBox" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="EmailTBox" ErrorMessage="Please Enter a Valid E-mail" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Please Enter a Valid E-mail</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="style1" colspan="3">
            &nbsp;</td>
    </tr>
        <tr>
        <td class="style5">
            <asp:Label ID="Label10" runat="server" Text="Department Name :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:DropDownList ID="DepartmentNameDList" runat="server" 
                DataSourceID="DeptSqlDataSource" DataTextField="Name" DataValueField="IdDept">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ControlToValidate="DepartmentNameDList" 
                ErrorMessage="Please Select Department">*</asp:RequiredFieldValidator>
        </td>
        </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label3" runat="server" Text="Type User :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:DropDownList ID="TypeUserDlist" runat="server" 
                DataSourceID="UserSqlDataSource" DataTextField="TypeUser" DataValueField="TypeUserId" 
                >
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ControlToValidate="TypeUserDlist" ErrorMessage="please Select Type User">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style1" colspan="3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label6" runat="server" Text="Type Login :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:DropDownList ID="TypeLoginDList" runat="server">
                <asp:ListItem>Normal</asp:ListItem>
                <asp:ListItem>Administrator</asp:ListItem>
                <asp:ListItem>Manager</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                ControlToValidate="TypeLoginDList" ErrorMessage="Please Select Type Login">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label8" runat="server" Text="UserName :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:TextBox ID="UserNameTBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                ControlToValidate="UserNameTBox" ErrorMessage="Please Enter UserName">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label9" runat="server" Text="Password :"></asp:Label>
        </td>
        <td class="style2" colspan="2">
            <asp:TextBox ID="PasswordTBox" runat="server" style="height: 22px" 
                TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                ControlToValidate="PasswordTBox" ErrorMessage="Please Enter Password">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style5">
            <asp:Label ID="Label12" runat="server" Text="is Active :"></asp:Label>
        </td>
        <td class="style3">
            <asp:RadioButtonList ID="IsActiveRList" runat="server" Width="112px">
                <asp:ListItem Value="1" Selected="True">Enable</asp:ListItem>
                <asp:ListItem Value="0">Disable</asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="style4">
            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                ControlToValidate="IsActiveRList" 
                ErrorMessage="Please Cheak Enable / Disable">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style1" colspan="3">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style5">
            &nbsp;</td>
        <td class="style2" colspan="2">
            <asp:Button ID="Button1" runat="server" Text="Add User" Width="129px" 
                onclick="Button1_Click" onclientclick="Send()" />
        </td>
    </tr>
</table>
    <asp:SqlDataSource ID="DeptSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT * FROM [Departments]"></asp:SqlDataSource>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        style="direction: ltr" />
    <br />
    <asp:SqlDataSource ID="UserSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT * FROM [UserTypes]"></asp:SqlDataSource>
</asp:Panel>
</asp:Content>

