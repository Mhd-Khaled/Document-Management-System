<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/RequestMasterPage.master" AutoEventWireup="true" CodeFile="Grievances.aspx.cs" Inherits="Grievances" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 10px;
        }
    </style>
        <script type="text/javascript">
            function Send() {
                var confirm_value = document.createElement("INPUT");
                confirm_value.type = "hidden";
                confirm_value.name = "confirm_value";
                if (confirm("Are you sure you want to send this grievance?")) {
                    confirm_value.value = "Yes";
                } else {
                    confirm_value.value = "No";
                }
                document.forms[0].appendChild(confirm_value);
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="User Id :"></asp:Label>
            </td>
            <td>
                <asp:Label ID="UserIdlable" runat="server" Text="Label"></asp:Label>
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Problem :"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="ProblemTexB" runat="server" Height="104px" Width="472px"></asp:TextBox>
            </td>
            <td class="style1">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="Please Enter The Problem" ControlToValidate="ProblemTexB">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label3" runat="server" Text="Department Name :"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="DepartmentDropDo" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="IdDept">
                </asp:DropDownList>
            </td>
            <td class="style1">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ErrorMessage=" Please Select Department" 
                    ControlToValidate="DepartmentDropDo">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" 
                    SelectCommand="SELECT * FROM [Departments]"></asp:SqlDataSource>
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Send" 
                    Width="103px" onclientclick="Send()" />
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        </table>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                 </asp:Content>

