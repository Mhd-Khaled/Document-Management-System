<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="RequestManager.aspx.cs" Inherits="Request" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">
        .style2
    {
        }
        .style3
        {
            width: 142px;
        }
        .style4
        {
            width: 143px;
            height: 34px;
        }
        .style5
        {
            height: 34px;
        }
    .style6
    {}
    .style7
    {
        width: 51px;
    }
    </style>
        <script type="text/javascript">
            function Send() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Are you sure that you want to send this request?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <p>
        &nbsp;</p>
<asp:Panel ID="Panel1" runat="server" BackColor="#FDFFFF" ScrollBars="Vertical" 
        Width="441px">
    <table class="CSSTableGenerator">
    <tr>
            <td class="style4">
                Request of
            </td>
            <td class="style5">
                <asp:DropDownList ID="RequestDList" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="DocumentName" 
                    DataValueField="IdDoc" AutoPostBack="True" AppendDataBoundItems="true">
                </asp:DropDownList>
                <br />
            </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Label ID="Label1" runat="server" Text=" Title : "></asp:Label>
                &nbsp;</td>
            <td class="style2">
                <asp:Label ID="TitleLabel" runat="server"></asp:Label>
            </td>
        </tr>
        
        <tr>
            <td class="style2">
                <asp:Label ID="Label2" runat="server" Text="Date of :"></asp:Label>
            </td>
            <td>
                <asp:Label ID="DateLabel" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Label ID="Label3" runat="server" Text="Produced by Mr/Ms :"></asp:Label>
            </td>
            <td>
                <asp:Label ID="UserNameLabel" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Label ID="Label4" runat="server" Text="Required Files "></asp:Label>
            </td>
            <td style="text-align:left; padding-top:15px">
                <asp:Label ID="requestedFileLabel" runat="server"></asp:Label>
                <br />
                <br />
            </td>
        </tr>
    </table>
    <br />
</asp:Panel>
    <table style="width:100%;">
        
        <tr>
            <td class="style3" rowspan="3">
                &nbsp;</td>
            <td class="style6" colspan="4">
                <br />
            </td>
        </tr>
        
        <tr>
            <td class="style7">
                <asp:Button ID="Button1" runat="server" Text="Send" onclick="Button1_Click" 
                    style="width: 46px" ValidationGroup="A" onclientclick="Send()" />
            </td>
            <td>
                <asp:CustomValidator ID="CustomValidator3" runat="server" 
                    ErrorMessage="CustomValidator" 
                    onservervalidate="CustomValidator3_ServerValidate" ValidationGroup="A"></asp:CustomValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        
        <tr>
            <td colspan="4">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
        SelectCommand="SELECT * FROM [Documents]"></asp:SqlDataSource>
    </asp:Content>

