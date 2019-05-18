using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DeleteDocument : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

            DataClassesDataContext dc = new DataClassesDataContext();
            var IdOFDept = from d in dc.Users // get department id from user id.
                                   where d.UserId == int.Parse(Session["Id"].ToString())
                                   select d;
            int idDept = 0;
            foreach (var item in IdOFDept)
            {
                idDept = item.IdDept;
            }
            HiddenField1.Value = idDept.ToString(); // put id department in hidden field for sql data source.

            var nameOfDept = from d in dc.Departments   // get the department name for that id department.
                             where d.IdDept == idDept
                             select d;
            string nameOfDeptartment = "";
            foreach (var item in nameOfDept)
            {
                nameOfDeptartment = item.Name;
            }
            DepartmentNameLable.Text = nameOfDeptartment; // assign name of department to label.
    }
    private DataClassesDataContext dc = new DataClassesDataContext();
    // to delete document we need to delete all its dependancy of data in tables.
    private void deleteDocumentDetails()
    {
        var DeleteDocDetails = from dt in dc.DocDetails
                               where dt.IdDoc == int.Parse(DropDownList1.SelectedValue)
                               select dt;
        foreach (var item in DeleteDocDetails)
        {
            dc.DocDetails.DeleteOnSubmit(item);
        }

    }
    private void deleteWorkflow()
    {
        var DeletePosOfCurr = from v in dc.PositionOfCurrentDocs
                              join w in dc.WorkflowDocuments on v.IdWorkflowDoc equals w.IdWorkflowDoc
                              where w.IdDoc == int.Parse(DropDownList1.SelectedValue)
                              select v;
        foreach (var item in DeletePosOfCurr)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        //try
        //{
        //    while (true) // this will continue delete until delete all workflow for this document.
        //    {

        //        WorkflowDocument wDocMany = dc.WorkflowDocuments.First(p => p.IdDoc == int.Parse(DocDList.SelectedValue));
        //        dc.WorkflowDocuments.DeleteOnSubmit(wDocMany);

        //    }
        //}
        //catch { } // this while loop will break when exception will be found.

        var deleteWorkflow = from w in dc.WorkflowDocuments
                             where w.IdDoc == int.Parse(DropDownList1.SelectedValue)
                             select w;
        foreach (var item in deleteWorkflow)
        {
            dc.WorkflowDocuments.DeleteOnSubmit(item);
        }
    }
    private void deleteRequest()
    {
        var DeleteReqAttachment = from c in dc.CurrentRequests
                                  join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                                  join ra in dc.RequestAttachments on c.IdRequest equals ra.IdRequest
                                  select ra;
        foreach (var item in DeleteReqAttachment)
        {
            dc.RequestAttachments.DeleteOnSubmit(item);
        }
        // delete position of current request.
        var DeleteReqPosCurr = from c in dc.CurrentRequests
                               join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                               join pos in dc.PositionOfCurrentDocs on c.IdRequest equals pos.IdRequest
                               select pos;
        foreach (var item in DeleteReqPosCurr)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        // delete Action of current request.
        var DeleteReqAction = from c in dc.CurrentRequests
                              join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                              join ac in dc.Actions on c.IdRequest equals ac.IdRequest
                              select ac;
        foreach (var item in DeleteReqAction)
        {
            dc.Actions.DeleteOnSubmit(item);
        }

        var deleteCurrentRequest = from c in dc.CurrentRequests
                                   where c.IdDoc == int.Parse(DropDownList1.SelectedValue)
                                   select c;
        foreach (var item in deleteCurrentRequest)
        {
            dc.CurrentRequests.DeleteOnSubmit(item);
        }
    }
    private void deleteForeginData()
    { // (DocDetails)->PosCurrent->(Workflow)->RequestAttach->PosCurrent->Action->(Request(Goal)).

        //try
        //{
        //    while (true) // this will continue delete until delete all nounpaper in this document.
        //    {

        //        DocDetail docMany = dc.DocDetails.First(p => p.IdDoc == int.Parse(DocDList.SelectedValue));
        //        dc.DocDetails.DeleteOnSubmit(docMany);
        //    }
        //}

        //catch { } // this while loop will break when exception will be found.

        deleteDocumentDetails(); //1.
        deleteWorkflow(); //2.
        deleteRequest(); //3.

        //try
        //{
        //    while (true) // this will continue delete until delete all Requests for this document.
        //    {

        //        CurrentRequest rMany = dc.CurrentRequests.First(p => p.IdDoc == int.Parse(DocDList.SelectedValue));
        //        dc.CurrentRequests.DeleteOnSubmit(rMany);
        //    }
        //}
        //catch { } // this while loop will break when exception will be found.
        dc.SubmitChanges();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;
        try
        {
            // then delete document will be done because all nounpapers in this document has deleted.
            if (DropDownList1.Items.Count == 0)
                Response.Write("<script>alert('There is no department to delete.');</script>");
            else
            {
                deleteForeginData();

                Document d1 = dc.Documents.First(p => p.IdDoc == int.Parse(DropDownList1.SelectedValue));
                dc.Documents.DeleteOnSubmit(d1);
                dc.SubmitChanges();

                Response.Write("<script>alert('Done.');</script>");
                DropDownList1.DataBind();
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error" + ex.Message + "');</script>");
        }
    }
}