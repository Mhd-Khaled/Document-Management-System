using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VisitorPages_HomeVisitor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session.Timeout = 30;        // determine the time of Session to 30 minute.
            Session["IsLogged"] = "NoLogged"; // To force the user to login first. 
        }
        Session["ListBoxValue"] = null;
    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        try
        {
            DataClassesDataContext dc = new DataClassesDataContext(); // See in database if the user has 
            var CheckUser = from u in dc.Users                        // user name and password.
                            where u.UserName == Login.UserName && u.Password == Login.Password
                            select new
                            {
                                myLoginType = u.TypeLogin , 
                                NameOfUser = u.FirstName +" "+ u.LastName , 
                                CurrentUserID = u.UserId ,
                                ActiveAccount = u.IsActive  
                            };
            string UserLoginType = "" ;
            string NameOfUser = "";
            int CurrentUserID = 0;
            bool Active = true; 
            foreach (var v in CheckUser)
            {
                NameOfUser = v.NameOfUser;
                CurrentUserID = v.CurrentUserID;
                UserLoginType = v.myLoginType;
                Active = v.ActiveAccount;
            }
            if (CheckUser.Count() > 0 && Active)      // The result of u select has more than one rwo.
            {
                Session["IsLogged"] = "LoggingCorrectly";    // set value to this sesion for forcing user to login from homeVisitor page.
                Session["Name"] = NameOfUser; // to display user name in all pages.
                Session["Id"] = CurrentUserID;

                if (UserLoginType == "Normal")
                    Response.Redirect("~/UserPages/HomeUser.aspx"); //redirect to Normal Account.
                else if (UserLoginType == "Administrator")
                    Response.Redirect("~/AdministratorPages/HomeAdministrator.aspx"); // redirct to administrator Account.
                else if (UserLoginType == "Manager")
                    Response.Redirect("~/ManagerPages/HomeManager.aspx");
            }
            else if(CheckUser.Count() > 0 && !Active)
                Response.Write("<script>alert('Your account is disabled.');</script>");
            else
                Response.Write("<script>alert('Wrong Username or Password.');</script>");
        }
        catch (Exception ex) { Response.Write("<script>alert('" + ex.Message + "');</script>"); }
    }
}