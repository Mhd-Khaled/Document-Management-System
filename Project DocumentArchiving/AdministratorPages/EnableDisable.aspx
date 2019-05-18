﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminstratorMasterPage.master" AutoEventWireup="true" CodeFile="EnableDisable.aspx.cs" Inherits="EnableDesable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link rel="Stylesheet" href="../Styles/TableCSSCode.css" />
    <style type="text/css">

        .style2
        {
            width: 132px;
        }
        .style3
        {
            height: 26px;
            width: 132px;
        }
        .style4
        {
            width: 5px;
        }
        </style>
            <script type="text/javascript">
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
<asp:Panel ID="Panel1" runat="server" BackColor="#FDFFFF" ScrollBars="Vertical" 
        Width="448px" >
    <table class="CSSTableGenerator" >
    <tr>
        <td class="style2">
                &nbsp;</td>
        <td colspan="2">
                &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label1" runat="server" Text="Id User :"></asp:Label>
        </td>
        <td colspan="2">
            <asp:TextBox ID="IdUserTBox" runat="server" Width="128px"></asp:TextBox>
            <asp:ImageButton ID="ImageButton1" runat="server" Height="30px" 
                ImageUrl="~/Images/Find.png" onclick="ImageButton1_Click" 
                Width="30px" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="IdUserTBox" ErrorMessage="Please Enter Id User  :">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToValidate="IdUserTBox" ErrorMessage="Please Enter Number" 
                Operator="DataTypeCheck" Type="Integer">Please Enter Number</asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            <asp:Label ID="Label2" runat="server" Text="FirstName :"></asp:Label>
        </td>
        <td colspan="2">
            <asp:Label ID="FirstNameLablel" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <asp:Label ID="Label3" runat="server" Text="LastName :"></asp:Label>
        </td>
        <td colspan="2">
            <asp:Label ID="LastNameLabel" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        
        <td class="style4">
            <asp:RadioButtonList ID="EnableDisableRList" runat="server" Width="88px">
                <asp:ListItem Selected="True">Enable</asp:ListItem>
                <asp:ListItem>Disable</asp:ListItem>
            </asp:RadioButtonList>
        </td>
        
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="EnableDisableRList" 
                ErrorMessage="please Cheak What You Want">*</asp:RequiredFieldValidator>
        </td>
        
    </tr>
    <tr>
        <td class="style2">
                &nbsp;</td>
        <td colspan="2">
            <asp:Button ID="Button1" runat="server" Text="Enable / Disable" Width="122px" 
                onclick="Button1_Click" onclientclick="Send()" />
        </td>
    </tr>
</table>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
</asp:Panel>
</asp:Content>

