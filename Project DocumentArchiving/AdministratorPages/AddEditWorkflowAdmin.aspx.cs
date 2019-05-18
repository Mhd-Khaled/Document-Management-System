using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManagerPages_AddEditWorkflow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (IsPostBack)
        {
            if (DocDList.Items.Count == 0)
                return;

                DataClassesDataContext dc = new DataClassesDataContext();
                var countOfStep = from step in dc.WorkflowDocuments
                                  join doc in dc.Documents on step.IdDoc equals doc.IdDoc
                                  where doc.IdDoc == int.Parse(DocDList.SelectedValue)
                                  group step by step.IdDoc into NumSteps
                                  select new
                                  {
                                      countOfWorkflow = NumSteps.Count()
                                  };
                int count = 0;
                if (countOfStep.Count() > 0)
                    foreach (var v in countOfStep)
                    {
                        count = v.countOfWorkflow;     // get the number of workflow.
                    }
                StepLabel.Text = (count + 1).ToString();
                ViewState["Count"] = count;
        }
    }
    protected void Insert_Click(object sender, EventArgs e)
    {
        DataClassesDataContext dc = new DataClassesDataContext();

        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;

        if (DocDList.Items.Count == 0)
        {
            Response.Write("<script>alert('There is no document to add workflow to it');</script>");
            return; 
        }
        try
        {
            // get the last department to permet user from adding it to workflow again.
            var getLastDept = from w in dc.WorkflowDocuments
                                 where w.IdStep == int.Parse(ViewState["Count"].ToString()) &&
                                 w.IdDoc == int.Parse(DocDList.SelectedValue)
                                 select w;
            int lastDept = 0;
            foreach (var item in getLastDept)
            {
                lastDept = item.IdDept; 
            }

            if (lastDept == int.Parse(DeptInsertDList.SelectedValue))// same department as last one permet this .
            {
                Response.Write("<script>alert('You can not insert the same department again');</script>");
                return;
            }

            WorkflowDocument workflow = new WorkflowDocument
            {
                IdStep = int.Parse(ViewState["Count"].ToString())+1,
                IdDept = int.Parse(DeptInsertDList.SelectedValue),
                IdDoc = int.Parse(DocDList.SelectedValue)
            };
            dc.WorkflowDocuments.InsertOnSubmit(workflow);
            dc.SubmitChanges();
            WorkflowGridView.DataBind();
            Response.Write("<script>alert('Done.');</script>");

            StepLabel.Text = (int.Parse(ViewState["Count"].ToString()) + 2).ToString();
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }
    }
    protected void WorkflowGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        // template field doesn't work with gridview.selectedRow.cell[1].Text then we have to find label that represent numStep.  
        Label idStepValueFromLabel =  (Label) WorkflowGridView.SelectedRow.Cells[1].FindControl("Label1");
        string s = idStepValueFromLabel.Text; 
        DataClassesDataContext dc = new DataClassesDataContext();
        try
        {
            // delete pos to enable to delete workflow.
            var deletePosCurr = from pos in dc.PositionOfCurrentDocs
                                join w in dc.WorkflowDocuments on pos.IdWorkflowDoc equals w.IdWorkflowDoc
                                where w.IdStep == int.Parse(s) &&
                                w.IdDoc == int.Parse(DocDList.SelectedValue)
                                select pos;
            foreach (var item in deletePosCurr)
            {
                dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
            }
            // delete workflow after pos of it has deleted.
            var deleteWorkflow = from w in dc.WorkflowDocuments
                                 where w.IdStep == int.Parse(s) &&
                                 w.IdDoc == int.Parse(DocDList.SelectedValue)
                                 select w;
            foreach (var item in deleteWorkflow)
            {
                dc.WorkflowDocuments.DeleteOnSubmit(item);
            }
            dc.SubmitChanges();

            // re-arrange steps from 1.
            var ReArrangeSteps = from w in dc.WorkflowDocuments
                                 where w.IdDoc == int.Parse(DocDList.SelectedValue)
                                 select w;
            int count = 1;
            foreach (var item in ReArrangeSteps)
            {
                item.IdStep = count;
                count++; 
            }
            dc.SubmitChanges();
            // re-write label value.
            ViewState["Count"] = count;
            StepLabel.Text = ViewState["Count"].ToString();

            WorkflowGridView.DataBind();
            Response.Write("<script>alert('Done');</script>");
        }
        catch (Exception ex) { Response.Write("<script>alert('" + ex.Message + "');</script>"); }
    }
}