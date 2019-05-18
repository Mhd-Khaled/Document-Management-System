using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VisitorPages_NounPaper : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        try
        {
            e.Command.Connection.Open();    // open connection is required.
            if (!e.Command.ExecuteReader().HasRows) // if query doesn't have rows then notify user.
                Response.Write("<script>alert('This Document requires no noun paper.');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('"+ex.Message+"');</script>");
        }
        finally
        {
            e.Command.Connection.Close();
        }

    }
}