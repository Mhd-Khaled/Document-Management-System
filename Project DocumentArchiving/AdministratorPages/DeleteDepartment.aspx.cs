using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DeleteDepartment : System.Web.UI.Page
{
    private DataClassesDataContext dc = new DataClassesDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");
    }
    private void deleteDocument()
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
        var DeleteDocDetails = from dt in dc.DocDetails
                               join doc in  dc.Documents on dt.IdDoc equals doc.IdDoc
                               join dep in dc.Departments on doc.IdDept equals dep.IdDept
                               where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                               select dt;
        foreach (var item in DeleteDocDetails)
        {
            dc.DocDetails.DeleteOnSubmit(item);
        }

        // delete position.
        var DeletePos = from pos in dc.PositionOfCurrentDocs
                        join w in dc.WorkflowDocuments on pos.IdWorkflowDoc equals w.IdWorkflowDoc
                        join doc in dc.Documents on w.IdDoc equals doc.IdDoc
                        join dep in dc.Departments on doc.IdDept equals dep.IdDept
                        where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                        select pos; 

        foreach (var item in DeletePos)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        // delete workflow.
        var deleteWorkflow = from w in dc.WorkflowDocuments
                             join doc in dc.Documents on w.IdDoc equals doc.IdDoc
                             join dep in dc.Departments on doc.IdDept equals dep.IdDept
                             where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                             select w;
        foreach (var item in deleteWorkflow)
        {
            dc.WorkflowDocuments.DeleteOnSubmit(item);
        }
        // delete Attachment.
        var deleteReqAttacment = from ra in dc.RequestAttachments
                                 join c in dc.CurrentRequests on ra.IdRequest equals c.IdRequest
                                 join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                                 join dep in dc.Departments on doc.IdDept equals dep.IdDept
                                 where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                 select ra;
        foreach (var item in deleteReqAttacment)
        {
            dc.RequestAttachments.DeleteOnSubmit(item);
        }
        // delete position.
        var deletePosReq = from pos in dc.PositionOfCurrentDocs
                                 join c in dc.CurrentRequests on pos.IdRequest equals c.IdRequest
                                 join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                                 join dep in dc.Departments on doc.IdDept equals dep.IdDept
                                 where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                 select pos;
        foreach (var item in deletePosReq)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        // delete action.
        var deleteReqAction = from a in dc.Actions
                                 join c in dc.CurrentRequests on a.IdRequest equals c.IdRequest
                                 join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                                 join dep in dc.Departments on doc.IdDept equals dep.IdDept
                                 where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                 select a;
        foreach (var item in deleteReqAction)
        {
            dc.Actions.DeleteOnSubmit(item);
        }
        // delete request.
        var deleteReq = from c in dc.CurrentRequests
                        join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                        join dep in dc.Departments on doc.IdDept equals dep.IdDept
                        where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                        select c;
        foreach (var item in deleteReq)
        {
            dc.CurrentRequests.DeleteOnSubmit(item);
        }
        // delete document.
        var deleteDoc = from doc in dc.Documents
                        where doc.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                        select doc;
        foreach (var item in deleteDoc)
        {
            dc.Documents.DeleteOnSubmit(item);
        }

    }
    private void deleteUsers()
    {
        // delete request Attachment.
        var deleteRequestAttac = from ra in dc.RequestAttachments
                                 join c in dc.CurrentRequests on ra.IdRequest equals c.IdRequest
                                 join u in dc.Users on c.IdUser equals u.UserId
                                 join dep in dc.Departments on u.IdDept equals dep.IdDept
                                 where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                 select ra;
        foreach (var item in deleteRequestAttac)
        {
            dc.RequestAttachments.DeleteOnSubmit(item);
        }
        // delete position of request.
        var deletePosCurr = from pos in dc.PositionOfCurrentDocs
                                 join c in dc.CurrentRequests on pos.IdRequest equals c.IdRequest
                                 join u in dc.Users on c.IdUser equals u.UserId
                                 join dep in dc.Departments on u.IdDept equals dep.IdDept
                                 where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                 select pos;
        foreach (var item in deletePosCurr)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        //delete Actions.
        var deleteAction = from a in dc.Actions
                            join c in dc.CurrentRequests on a.IdRequest equals c.IdRequest
                            join u in dc.Users on c.IdUser equals u.UserId
                            join dep in dc.Departments on u.IdDept equals dep.IdDept
                            where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                            select a;
        foreach (var item in deleteAction)
        {
            dc.Actions.DeleteOnSubmit(item);
        }
        //delete request after deleteing its sons. 
        var deleteCurrentRequest = from c in dc.CurrentRequests
                                   join u in dc.Users on c.IdUser equals u.UserId
                                   join dep in dc.Departments on u.IdDept equals dep.IdDept
                                   where dep.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                   select c;
        foreach (var item in deleteCurrentRequest)
        {
            dc.CurrentRequests.DeleteOnSubmit(item);
        }
        // delete Users after deleting his/her request.
        var deleteUsersOfDept = from u in dc.Users
                                where u.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                select u ; 
        foreach (var item in deleteUsersOfDept)
	    {
		    dc.Users.DeleteOnSubmit(item);
	    }
    }
    private void deleteWorkFlow()
    {
        // delete position of request.
        var deleteposCurr = from pos in dc.PositionOfCurrentDocs
                            join w in dc.WorkflowDocuments on pos.IdWorkflowDoc equals w.IdWorkflowDoc
                            where pos.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                            select pos;
        foreach (var item in deleteposCurr)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        // delete workflow after deleteing its son.
        var deleteWorkflowDoc = from w in dc.WorkflowDocuments
                                where w.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                                select w;
        foreach (var item in deleteWorkflowDoc)
        {
            dc.WorkflowDocuments.DeleteOnSubmit(item);
        }

    }
    private void deletePosReq()
    {
        // position of current request.
        var deletePosCurrDoc = from pos in dc.PositionOfCurrentDocs
                               where pos.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                               select pos;
        foreach (var item in deletePosCurrDoc)
        {
            dc.PositionOfCurrentDocs.DeleteOnSubmit(item);
        }
        
    }
    private void deleteGreivance()
    {

        // greivance.
        var deleteGreivance = from g in dc.Greivances
                              where g.IdDept == int.Parse(IdDepartmrntDList.SelectedValue)
                              select g;
        foreach (var item in deleteGreivance)
        {
            dc.Greivances.DeleteOnSubmit(item);
        }
    }
    private void deleteForeignDataDepartment()
    {

        deletePosReq(); // 1.
        deleteGreivance(); // 2.
        deleteUsers(); // 3.
        deleteWorkFlow(); // 4.
        deleteDocument(); // 5.
        dc.SubmitChanges();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;

        if (IdDepartmrntDList.SelectedItem.Text == "Admin")
        {
            Response.Write("<script>alert('You can not delete this department.');</script>");
            return; 
        }

       try
       {
           if (IdDepartmrntDList.Items.Count == 0)
               Response.Write("<script>alert('There is no department to delete.');</script>");
           else
           {
               deleteForeignDataDepartment(); // delete all dependant data with department. 

               // then delete department will be done because all dependant data in this department has deleted.
               Department d1 = dc.Departments.First(p => p.IdDept == int.Parse(IdDepartmrntDList.SelectedValue));
               dc.Departments.DeleteOnSubmit(d1);
               dc.SubmitChanges();
               Response.Write("<script>alert('Done.');</script>");
               IdDepartmrntDList.DataBind(); // refresh items after deleteing.
           }
        }
      catch (Exception ex)
       {
           Response.Write("<script>alert('Error " + ex.Message + "');</script>");
       }
    }
    
}