<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/RequestMasterPage.master" AutoEventWireup="true" CodeFile="HomeUser.aspx.cs" Inherits="HomeUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />

    <style type="text/css">

        .style1
        {
        }
        .style3
        {
            width: 316px;
        }
        .style4
        {
            width: 220px;
        }
        .style5
        {
            width: 48px;
            height: 134px;
        }
        #TextArea1
        {
            width: 250px;
            height: 100px;
            margin-left: 0px;
            float: right;
        }
        .style7
        {
            height: 134px;
            width: 494px;
        }
        .style8
        {
            height: 134px;
            width: 267px;
        }
        #cy
        {
            top: 35%;
            position: absolute;
            height: 100px;
            width: 100%;
        }
        .List
        {
            top: 24%;
            left: 0px;
            position: relative;
            float: right;
            height: 55px;
            width: 35%;
        }
        .style9
        {
            height: 30px;
        }
    </style>
    <script type="text/javascript">
        function showFrame() {
             frame = document.getElementById("frame");
             frame.style.visibility = "visible";    // to show frame
             note.style.visibility = "visible"; // to show note textArea.
        }
        function hideFrame() {
             frame = document.getElementById("frame");
             frame.style.visibility = "hidden";
             note = document.getElementById("TextArea1");
             note.style.visibility = "hidden";
        }
        function refresh() {
            document.location.reload();
        }

        function Send() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Are you sure of your choice?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <table style="width:100%; height:10px">
            <tr>
                <td style="text-align:center" class="style1" colspan="3">
                    <asp:ImageButton ID="InBox" runat="server" 
                        ImageUrl="~/Images/inbox.png" Height="80px" Width="80px" 
                        onclick="InBox_Click" />
                    <asp:ImageButton ID="OutBox" runat="server" 
                        ImageUrl="~/Images/outbox.png" Height="80px" Width="80px" 
                        onclick="OutBox_Click" onclientclick="showCY()" />
                    <asp:Label ID="NumRequest" runat="server" BackColor="#CC0000" 
                        CssClass="NumReqStyle" ForeColor="Black" ></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align:right" class="style3">

                    <input id="Hidden1" type="hidden" />

                                            <asp:ImageButton ID="ImageButton1" 
            runat="server" Height="50px" 
                                        ImageUrl="~/Images/File_Delete.png" onclick="ImageButton1_Click" 
                                        style="float: left; text-align: center; position: relative;" 
                                        Width="50px" />

                </td>
                <td style="text-align:right" class="style4">

                                    <asp:Label ID="DateLabel" runat="server" 
                                        style="float: left; top: 0px; position: relative;"></asp:Label>

                                    </td>
                <td style="text-align:right" class="style1">
                    <asp:ListBox ID="ListBox1" runat="server" 
                        AutoPostBack="True" 
                        onselectedindexchanged="ListBox1_SelectedIndexChanged1" CssClass="List"></asp:ListBox>
                    <asp:ListBox ID="ListBox2" runat="server" AutoPostBack="True" 
                        onselectedindexchanged="ListBox2_SelectedIndexChanged" 
                        style="position: relative; height: 55px; width: 35%; float: right; z-index: 10; top: -2147483648%; left: 0px">
                    </asp:ListBox>
                </td>
            </tr>
        </table>


    <table style="width:100%; height:100%"> 
    <tr style="height:100%"><td>

                             <iframe id="frame" src="../OutBox.aspx" frameborder="0"
                                    
                             style="visibility:visible; top: 38%; position: absolute; height: 60%; width: 65%; z-index: 2; right: 25%; left: 2%;"></iframe>
                                    </td></tr>
    <tr style="height:100%"><td>

                                    <asp:GridView ID="GridView1" runat="server" CssClass="CSSTableGenerator">
                                    </asp:GridView>
        </td></tr>
    </table>
                        <table style="width:100%">
                        <tr>
                            <td style="list-style:center" colspan="4">
                  
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server"  RepeatColumns="4" RepeatDirection="Horizontal" RepeatLayout="Table"
                        CssClass="radioButton" >
                        <asp:ListItem Value="1" Selected="True">Studying</asp:ListItem>
                        <asp:ListItem Value="2">Accept</asp:ListItem>
                        <asp:ListItem Value="3">Deny</asp:ListItem>
                        <asp:ListItem Value="4">Waiting</asp:ListItem>
                    </asp:RadioButtonList>
                                <br />
                                <asp:Button ID="DownloadBtn" runat="server" onclick="Button1_Click" 
                                    style="position: relative; float: right" Text="Show files" 
                                    ToolTip="Show the requested files" />
                            </td>
                        </tr>
                        <tr>
                            <td class="style5">
                  
                                <asp:Label ID="NoteLabel" runat="server" Text="Note : "></asp:Label>
                            </td>
                            <td class="style7">
                  
                                <asp:TextBox ID="NoteTBox" 
                                    runat="server" Height="131px" Width="272px" TextMode="MultiLine"></asp:TextBox>
                            </td>
                            <td class="style8">
                  
                                &nbsp;</td>
                            <td>
                  
                                <textarea id="TextArea1" cols="20" name="S1" rows="2" 
                                    style="font-size: large; position: relative; resize:none; visibility:visible" ></textarea></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="text-align:center" class="style9">
                  
                                <asp:Button ID="confirmBtn" runat="server" Text="Confirm" 
                                    onclick="confirmBtn_Click" onclientclick="Send()" style="height: 26px" />
                            </td>
                        </tr>
                    </table>

        <asp:Image ID="colorKeys" runat="server" ImageUrl="~/Images/ColorKeys.PNG" 
            style="top: 80%; position: absolute; float: right; height: 68px; width: 244px; left: 81%" />

        <br />
</asp:Content>

