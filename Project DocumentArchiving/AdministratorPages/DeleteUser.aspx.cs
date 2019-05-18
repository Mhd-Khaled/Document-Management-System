using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DeleteUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

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
    private void DeleteForeginValues()
    {   // requestAttchement->PositionReq->Action->(CurrentReq)->(User).
        DataClassesDataContext dc = new DataClassesDataContext();
        // 1- delete requestAttchement.
        var deleteReqAttach = from ra in dc.RequestAttachments
                              join c in dc.CurrentRequests on ra.IdRequest equals c.IdRequest
                              join u in dc.Users on c.IdUser equals u.UserId
                              where u.UserId == int.Parse(IdUserTBox.Text)
                              select ra ; 
        foreach (var item in deleteReqAttach)
	    {
		    dc.RequestAttachments.DeleteOnSubmit(item);
	    }
        // 2- delete PositionReq.
       var deletePosReq = from pos in dc.PositionOfCurrentDocs
                              join c in dc.CurrentRequests on pos.IdRequest equals c.IdRequest
                              join u in dc.Users on c.IdUser equals u.UserId
                              where u.UserId == int.Parse(IdUserTBox.Text)
                              select pos ; 
        foreach (var item in deletePosReq)
	    {
		    dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
	    }
        // 3- delete Action.
        var deleteActionReq = from a in dc.Actions
                              join c in dc.CurrentRequests on a.IdRequest equals c.IdRequest
                              join u in dc.Users on c.IdUser equals u.UserId
                              where u.UserId == int.Parse(IdUserTBox.Text)
                              select a ; 
        foreach (var item in deleteActionReq)
	    {
		    dc.Actions.DeleteOnSubmit(item);
	    }
        // 4- now we can delete request.
        var deleteCurrentReq = from c in dc.CurrentRequests
                               join u in dc.Users on c.IdUser equals u.UserId
                               where u.UserId == int.Parse(IdUserTBox.Text)
                               select c;
        foreach (var item in deleteCurrentReq)
        {
            dc.CurrentRequests.DeleteOnSubmit(item);
        }
        // 5- now we can delete user.
        var deleteUser = from u in dc.Users
                         where u.UserId == int.Parse(IdUserTBox.Text)
                         select u ; 

        foreach (var item in deleteUser)
	    {
		    dc.Users.DeleteOnSubmit(item);
	    }
        dc.SubmitChanges(); // save changes to database after user has deleted.

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;

        try
        {
            
            if (checkValueIsNotFound())
                return;

            DeleteForeginValues();
            Response.Write("<script>alert('Done.');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error" + ex.Message + "');</script>");
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