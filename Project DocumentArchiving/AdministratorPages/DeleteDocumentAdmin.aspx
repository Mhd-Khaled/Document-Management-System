<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="DeleteDocumentAdmin.aspx.cs" Inherits="DeleteDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">

        .style2
        {
            width: 166px;
        }
    </style>
        <script type="text/javascript">
            function Send() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                alert("This action will delete all nounpapers that belong to this document.");
                if (confirm("Are you still sure that you want to delete this document?")) {
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
        Width="557px">

    <table class="CSSTableGenerator" >
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label2" runat="server" Text="Department Name :"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="DeptDList" runat="server" AutoPostBack="True" 
                DataSourceID="DeptSqlDataSource" DataTextField="Name" DataValueField="IdDept">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label1" runat="server" Text="Document Name :"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="DocDList" runat="server" DataSourceID="DocSqlDataSource" 
                DataTextField="DocumentName" DataValueField="IdDoc">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" Text="Delete Document" Width="118px" 
                onclick="Button1_Click" onclientclick="Send()" />
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:SqlDataSource ID="DocSqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                SelectCommand="SELECT * FROM [Documents] WHERE ([IdDept] = @IdDept)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DeptDList" Name="IdDept" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="DeptSqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                SelectCommand="SELECT * FROM [Departments]"></asp:SqlDataSource>
        </td>
        <td>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                style="margin-left: 0px" />
        </td>
    </tr>
</table>
</asp:Panel>
</asp:Content>

