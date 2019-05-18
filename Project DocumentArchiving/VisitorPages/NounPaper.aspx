<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/VisitorMasterPage.master" AutoEventWireup="true" CodeFile="NounPaper.aspx.cs" Inherits="VisitorPages_NounPaper" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
        .style6
        {
            width: 315px;
        }
        .style10
        {
            width: 60%;
        }
        .style11
        {
            width: 24%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Panel ID="Panel1" runat="server" Width="800px">
        <table style="width:100%;">
            <tr>
                <td class="style10" colspan="2">
                    &nbsp;</td>
                <td class="style6">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style11">
                    <asp:Label ID="Label1" runat="server" Text="Choose the document : "></asp:Label>
                </td>
                <td class="style10">
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                        DataSourceID="SqlDataSource1" DataTextField="DocumentName" 
                        DataValueField="IdDoc" Height="25px" style="float: none" Width="130px">
                    </asp:DropDownList>
                </td>
                <td class="style6">
                    &nbsp;</td>
                <td>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                        SelectCommand="SELECT * FROM [Documents]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="style10" colspan="2">
                    &nbsp;</td>
                <td class="style6">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" 
                        CssClass="CSSTableGenerator" EnableModelValidation="True" 
                        AllowPaging="True">
                        <Columns>
                            <asp:BoundField DataField="NumNounPaper" HeaderText="NumNounPaper" 
                                SortExpression="NumNounPaper" />
                            <asp:BoundField DataField="NameOfNounPaper" HeaderText="NameOfNounPaper" 
                                SortExpression="NameOfNounPaper" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                        
                        SelectCommand="SELECT * FROM [DocDetails] WHERE ([IdDoc] = @IdDoc)" 
                        onselecting="SqlDataSource2_Selecting">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="IdDoc" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style10" colspan="2">
                    &nbsp;</td>
                <td class="style6">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

