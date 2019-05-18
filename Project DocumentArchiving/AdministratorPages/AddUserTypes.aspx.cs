using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddUserTypes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");
    }
    private bool checkValueIsFound()
    {
        // after get decide check the value.
        DataClassesDataContext dc = new DataClassesDataContext();
        // check if this doc is already exist.
        var CheckFound = from d in dc.UserTypes
                         select d;
        List<string> duplicated = new List<string>(); // list to avoid probability of arrangement.
        foreach (var v in CheckFound)
        {
            if (v.TypeUserId == int.Parse(IdTypeUserTBox.Text))
                duplicated.Add("Type User ID : " + IdTypeUserTBox.Text);
            if (v.TypeUser == NameTypeUserTBox.Text)
                duplicated.Add("Type User Name : " + NameTypeUserTBox.Text);
        }
        string s = "";
        bool found = false;
        foreach (var v in duplicated)
        {
            s += " " + v;
        }

        if (duplicated.Count > 0)
        {
            found = true;
            Response.Write("<script>alert('Duplicated values : (" + s + ")');</script>");
        }
        return found;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;
        try
        {
        if (checkValueIsFound())
            return;

            DataClassesDataContext dc = new DataClassesDataContext();
            UserType ut1 = new UserType {TypeUserId=byte.Parse(IdTypeUserTBox.Text),TypeUser=NameTypeUserTBox.Text};
            dc.UserTypes.InsertOnSubmit(ut1);
            dc.SubmitChanges();
            Response.Write("<script>alert('Done');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error" + ex.Message + "');</script>");
        }
    }
}