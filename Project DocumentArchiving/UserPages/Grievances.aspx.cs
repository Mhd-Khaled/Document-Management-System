using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Grievances : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UserIdlable.Text =Session["Id"].ToString();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return; 
        try
        {
            DataClassesDataContext dc = new DataClassesDataContext();
            Greivance g = new Greivance { IdUser = int.Parse(UserIdlable.Text), DateOfAction = System.DateTime.Now ,Problem = ProblemTexB.Text, IdDept = int.Parse(DepartmentDropDo.SelectedValue) };
            dc.Greivances.InsertOnSubmit(g);
            dc.SubmitChanges();
        }
        catch { }
    }
}