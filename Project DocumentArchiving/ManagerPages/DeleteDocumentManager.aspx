<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="DeleteDocumentManager.aspx.cs" Inherits="DeleteDocument" %>

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

                alert("This action will delete all nounpapers that belong to this document"); 
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
            <asp:Label ID="Label1" runat="server" Text="Documetn Name :"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="DropDownList1" runat="server" 
                DataSourceID="DeptSqlDataSource" DataTextField="DocumentName" 
                DataValueField="IdDoc">
            </asp:DropDownList>
            <asp:SqlDataSource ID="DeptSqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                SelectCommand="SELECT * FROM [Documents] WHERE ([IdDept] = @IdDept)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField1" Name="IdDept" 
                        PropertyName="Value" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label2" runat="server" Text="Department Name :"></asp:Label>
        </td>
        <td>
            <asp:Label ID="DepartmentNameLable" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:HiddenField ID="HiddenField1" runat="server" />
        </td>
        <td>
            <asp:Button ID="Button1" runat="server" Text="Delete Document" Width="118px" 
                onclick="Button1_Click" style="height: 26px" onclientclick="Send()" />
        </td>
    </tr>
</table>
</asp:Panel>
</asp:Content>

