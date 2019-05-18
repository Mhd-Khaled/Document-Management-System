using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddDepartment : System.Web.UI.Page
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
        var CheckFound = from d in dc.Departments
                         select d;
        List<string> duplicated = new List<string>(); // list to avoid probability of arrangement.
        foreach (var v in CheckFound)
        {
            if (v.IdDept == int.Parse(IdDepartmentTBox.Text))
                duplicated.Add("Department ID : " + IdDepartmentTBox.Text);
            if (v.Name == DepartmentNameTBox.Text)
                duplicated.Add("Department Name : " + DepartmentNameTBox.Text);
            if (v.Phone == PhoneTBox.Text)
                duplicated.Add("Department Phone : " + PhoneTBox.Text);
        }
        string s = "";
        bool found = false;
        foreach (var v in duplicated)
        {
            s += " " + v ; 
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
        if (checkValueIsFound())// search for value return non empty.
            return; 
       

            DataClassesDataContext dc = new DataClassesDataContext();
            Department de1 = new Department {IdDept=int.Parse(IdDepartmentTBox.Text),Name=DepartmentNameTBox.Text,Phone=PhoneTBox.Text};
            dc.Departments.InsertOnSubmit(de1);
            dc.SubmitChanges();
            Response.Write("<script>alert('Done');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error" + ex.Message + "');</script>");
        }
    }
}