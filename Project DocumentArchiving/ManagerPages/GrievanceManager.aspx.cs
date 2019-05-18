using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class grievance : System.Web.UI.Page
{
    DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        
        var getDeptId = from u in dc.Users // get the department to show greivaces for this department.
                        where u.UserId == int.Parse(Session["Id"].ToString())
                        select new { u.IdDept };
        int myDept = 0; 
        foreach (var item in getDeptId)
        {
            myDept = item.IdDept; 
        }
        DeptHiddenField.Value = myDept.ToString(); // put it in hidden field for greivanceSqlDataSource.
    }
    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        UserIdLabel.Text = ListBox1.SelectedItem.Text;

        var getUserNameOfSelected = from u in dc.Users // get user name of selected list box .
                                    where u.UserId == int.Parse(ListBox1.SelectedItem.Text)
                                    select u;
        foreach (var item in getUserNameOfSelected)
        {
            UserNameLabel.Text = item.FirstName +" "+ item.LastName;
        }

        var getGreivance = from g in dc.Greivances // get selected greivance's problem. 
                           where g.IdGreivance == int.Parse(ListBox1.SelectedValue)
                           select g;
        foreach (var item in getGreivance) // the query will return only one value.
        {
            NoteTBox.Text = item.Problem; 
        }
    }
}