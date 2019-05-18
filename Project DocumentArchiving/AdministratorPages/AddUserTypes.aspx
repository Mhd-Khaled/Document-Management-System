<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="AddUserTypes.aspx.cs" Inherits="AddUserTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
        .style1
        {
            width: 176px;
        }
        .style2
        {
            width: 286px;
        }
    </style>
        <script type="text/javascript">
            function Send() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Are you sure that you want to add this type of user?")) {
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
        Width="483px" >
    <table class="CSSTableGenerator" >
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label1" runat="server" Text="Id Type User :"></asp:Label>
            </td>
            <td class="style2">
                <asp:TextBox ID="IdTypeUserTBox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="IdTypeUserTBox" 
                    ErrorMessage="Please Enter Id Type User">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
                    ControlToValidate="IdTypeUserTBox" ErrorMessage="Please Enter Number" 
                    Operator="DataTypeCheck" Type="Integer">Please Enter Number</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:Label ID="Label2" runat="server" Text="Name Type User :"></asp:Label>
            </td>
            <td class="style2">
                <asp:TextBox ID="NameTypeUserTBox" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="NameTypeUserTBox" 
                    ErrorMessage="Please Enter Name Type User">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style2">
                <asp:Button ID="Button1" runat="server" Height="26px" Text="Add Type User" 
                    Width="103px" onclick="Button1_Click" onclientclick="Send()" />
            </td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style2">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    </asp:Panel>
</asp:Content>

