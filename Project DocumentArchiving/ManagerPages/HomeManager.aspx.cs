using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class HomeUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        DataClassesDataContext dc = new DataClassesDataContext();
        
        var getDept = from u in dc.Users // get the department of current user for showing him his documents.
                      where u.UserId == int.Parse(Session["Id"].ToString())
                      select u;
        int myDepartmentID = 0;
        foreach (var v in getDept)
            myDepartmentID = v.IdDept;

        ViewState["dept"] = myDepartmentID; // hold department Id to other component in the same page.

        if (!IsPostBack) // Load list box from fillListBox query fro the first time only.
        {
            ListBox1.Visible = false;
            ListBox2.Visible = false;
            RadioButtonList1.Visible = false;
            NoteLabel.Visible = false;
            confirmBtn.Visible = false;
            NoteTBox.Visible = false;
            colorKeys.Visible = false;

            NoteLabel.Visible = false;
            ImageButton1.Visible = false;
            //noteBox.Visible = false;
            DownloadBtn.Visible = false; 
            NoteTBox.Text = "";

            fillList1();
        }

    }
    protected void InBox_Click(object sender, ImageClickEventArgs e)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "hideFrame", "<script>hideFrame()</script>");
        InBoxData();
    }
    protected int checkRequestAttachment() // method to get num of request atachment for request.
    {
        DataClassesDataContext dc = new DataClassesDataContext();
        var checkRequestFile = from c in dc.RequestAttachments // if field FileItSelf is null then skip this record.
                               join ra in dc.CurrentRequests on c.IdRequest equals ra.IdRequest
                               where c.FileItSelf != null && int.Parse(ListBox1.SelectedValue) == ra.IdRequest
                               select c;

        if (checkRequestFile.Count() == 0) // not showing download button when no request file is found.
            DownloadBtn.Visible = false;
        return checkRequestFile.Count(); // return number of file required.
                               
    }
    protected void InBoxData()
    {
        DataClassesDataContext dc = new DataClassesDataContext();
        ListBox1.Visible = true; // Re-enable controls for this user.
        ListBox2.Visible = false; // Re-enable controls for this user.
        RadioButtonList1.Visible = true;
        GridView1.Visible = true;
        NoteLabel.Visible = true;
        confirmBtn.Visible = true;
        NoteTBox.Visible = true;
        colorKeys.Visible = false;
        ImageButton1.Visible = false;
        DownloadBtn.Visible = true; 

        if (int.Parse(ViewState["NumReq"].ToString()) > 0) // the user have more than zero request in his listBox .
        {
            


            int countOfReqFile = checkRequestAttachment();

            var InBoxDetails = from p in dc.PositionOfCurrentDocs   //if document in Currentposition is same as user dept
                               join w in dc.Actions on p.IdAction equals w.IdAction // and its state ethier Studying or Wating
                               join c in dc.CurrentRequests on p.IdRequest equals c.IdRequest   // then display its apropriate request.
                               //join ra in dc.RequestAttachments on c.IdRequest equals ra.IdRequest // the join for show understandable info to user.
                               join d in dc.Documents on c.IdDoc equals d.IdDoc
                               join u in dc.Users on c.IdUser equals u.UserId
                               where p.IdDept == int.Parse(ViewState["dept"].ToString()) && (w.IdActionType == 1 || w.IdActionType == 4)
                               && c.IdRequest == int.Parse(ListBox1.SelectedValue)
                               select new { ID = u.UserId , Name = u.FirstName +" "+u.LastName,
                                   Document = d.DocumentName,  DateOfRequest = c.DateOf.ToShortDateString() , Request_Attachment = countOfReqFile
                                            
                               };

            GridView1.DataSource = InBoxDetails;
            GridView1.DataBind();
        }
        else    // if user has no request in his inbox at current time.
        {
            Response.Write("<script>alert('You have no Request in your Inbox right now')</script>");
        }
       // fillList(); // re-fill list.
    }
    protected void OutBoxData()
    {
        RadioButtonList1.Visible = false;
        ListBox1.Visible = false;
        ListBox2.Visible = true;
        colorKeys.Visible = true;

        GridView1.Visible = false;
        confirmBtn.Visible = false;
        NoteTBox.Visible = false;
        NoteLabel.Visible = false;
        DownloadBtn.Visible = false; 
        //noteBox.Visible = true;
        ImageButton1.Visible = true;

        DataClassesDataContext dc = new DataClassesDataContext(); // for getting what user request.
        var RequestQuery = from c in dc.CurrentRequests
                           join doc in dc.Documents on c.IdDoc equals doc.IdDoc
                           //join a in dc.Actions on c.IdRequest equals a.IdRequest
                           where c.IsCompletedUser == true && /*(a.IdActionType == 1 || a.IdActionType == 4) &&*/
                           c.IdUser == int.Parse(Session["Id"].ToString())
                           select new {c.IdRequest , doc.DocumentName , c.DateOf };
        bool firstValue = true;
        ListBox2.Items.Clear();
        foreach (var v in RequestQuery)
        {
            ListItem li = new ListItem(v.DocumentName , v.IdRequest.ToString());
            if (firstValue) // this condition will be true for the first time only.
            {
                DateLabel.Text = "Date of Request : " +  v.DateOf.ToShortDateString();
                li.Selected = true; // check the first index.
                firstValue = false; // disable bool variable firstValue because it is mission has completed.
            }
            ListBox2.Items.Add(li); // every time add a list to the listBox.
        }
    }
    protected void ListBox1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(this.GetType(), "hideFrame", "<script>hideFrame()</script>");// to hide frame.
        InBoxData();
    }
    protected void fillList1()
    {
        DataClassesDataContext dc = new DataClassesDataContext();
        ListBox1.Items.Clear(); // clear listBox if it has items.
        // Document.IdDoc -> (Request.IdDoc Request.idRequest) -> position.IdRequest -> 
        var fillListBox = from p in dc.PositionOfCurrentDocs   //if document in Currentposition is same as user dept
                           join w in dc.Actions on p.IdAction equals w.IdAction // and its state ethier Studying or Wating
                           join c in dc.CurrentRequests on p.IdRequest equals c.IdRequest   // then display its apropriate request.
                           //join ra in dc.RequestAttachments on c.IdRequest equals ra.IdRequest // the join for show understandable info to user.
                           join d in dc.Documents on c.IdDoc equals d.IdDoc
                           join u in dc.Users on c.IdUser equals u.UserId
                           where p.IdDept == int.Parse(ViewState["dept"].ToString()) && (w.IdActionType == 1 || w.IdActionType == 4)
                           select new
                           {
                               u.UserId,
                               d.DocumentName,
                               c.IdRequest
                           };

        //join c in dc.CurrentRequests on p.IdRequest equals c.IdRequest
        //join doc in dc.Documents on d.IdDept equals doc.IdDept
        //select new { c.IdUser, DocName = doc.DocumentName, idReq = c.IdRequest };

        bool firstValue = true; // check the first index in the listBox by a kind trick.
        foreach (var v in fillListBox)
        {
            ListItem li = new ListItem(v.UserId.ToString() + "," + v.DocumentName, v.IdRequest.ToString());
            if (firstValue) // this condition will be true for the first time only.
            {
                li.Selected = true; // check the first index.
                firstValue = false; // disable bool variable firstValue because it is mission has completed.
            }
            ListBox1.Items.Add(li); // every time add a list to the listBox.
        }

        ListBox1.DataBind(); // after insert all items bind the listbox.
        NumRequest.Text = fillListBox.Count().ToString();
        ViewState["NumReq"] = NumRequest.Text;
        GridView1.DataBind();
    }
    protected void confirmBtn_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;
        try
        {
            DataClassesDataContext dc = new DataClassesDataContext();

            var docFromReq = from c in dc.CurrentRequests // get the document from my request.
                             join d in dc.Documents on c.IdDoc equals d.IdDoc
                             where c.IdRequest == int.Parse(ListBox1.SelectedValue)
                             select d;
            int myDocId = 0;
            foreach (var item in docFromReq)
            {
                myDocId = item.IdDoc;
            }

            var countOfStep = from step in dc.WorkflowDocuments
                              join doc in dc.Documents on step.IdDoc equals doc.IdDoc
                              where doc.IdDoc == myDocId
                              group step by step.IdDoc into NumSteps
                              select new
                              {
                                  countOfNounPaper = NumSteps.Count()
                              };
            int count = 0;
            foreach (var v in countOfStep)
            {
                count = v.countOfNounPaper;     // get the number of requested file.
            }
            var myStep = from u in dc.WorkflowDocuments
                         join w in dc.PositionOfCurrentDocs on u.IdWorkflowDoc equals w.IdWorkflowDoc
                         where w.IdRequest == int.Parse(ListBox1.SelectedValue)
                         select new
                         {
                             idWorkflowe = u.IdWorkflowDoc,
                             StepInWorkflow = u.IdStep,
                             IdRequeste = w.IdRequest,
                         };
            int myStepInWorkflow = 0;
            int myIdWorkflow = 0;
            int myRequestId = 0;
            foreach (var v in myStep)
            {
                myRequestId = v.IdRequeste;
                myStepInWorkflow = v.StepInWorkflow;
                myIdWorkflow = v.idWorkflowe;
            }
            //------------here real work---------------

            var updateAction = from w in dc.WorkflowDocuments
                               join p in dc.PositionOfCurrentDocs on w.IdWorkflowDoc equals p.IdWorkflowDoc
                               where w.IdWorkflowDoc == myIdWorkflow && p.IdRequest == myRequestId
                               select new { CurrentActionId = p.IdAction };

            int myCurrentActionId = 0;
            foreach (var v in updateAction)
                myCurrentActionId = v.CurrentActionId;



            if (count == myStepInWorkflow) // this is the final step.
            {
                if (RadioButtonList1.SelectedItem.Text == "Studying") { } // do nothing .
                else if (RadioButtonList1.SelectedItem.Text == "Accept") // Approve request.
                {
                    Action a2 = dc.Actions.First(p => p.IdAction == myCurrentActionId);
                    a2.IdActionType = 2;
                    a2.ActionbyUserId = int.Parse(Session["Id"].ToString());
                    a2.Note = NoteTBox.Text;
                    a2.DateOfAction = DateTime.Now;
                    dc.SubmitChanges();

                    PositionOfCurrentDoc pos = dc.PositionOfCurrentDocs.First(p => p.IdWorkflowDoc == myIdWorkflow);
                    pos.IdAction = myCurrentActionId;
                    dc.SubmitChanges();

                    CurrentRequest curr = dc.CurrentRequests.First(p => p.IdRequest == myRequestId);
                    curr.IsCompleted = true;
                    dc.SubmitChanges();
                }
                else if (RadioButtonList1.SelectedItem.Text == "Deny") // deny request.
                {
                    Action a3 = dc.Actions.First(p => p.IdAction == myCurrentActionId);
                    a3.IdActionType = 3;
                    a3.ActionbyUserId = int.Parse(Session["Id"].ToString());
                    a3.Note = NoteTBox.Text;
                    a3.DateOfAction = DateTime.Now; 
                    dc.SubmitChanges();

                    PositionOfCurrentDoc pos = dc.PositionOfCurrentDocs.First(p => p.IdWorkflowDoc == myIdWorkflow);
                    pos.IdAction = myCurrentActionId;
                    dc.SubmitChanges();

                    CurrentRequest curr = dc.CurrentRequests.First(p => p.IdRequest == myRequestId);
                    curr.IsCompleted = true; // doc has completed.
                    dc.SubmitChanges();
                }
                else if (RadioButtonList1.SelectedItem.Text == "Waiting") // Waiting request.
                {
                    Action a4 = dc.Actions.First(p => p.IdAction == myCurrentActionId);
                    a4.IdActionType = 4;
                    a4.ActionbyUserId = int.Parse(Session["Id"].ToString());
                    a4.Note = NoteTBox.Text;
                    a4.DateOfAction = DateTime.Now;
                    dc.SubmitChanges();

                    PositionOfCurrentDoc pos = dc.PositionOfCurrentDocs.First(p => p.IdWorkflowDoc == myIdWorkflow);
                    pos.IdAction = myCurrentActionId;
                    dc.SubmitChanges();
                }
            }
            else if (myStepInWorkflow < count)
            {
                if (RadioButtonList1.SelectedItem.Text == "Studying") { }
                else if (RadioButtonList1.SelectedItem.Text == "Deny") // deny request.
                {
                    Action a3 = dc.Actions.First(p => p.IdAction == myCurrentActionId);
                    a3.IdActionType = 3;
                    a3.ActionbyUserId = int.Parse(Session["Id"].ToString());
                    a3.Note = NoteTBox.Text;
                    a3.DateOfAction = DateTime.Now; 
                    dc.SubmitChanges();

                    PositionOfCurrentDoc pos = dc.PositionOfCurrentDocs.First(p => p.IdWorkflowDoc == myIdWorkflow);
                    pos.IdAction = myCurrentActionId;
                    dc.SubmitChanges();

                    CurrentRequest curr = dc.CurrentRequests.First(p => p.IdRequest == myRequestId);
                    curr.IsCompleted = true; // doc has completed.
                    dc.SubmitChanges();
                }
                else if (RadioButtonList1.SelectedItem.Text == "Waiting") // Waiting request.
                {
                    Action a4 = dc.Actions.First(p => p.IdAction == myCurrentActionId);
                    a4.IdActionType = 4;
                    a4.ActionbyUserId = int.Parse(Session["Id"].ToString());
                    a4.Note = NoteTBox.Text;
                    a4.DateOfAction = DateTime.Now; 
                    dc.SubmitChanges();

                    PositionOfCurrentDoc pos = dc.PositionOfCurrentDocs.First(p => p.IdWorkflowDoc == myIdWorkflow);
                    pos.IdAction = myCurrentActionId;
                    dc.SubmitChanges();
                }

                    // if state is not deny or waiting then do the following .....
                    // i mean Accept state.
                else
                {


                    var next = from p in dc.WorkflowDocuments   // get the second step and for this doc not else.
                               where p.IdStep == (myStepInWorkflow + 1) && p.IdDoc == myDocId
                               select p;

                    int myNextDepartmentId = 0;
                    int myNextWOrkflowId = 0;
                    foreach (var v in next)
                    {
                        myNextDepartmentId = v.IdDept;
                        myNextWOrkflowId = v.IdWorkflowDoc;
                    }



                    Action a = dc.Actions.First(p => p.IdAction == myCurrentActionId); // change my Action after decide.
                    a.IdActionType = byte.Parse(RadioButtonList1.SelectedValue);
                    a.ActionbyUserId = int.Parse(Session["Id"].ToString());
                    a.Note = NoteTBox.Text;
                    a.DateOfAction = DateTime.Now; 
                    dc.SubmitChanges();

                    Action a1 = new Action
                    {
                        IdActionType = 1,
                        ActionbyUserId = int.Parse(Session["Id"].ToString()),
                        IdRequest = myRequestId,
                        Note = "No note has lefted."
                    };
                    dc.Actions.InsertOnSubmit(a1);
                    dc.SubmitChanges();

                    PositionOfCurrentDoc nextPos = new PositionOfCurrentDoc
                    {
                        IdWorkflowDoc = myNextWOrkflowId,
                        IdRequest = myRequestId,
                        IdDept = myNextDepartmentId,
                        IdAction = a1.IdAction
                    };
                    dc.PositionOfCurrentDocs.InsertOnSubmit(nextPos);
                    dc.SubmitChanges();
                }
            }
            fillList1(); // re-fill list after confirm.
            GridView1.DataBind();
            Response.Write("<script>alert('Done.');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }
    }
    protected void drawGraph()
    {
        ClientScript.RegisterStartupScript(this.GetType(), "showFrame", "<script>showFrame()</script>");// to show frame.
        if (ListBox2.Items.Count == 0)//in case user have no request that he has send.
        {
            Response.Write("<script>alert('No graph will drawn, You have no request right now.');</script>");
            return;
        }

        DataClassesDataContext dc = new DataClassesDataContext();
        var steps = from d in dc.Documents      // query for get steps of documents (names of departments).
                    join w in dc.WorkflowDocuments on d.IdDoc equals w.IdDoc
                    join dep in dc.Departments on w.IdDept equals dep.IdDept
                    where d.DocumentName == ListBox2.SelectedItem.Text
                    select new
                    {
                        w.IdDept,
                        dep.Name,
                        w.IdStep
                    };
        var actionReq = from c in dc.CurrentRequests
                        join ac in dc.Actions on c.IdRequest equals ac.IdRequest
                        where c.IdRequest == int.Parse(ListBox2.SelectedValue)
                        select ac;

        HtmlInputHidden[] t = new HtmlInputHidden[steps.Count() + 1]; //hidden textbox same number as query above.
        HtmlInputHidden[] a = new HtmlInputHidden[steps.Count() + 1]; //hidden action same number as query above.
        HtmlInputHidden[] note = new HtmlInputHidden[steps.Count()+1]; // to get note when click on node.

        int index = 1; // index for iterating over t array.

        foreach (var item in steps) // store names of department of steps in html hidden fields.
        {
            t[index] = new HtmlInputHidden();
            t[index].ID = "t" + index;  // set id for getting it in javascript code.
            t[index].Value = item.Name; //set the value of hidden field as name of department to be written in the node.
            Page.Controls.Add(t[index]);
            index++;
        }
        int x = 1;
        for (int i = 0; i < steps.Count(); i++)//initial values for actions.
        {
            a[i+1] = new HtmlInputHidden();
            a[i+1].ID = "a" + (i+1);  // set id for getting it in javascript code.
            a[i + 1].Value = "0";

            note[i + 1] = new HtmlInputHidden(); //initialize note of user as "";
            note[i + 1].ID = "note" + (i + 1);
            note[i + 1].Value = "No note has lefted.";

            Page.Controls.Add(note[i + 1]);
            Page.Controls.Add(a[i + 1]);
        }
        

        foreach (var item in actionReq)
        {
            a[x].Value = item.IdActionType.ToString(); //set the value of hidden field as number of type of action to decide style of border of node.
            note[x].Value = item.Note; // set hidden field to note in database.
            x++; 
        }

        t[0] = new HtmlInputHidden();   // for sending count of query to javascript.
        t[0].Value = (index - 1).ToString();
        t[0].ID = "t0";
        Page.Controls.Add(t[0]);
        
    }
    protected void OutBox_Click(object sender, ImageClickEventArgs e)
    {
        // show the frame that contain the graph.
        // ajax not include it.
        ClientScript.RegisterStartupScript(this.GetType(), "showFrame", "<script>showFrame()</script>"); //no need for it.
        OutBoxData(); // get the requests that user has requested. 

        drawGraph();    //draw graph according to the selected value in listBox. 
        
    }
    protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
 
        DataClassesDataContext dc = new DataClassesDataContext();
        var dateReq = from c in dc.CurrentRequests  // to refresh the date of request.
                      where c.IdRequest == int.Parse(ListBox2.SelectedValue)
                      select c;
        foreach (var item in dateReq)
        {
            DateLabel.Text = "Date of Request : " + item.DateOf.ToShortDateString();
        }
        drawGraph();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue == "No") // if no then do nothing.
            return;
        if (ListBox2.Items.Count == 0)
            return;

        DataClassesDataContext dc = new DataClassesDataContext();
        var getReq = from c in dc.CurrentRequests
                     where c.IdRequest == int.Parse(ListBox2.SelectedValue)
                     select c;
        bool IsReqCompleted = false;
        foreach (var item in getReq)
        {
            IsReqCompleted = item.IsCompleted;
        }
        if (IsReqCompleted) // if request is completed then permit user to erase it.
        {
            CurrentRequest req = dc.CurrentRequests.First(p => p.IdRequest == int.Parse(ListBox2.SelectedValue));
            req.IsCompletedUser = false;
            Response.Write("<script>alert('Done.');</script>");
            dc.SubmitChanges();
            ListBox2.DataBind();
        }
        else
            Response.Write("<script>alert('You can not delete this document, the Document processing');</script>");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/DownloadReqAttach.aspx?IdRequestOfFile=" + ListBox1.SelectedValue);
    }
}
