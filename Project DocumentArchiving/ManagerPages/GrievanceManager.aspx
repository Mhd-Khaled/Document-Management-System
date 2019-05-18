<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="GrievanceManager.aspx.cs" Inherits="grievance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style type="text/css">
    .style1
    {
            width: 141px;
        }
    .style2
    {
        width: 141px;
        height: 202px;
    }
    .style4
    {
        width: 395px;
    }
    .style5
    {
        width: 395px;
    }
        .style6
        {
            width: 126px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table style="width:100%;">
        <tr>
            <td class="style1">
                <asp:ListBox ID="ListBox1" runat="server" AutoPostBack="True" 
                    DataSourceID="GreivanceSqlDataSource" DataTextField="IdUser" 
                    DataValueField="IdGreivance" 
                    onselectedindexchanged="ListBox1_SelectedIndexChanged" Width="226px"></asp:ListBox>
            </td>
            <td class="style6">
                &nbsp;</td>
            <td class="style4">
                <asp:Label ID="UserIdLabel" runat="server" 
                    style="position: relative; float: left"></asp:Label>
                <asp:Label ID="UserNameLabel" runat="server" 
                    style="position: relative; float: right; top: 0px; left: -1px;"></asp:Label>
            </td>
            <td rowspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:HiddenField ID="DeptHiddenField" runat="server" />
                </td>
            <td class="style6" rowspan="2">
                <br />
            </td>
            <td class="style5" rowspan="2">
                <asp:Label ID="Label1" runat="server" Text="His/Her Greivance :  "></asp:Label>
                <asp:TextBox ID="NoteTBox" runat="server" Height="100%" TextMode="MultiLine" 
                    Width="100%" Font-Size="Large"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                <asp:SqlDataSource ID="GreivanceSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                    
                    SelectCommand="SELECT * FROM [Greivances] WHERE ([IdDept] = @IdDept)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DeptHiddenField" Name="IdDept" 
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>

