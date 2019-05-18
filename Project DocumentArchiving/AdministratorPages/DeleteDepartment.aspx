<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="DeleteDepartment.aspx.cs" Inherits="DeleteDepartment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">

        .style4
        {
            width: 176px;
        }
        .style5
        {
            width: 356px;
        }
    </style>
    <script type="text/javascript">
            function Send() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                alert("This Action will delete all users in this Department.");
                if (confirm("Are you still sure that you want to delete this department?")) {
                
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
        Width="446px" Height="218px" >
    <table class="CSSTableGenerator" >
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style5">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style4">
            <asp:Label ID="Label2" runat="server" Text="Department Name :"></asp:Label>
        </td>
        <td class="style5">
            <asp:DropDownList ID="IdDepartmrntDList" runat="server" AutoPostBack="True" 
                DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="IdDept">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="IdDepartmrntDList" 
                ErrorMessage="Please check Department Id">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style5">
            <asp:Button ID="Button1" runat="server" Text="Delete Department" 
                Width="123px" onclick="Button1_Click" onclientclick="Send()" />
        </td>
    </tr>
</table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
            SelectCommand="SELECT * FROM [Departments]"></asp:SqlDataSource>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        <br />
</asp:Panel>
</asp:Content>

