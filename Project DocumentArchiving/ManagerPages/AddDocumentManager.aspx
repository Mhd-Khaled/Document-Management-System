<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="AddDocumentManager.aspx.cs" Inherits="Add_Document" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
    .style1
    {
            width: 231px;
        }
        .style2
        {
            width: 73px;
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
            <asp:Label ID="DepartmentNameLable" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style1">
            <asp:HiddenField ID="HiddenField1" runat="server" />
        </td>
        <td style="font-weight: 700">
            <asp:Button ID="Button1" runat="server" Text="Add Document" Width="128px" 
                onclick="Button1_Click" onclientclick="Send()" ValidationGroup="A" />
        </td>
    </tr>
</table>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <br />
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
        DataSourceID="DocSqlDataSource" DataTextField="DocumentName" 
        DataValueField="IdDoc">
    </asp:DropDownList>
    <br />
    <asp:SqlDataSource ID="DocSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT * FROM [Documents] WHERE ([IdDept] = @IdDept2)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="IdDept2" 
                PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="IdDocDetail" DataSourceID="DocDetailSqlDataSource" 
        EnableModelValidation="True" CssClass="CSSTableGenerator">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ButtonType="Image" CancelImageUrl="~/Images/remove.png" 
                DeleteImageUrl="~/Images/Recycle_Bin.png" 
                EditImageUrl="~/Images/EditWrench.png" HeaderText="Options" 
                UpdateImageUrl="~/Images/view_refresh.png" >
            <ControlStyle Height="60px" Width="60px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="NumNounPaper" SortExpression="NumNounPaper">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("NumNounPaper") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("NumNounPaper") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="IdDoc" SortExpression="IdDoc">
                <EditItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("IdDoc") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("IdDoc") %>'></asp:Label>
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
        SelectCommand="SELECT * FROM [DocDetails] WHERE ([IdDoc] = @IdDoc)" 
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
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="NumNounPaper" Type="Byte" />
            <asp:Parameter Name="NameOfNounPaper" Type="String" />
            <asp:Parameter Name="IdDoc" Type="Int32" />
            <asp:Parameter Name="IdDocDetail" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <table style="width: 100%;" class="CSSTableGenerator">
        <tr>
            <td class="style2">
                <asp:Button ID="InsertBtn" runat="server" onclick="InsertBtn_Click" 
                    onclientclick="Insert()" Text="Insert" ValidationGroup="B" Height="34px" 
                    ToolTip="Add noun paper to document " Width="74px" />
            </td>
            <td>
                <asp:TextBox ID="NameNounPaperTxt" runat="server" ValidationGroup="B" 
                    Height="28px" Width="148px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="NameNounPaperTxt" ErrorMessage="it is Required Field." 
                    ValidationGroup="B"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
</asp:Panel>
</asp:Content>

