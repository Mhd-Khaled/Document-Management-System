<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="AddDepartment.aspx.cs" Inherits="AddDepartment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
    .style1
    {
        width: 195px;
    }
        .style2
        {
            width: 146px;
        }
    </style>
        <script type="text/javascript">
            function Send() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Are you sure that you want to add this department?")) {
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
        Width="545px" >
    <table class="CSSTableGenerator" >
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label1" runat="server" Text="Id Department :"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="IdDepartmentTBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="IdDepartmentTBox" 
                ErrorMessage="Please Enter Id Department">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator2" runat="server" 
                ControlToValidate="IdDepartmentTBox" ErrorMessage="Please Enter Number" 
                Operator="DataTypeCheck" Type="Integer">Please Enter Number</asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label2" runat="server" Text="Department Name :"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="DepartmentNameTBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="DepartmentNameTBox" 
                ErrorMessage="Please Enter Department Name">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label3" runat="server" Text="Phone :"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="PhoneTBox" runat="server"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToValidate="PhoneTBox" ErrorMessage="Please Enter Number" 
                Operator="DataTypeCheck" Type="Integer">Please Enter Number</asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                Text="Add Department" Width="128px" onclientclick="Send()" />
        </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        </td>
    </tr>
</table>
</asp:Panel>
</asp:Content>

