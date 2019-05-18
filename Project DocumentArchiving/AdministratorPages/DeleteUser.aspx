<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="DeleteUser.aspx.cs" Inherits="DeleteUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">

    .style1
    {
        width: 166px;
    }
        .style2
        {
            width: 298px;
        }
    </style>
    <script type="text/javascript">
        function Send() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are you sure that you want to delete this User?")) {
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
        Width="462px" >
    <table class="CSSTableGenerator">
    <tr>
        <td class="style1">
            &nbsp;</td>
        <td class="style2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style1">
            <asp:Label ID="Label11" runat="server" Text="Id user :"></asp:Label>
        </td>
        <td class="style2">
            <asp:TextBox ID="IdUserTBox" runat="server"></asp:TextBox>
            <asp:ImageButton ID="ImageButton1" runat="server" Height="30px" 
                ImageUrl="~/Images/Find.png" onclick="ImageButton1_Click" 
                ToolTip="Find " Width="30px" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="IdUserTBox" ErrorMessage="Please Enter Id User">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToValidate="IdUserTBox" ErrorMessage="Please Enter Number" 
                Operator="DataTypeCheck" Type="Integer">Please Enter Number</asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="style1">
            <asp:Label ID="Label7" runat="server" Text="FirstName :"></asp:Label>
        </td>
        <td class="style2">
            <asp:Label ID="FirstNameLablel" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style1">
            <asp:Label ID="Label1" runat="server" Text="LastName :"></asp:Label>
        </td>
        <td class="style2">
            <asp:Label ID="LastNameLabel" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;</td>
        <td class="style2">
            <asp:Button ID="Button1" runat="server" Text="Delete User" Width="126px" 
                onclick="Button1_Click" onclientclick="Send()" />
        </td>
    </tr>
</table>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
</asp:Panel>
</asp:Content>

