<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="HomeAdministrator.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="IdGreivance" DataSourceID="SqlDataSource1" 
            EnableModelValidation="True" AllowPaging="True" 
            CssClass="CSSTableGenerator">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" 
                    SortExpression="FirstName" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" 
                    SortExpression="LastName" />
                <asp:BoundField DataField="DateOfAction" HeaderText="TimeOfGreivance" 
                    SortExpression="DateOfAction" />
                <asp:BoundField DataField="Name" HeaderText="Department" 
                    SortExpression="Name" />
                <asp:BoundField DataField="Problem" HeaderText="Problem" 
                    SortExpression="Problem" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
            DeleteCommand="DELETE FROM [Greivances] WHERE [IdGreivance] = @IdGreivance" 
            InsertCommand="INSERT INTO [Greivances] ([IdUser], [IdDept], [Problem], [DateOfAction]) VALUES (@IdUser, @IdDept, @Problem, @DateOfAction)" 
            SelectCommand="SELECT Greivances.IdGreivance, Greivances.IdUser, Greivances.IdDept, Greivances.Problem, Greivances.DateOfAction, Departments.Name, Users.FirstName, Users.LastName FROM Greivances INNER JOIN Users ON Greivances.IdUser = Users.UserId INNER JOIN Departments ON Greivances.IdDept = Departments.IdDept" 
            
            UpdateCommand="UPDATE [Greivances] SET [IdUser] = @IdUser, [IdDept] = @IdDept, [Problem] = @Problem, [DateOfAction] = @DateOfAction WHERE [IdGreivance] = @IdGreivance" 
            onselecting="SqlDataSource1_Selecting">
            <DeleteParameters>
                <asp:Parameter Name="IdGreivance" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="IdUser" Type="Int32" />
                <asp:Parameter Name="IdDept" Type="Int32" />
                <asp:Parameter Name="Problem" Type="String" />
                <asp:Parameter Name="DateOfAction" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="IdUser" Type="Int32" />
                <asp:Parameter Name="IdDept" Type="Int32" />
                <asp:Parameter Name="Problem" Type="String" />
                <asp:Parameter Name="DateOfAction" Type="DateTime" />
                <asp:Parameter Name="IdGreivance" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    </p>
</asp:Content>

