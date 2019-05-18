using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EnableDesable : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (IsPostBack)
        {
            try
            {
                DataClassesDataContext dc = new DataClassesDataContext();
                var FirstLast = from d in dc.Users
                                where d.UserId == int.Parse(IdUserTBox.Text)
                                select d;
                FirstNameLablel.Text = "";
                LastNameLabel.Text = "";
                foreach (var v in FirstLast)
                {
                    FirstNameLablel.Text = "<ul><li>" + v.FirstName + "</li></ul>";
                    LastNameLabel.Text = "<ul><li>" + v.LastName + "</li></ul>";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

        }
    }
    private bool checkValueIsNotFound()
    {
        // after get decide check the value.
        DataClassesDataContext dc = new DataClassesDataContext();
        // check if this doc is already exist.
        var CheckFound = from d in dc.Users
                         where d.UserId == int.Parse(IdUserTBox.Text)
                         select d;
        if (CheckFound.Count() == 0)//if query has not rows then user is not found in database.
        {
            Response.Write("<script>alert('This User ID : " + IdUserTBox.Text + " is not exist');</script>");
            return true;
        }
        return false;
    }
    private bool checkValueIsActiveDuplicated()
    {
        bool activeValue ;
        if (EnableDisableRList.SelectedIndex == 0)
            activeValue = true;
        else activeValue = false; 

        DataClassesDataContext dc = new DataClassesDataContext(); // definitly has rows the program will not reach this point
                                                                   // if user id is not found.
        var checkActive = from u in dc.Users
                          where u.UserId == int.Parse(IdUserTBox.Text)
                          select u;
        bool active = false ; 
        foreach (var v in checkActive)
        {
            active = v.IsActive; 
        }
        if(active == activeValue && activeValue)
        {
            Response.Write("<script>alert('User Account is already enabled.');</script>");
            return true;
        }
        if (active == activeValue && !activeValue)
        {
            Response.Write("<script>alert('User Account is already disabled.');</script>");
            return true; 
        }
        return false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        try
        {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;

        if (checkValueIsNotFound()) // if user is not in database.
            return;

        if (checkValueIsActiveDuplicated()) // if duplicated occurs in account state.
            return;

        bool activeValue; // a variable to hold state of account of user.
        if (EnableDisableRList.SelectedIndex == 0)
            activeValue = true;
        else activeValue = false; 
        DataClassesDataContext dc = new DataClassesDataContext(); // update state of account.

            User u = dc.Users.First(p => p.UserId == int.Parse(IdUserTBox.Text));
            u.IsActive = activeValue; // according to radioButtonList value .
            dc.SubmitChanges();
            Response.Write("<script>alert('Done');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        DataClassesDataContext dc = new DataClassesDataContext();
        var FirstLast = from d in dc.Users
                        where d.UserId == int.Parse(IdUserTBox.Text)
                        select d;
        if (FirstLast.Count() == 0) // in case user is not found.
            Response.Write("<script>alert('This User is not found');</script>");

        FirstNameLablel.Text = "";
        LastNameLabel.Text = "";
        foreach (var v in FirstLast)
        {
            FirstNameLablel.Text = "<ul><li>" + v.FirstName + "</li></ul>";
            LastNameLabel.Text = "<ul><li>" + v.LastName + "</li></ul>";
        }
    }
}