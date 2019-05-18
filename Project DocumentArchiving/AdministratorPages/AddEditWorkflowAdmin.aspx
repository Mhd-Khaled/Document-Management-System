<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="AddEditWorkflowAdmin.aspx.cs" Inherits="ManagerPages_AddEditWorkflow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
        .style1
        {
        }
        .CSSTableGenerator
        {
            margin-right: 0px;
            width: 475px;
        }
        .style2
        {
            width: 158px;
        }
        .style4
        {
            width: 90px;
        }
        .style5
        {
            width: 75px;
        }
        .style6
        {
            width: 86px;
        }
        .style7
        {
            width: 331px;
        }
    </style>
    <script type="text/javascript">
        function Send() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are you sure that you want to insert this workflow?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <br />
    <br />
    <table style="width:100%;">
        <tr>
            <td class="style2">
                <asp:Label ID="Label1" runat="server" Text="Choose the Document :"></asp:Label>
            </td>
            <td class="style7">
                <asp:DropDownList ID="DocDList" runat="server" AutoPostBack="True" 
                    DataSourceID="DocSqlDataSource" DataTextField="DocumentName" 
                    DataValueField="IdDoc" style="position: relative; float: right" >
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1" colspan="2">
                <asp:SqlDataSource ID="DeptSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                    SelectCommand="SELECT * FROM [Departments]"></asp:SqlDataSource>
                <br />
                <br />
                <asp:SqlDataSource ID="DocSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                    SelectCommand="SELECT * FROM [Documents] ">
                </asp:SqlDataSource>
                <asp:GridView ID="WorkflowGridView" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="WorkflowSqlDataSource" EnableModelValidation="True" 
                    onselectedindexchanged="WorkflowGridView_SelectedIndexChanged" 
                    DataKeyNames="IdWorkflowDoc" Width="99%">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" ShowSelectButton="True" 
                            ButtonType="Image" CancelImageUrl="~/Images/remove.png" 
                            EditImageUrl="~/Images/EditWrench.png" HeaderText="Options" 
                            SelectImageUrl="~/Images/Recycle_Bin.png" 
                            UpdateImageUrl="~/Images/view_refresh.png" >
                        <ControlStyle Height="60px" Width="60px" />
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="NumOfStep" SortExpression="IdStep">
                            <EditItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("IdStep") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("IdStep") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Document" SortExpression="IdDoc">
                            <EditItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("IdDoc") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("DocumentName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Department" SortExpression="IdDept">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" 
                                    DataSourceID="DeptSqlDataSource" DataTextField="Name" DataValueField="IdDept" 
                                    SelectedValue='<%# Bind("IdDept") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="WorkflowSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                    DeleteCommand="DELETE FROM [WorkflowDocuments] WHERE [IdWorkflowDoc] = @IdWorkflowDoc" 
                    InsertCommand="INSERT INTO [WorkflowDocuments] ([IdStep], [IdDoc], [IdDept]) VALUES (@IdStep, @IdDoc, @IdDept)" 
                    SelectCommand="SELECT WorkflowDocuments.IdWorkflowDoc, WorkflowDocuments.IdStep, WorkflowDocuments.IdDoc, WorkflowDocuments.IdDept, Documents.DocumentName, Departments.Name FROM WorkflowDocuments INNER JOIN Departments ON WorkflowDocuments.IdDept = Departments.IdDept INNER JOIN Documents ON WorkflowDocuments.IdDoc = Documents.IdDoc WHERE (WorkflowDocuments.IdDoc = @doc)" 
                    
                    UpdateCommand="UPDATE [WorkflowDocuments] SET [IdStep] = @IdStep, [IdDoc] = @IdDoc, [IdDept] = @IdDept WHERE [IdWorkflowDoc] = @IdWorkflowDoc">
                    <DeleteParameters>
                        <asp:Parameter Name="IdWorkflowDoc" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="IdStep" Type="Int32" />
                        <asp:Parameter Name="IdDoc" Type="Int32" />
                        <asp:Parameter Name="IdDept" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DocDList" Name="doc" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="IdStep" Type="Int32" />
                        <asp:Parameter Name="IdDoc" Type="Int32" />
                        <asp:Parameter Name="IdDept" Type="Int32" />
                        <asp:Parameter Name="IdWorkflowDoc" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <br />
            </td>
            <td class="style1" rowspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1" colspan="2">
                <table  class="CSSTableGenerator">
                    <tr>
                        <td class="style6">
                            <asp:Label ID="Label4" runat="server" Text="Next Step : "></asp:Label>
                        </td>
                        <td class="style5">
                            <asp:Button ID="Insert" runat="server" onclick="Insert_Click" Text="Insert" 
                                Height="36px" Width="60px" onclientclick="Send()" 
                                ToolTip="Add new workflow to document" />
                        </td>
                        <td class="style4">
                            <asp:Label ID="StepLabel" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DeptInsertDList" runat="server" 
                                DataSourceID="DeptSqlDataSource" DataTextField="Name" DataValueField="IdDept">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    </asp:Content>

