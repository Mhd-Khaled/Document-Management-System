<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DownloadReqAttach.aspx.cs" Inherits="DowmloadReqAttach" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="Styles/TableCSSCode.css" />
    <style type="text/css">
        .style1
        {
            width: 460px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table style="width: 100%;">
            <tr>
                <td class="style1">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                        
                        SelectCommand="SELECT * FROM [RequestAttachments] WHERE ([IdRequest] = @IdRequest)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="IdRequest" QueryStringField="IdRequestOfFile" 
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="IdRequestFile" DataSourceID="SqlDataSource1" 
                        EnableModelValidation="True" 
                        onselectedindexchanged="GridView1_SelectedIndexChanged" CssClass="CSSTableGenerator" 
                        style="float: none" Width="50%">
                        <Columns>
                            <asp:CommandField SelectText="Open" ShowSelectButton="True" />
                            <asp:BoundField DataField="IdRequestFile" HeaderText="IdRequestFile" 
                                InsertVisible="False" ReadOnly="True" SortExpression="IdRequestFile" />
                            <asp:BoundField DataField="FileName" HeaderText="FileName" 
                                SortExpression="FileName" />
                            <asp:BoundField DataField="FileTyp" HeaderText="FileTyp" 
                                SortExpression="FileTyp" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            </table>
    
    </div>
    </form>
</body>
</html>
