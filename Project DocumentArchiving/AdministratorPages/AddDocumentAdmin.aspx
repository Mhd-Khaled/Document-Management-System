<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="AddDocumentAdmin.aspx.cs" Inherits="Add_Document" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
    .style1
    {
            width: 231px;
        }
        .CSSTableGenerator
        {
            margin-right: 0px;
        }
        .style2
        {
            width: 64px;
        }
    </style>
<script type="text/javascript">
    function Send() {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
        if (confirm("Are you sure that you want to add this document?")) {
            confirm_value.value = "Yes";
        } else {
            confirm_value.value = "No";
        }
        document.forms[0].appendChild(confirm_value);
    }
    function Insert() {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
        if (confirm("Are you sure that you want to add this NounPaper?")) {
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
        Width="575px" >
    <table class="CSSTableGenerator" >
    <tr>
        <td class="style1">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style1">
            <asp:Label ID="Label1" runat="server" Text="Document Name :"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="DocumentNameTBox" runat="server" ValidationGroup="A"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="DocumentNameTBox" 
                ErrorMessage="Please Enter Document Name" EnableTheming="True" 
                ValidationGroup="A">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style1">
            <asp:Label ID="Label2" runat="server" Text="Department Name :"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="DepartmentDList" runat="server" AutoPostBack="True" 
                DataSourceID="DeptSqlDataSource" DataTextField="Name" DataValueField="IdDept" 
                style="width: 88px" ValidationGroup="A" >
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style1">
            &nbsp;</td>
        <td style="font-weight: 700">
            <asp:Button ID="Button1" runat="server" Text="Add Document" Width="128px" 
                onclick="Button1_Click" onclientclick="Send()" ValidationGroup="A" 
                ToolTip="Add new document" />
        </td>
    </tr>
</table>
    <asp:SqlDataSource ID="DeptSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT * FROM [Departments]"></asp:SqlDataSource>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <br />
    <br />
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
        DataSourceID="DocSqlDataSource" DataTextField="DocumentName" 
        DataValueField="IdDoc">
    </asp:DropDownList>
    <br />
    <asp:SqlDataSource ID="DocSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT * FROM [Documents] WHERE ([IdDept] = @IdDept)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DepartmentDList" Name="IdDept" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="IdDocDetail" DataSourceID="DocDetailSqlDataSource" 
        EnableModelValidation="True" CssClass="CSSTableGenerator">
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/remove.png" 
                CancelText="" DeleteImageUrl="~/Images/Recycle_Bin.png" 
                EditImageUrl="~/Images/EditWrench.png" HeaderText="Options" 
                ShowDeleteButton="True" ShowEditButton="True" 
                UpdateImageUrl="~/Images/view_refresh.png">
            <ControlStyle Height="60px" Width="60px" />
            <ItemStyle HorizontalAlign="Left" Wrap="True" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="NumNounPaper" SortExpression="NumNounPaper">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("NumNounPaper") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("NumNounPaper") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="IdDoc" SortExpression="IdDoc">
                <EditItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("IdDoc") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IdDoc") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="NameOfNounPaper" HeaderText="NameOfNounPaper" 
                SortExpression="NameOfNounPaper" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="DocDetailSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        DeleteCommand="DELETE FROM [DocDetails] WHERE [IdDocDetail] = @IdDocDetail" 
        InsertCommand="INSERT INTO [DocDetails] ([NumNounPaper], [NameOfNounPaper], [IdDoc]) VALUES (@NumNounPaper, @NameOfNounPaper, @IdDoc)" 
        SelectCommand="SELECT DocDetails.IdDocDetail, DocDetails.NumNounPaper, DocDetails.NameOfNounPaper, DocDetails.IdDoc, Documents.IdDept FROM DocDetails INNER JOIN Documents ON DocDetails.IdDoc = Documents.IdDoc WHERE (DocDetails.IdDoc = @IdDoc) AND (Documents.IdDept = @IdDept)" 
        
        UpdateCommand="UPDATE [DocDetails] SET [NumNounPaper] = @NumNounPaper, [NameOfNounPaper] = @NameOfNounPaper, [IdDoc] = @IdDoc WHERE [IdDocDetail] = @IdDocDetail">
        <DeleteParameters>
            <asp:Parameter Name="IdDocDetail" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="NumNounPaper" Type="Byte" />
            <asp:Parameter Name="NameOfNounPaper" Type="String" />
            <asp:Parameter Name="IdDoc" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="IdDoc" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DepartmentDList" Name="IdDept" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="NumNounPaper" Type="Byte" />
            <asp:Parameter Name="NameOfNounPaper" Type="String" />
            <asp:Parameter Name="IdDoc" Type="Int32" />
            <asp:Parameter Name="IdDocDetail" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:Label ID="Label5" runat="server" Text="Add Document's Attachment"></asp:Label>
    <br />
    <table style="width: 78%;" class="CSSTableGenerator">
        <tr>
            <td class="style2">
                <asp:Button ID="InsertBtn" runat="server" onclick="InsertBtn_Click" 
                    onclientclick="Insert()" Text="Insert" ValidationGroup="B" Height="34px" 
                    Width="63px" ToolTip="Add nounpaper to document" />
            </td>
            <td>
                <asp:TextBox ID="NameNounPaperTxt" runat="server" ValidationGroup="B" 
                    Height="30px" Width="154px"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="NameNounPaperTxt" ErrorMessage="it is Required Field." 
                    ValidationGroup="B"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
</asp:Panel>
</asp:Content>

