using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Request : System.Web.UI.Page
{
    public void initial()
    {
        TitleLabel.Text = RequestDList.SelectedItem.ToString() + " Document";
        DateLabel.Text = System.DateTime.Now.ToString();
        UserNameLabel.Text = Session["Name"].ToString();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Islogged"] == null)
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        if (Session["IsLogged"].ToString() != "LoggingCorrectly") // more protect than Session["IsLogged] != null.
            Response.Redirect("~/VisitorPages/HomeVisitor.aspx");

        ViewState["NumFileUpload"] = 0;
        if (IsPostBack)
        {
            if (RequestDList.SelectedItem.ToString() == "None")
            {
                TitleLabel.Text = "";
                DateLabel.Text = "";
                UserNameLabel.Text = "";
                requestedFileLabel.Text = "";
            }
            else
            {
                initial();
                requetedUploadFiles();
            }
        }
        else
        {
            ListItem l = new ListItem("None", "0");
            l.Selected = false;
            RequestDList.Items.Insert(0, l);
        }
    }
    protected void requetedUploadFiles()
    {
        DataClassesDataContext dc = new DataClassesDataContext();
        var countOfDoc = from detail in dc.DocDetails     // a query to determine number of requested file to  
                         join doc in dc.Documents on detail.IdDoc equals doc.IdDoc     // add upload file tool dynamicly. 
                         where detail.IdDoc == int.Parse(RequestDList.SelectedValue)
                         group detail by detail.IdDoc into query
                         select new
                         {
                             countOfNounPaper = query.Count(),
                         };
        int count = 0;
        foreach (var v in countOfDoc)
        {
            count = v.countOfNounPaper;     // get the number of requested file.
        }
        if (count == 0)
            requestedFileLabel.Text = "This document does not require any noun paper"; // if query return 0.
        else // else if query more than 0 .
        {
            // decorate upload file tool with table view.

            for (int i = 0; i < count; i++)
            {
                Label l1 = new Label();
                FileUpload fUp = new FileUpload();

                l1.Text += "<br><br>Upload File &nbsp" + (i + 1).ToString();
                l1.Text += "&nbsp&nbsp&nbsp";
                Panel1.Controls.Add(l1);

                fUp.ID = "file" + i.ToString();
                Panel1.Controls.Add(fUp);
            }
            ViewState["NumFileUpload"] = count;
            // --------------------------------------
            var nameOfDoc = from v in dc.DocDetails
                            where v.IdDoc == int.Parse(RequestDList.SelectedValue)
                            select v;

            requestedFileLabel.Text = "";
            foreach (var v in nameOfDoc)
            {
                requestedFileLabel.Text += "<ul><li>" + v.NameOfNounPaper + "</li></ul>"; //to view in order view.
            }
        }
    }
    private bool checkTimeCondition(DateTime TimeOfNow)
    {
        DataClassesDataContext dc = new DataClassesDataContext();

        var getLastTimeReq = from c in dc.CurrentRequests // order by date.
                             orderby c.DateOf descending
                             where c.IdDoc == int.Parse(RequestDList.SelectedValue) &&
                             c.IdUser == int.Parse(Session["Id"].ToString())
                             select c;

        if (getLastTimeReq.Count() == 0) // in case this is the first time user make the request.
            return true; 

        String s = (getLastTimeReq.First().DateOf.Subtract(TimeOfNow).Days.ToString());// get deferance in days.
        if (int.Parse(s) < 0) // time of registration > Time of Now.
            return true;
        else
            return false;

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;

        try
        {
            if (!checkTimeCondition(DateTime.Now)) // request made in less than one day.
            {
                Response.Write("<script>alert('Sorry, You can not make more than 1 request of a document at same day');</script>");
                return; 
            }

            DataClassesDataContext dc = new DataClassesDataContext();
            var countOfStep = from step in dc.WorkflowDocuments // count step is required to determine the document that
                              // has no workflow.
                              join doc in dc.Documents on step.IdDoc equals doc.IdDoc
                              where doc.IdDoc == int.Parse(RequestDList.SelectedValue)
                              group step by step.IdDoc into NumSteps
                              select new
                              {
                                  countOfNounPaper = NumSteps.Count()
                              };
            int countSteps = 0;
            foreach (var item in countOfStep)
            {
                countSteps = item.countOfNounPaper;
            }

            if (RequestDList.SelectedItem.ToString() == "None")
            {
                Response.Write("<script>alert('Please choose type of a document you want to produce')</script>");
                return;
            }
            if (countSteps == 0)
            {
                Response.Write("<script>alert('This document has no workflow yet, as result,you can not make request of this document at this time.')</script>");
                return;
            }
            if (!Boolean.Parse(ViewState["argsValid"].ToString())) // way to ecsape from client side validation.
                return;

            CurrentRequest r = new CurrentRequest       // add request from user.
            {
                IdDoc = int.Parse(RequestDList.SelectedValue),
                IdUser = int.Parse(Session["Id"].ToString()),
                Title = TitleLabel.Text,
                DateOf = System.DateTime.Parse(DateLabel.Text),
                IsCompleted = false,
                IsCompletedUser = true // 1 is initial state to point that user has sent request and don't delete them. 
            };

            dc.CurrentRequests.InsertOnSubmit(r);
            dc.SubmitChanges();
            //---------------------------
            int count = int.Parse(ViewState["NumFileUpload"].ToString());
            int counter = 0;
            if (count > 0)
            {
                FileUpload[] numUploadFiles = new FileUpload[count];
                foreach (var v in Panel1.Controls)
                {
                    if (v is FileUpload)
                    {
                        numUploadFiles[counter] = (FileUpload)v;
                        counter++;
                    }
                }

                for (int i = 0; i < count; i++)//missing file type.
                {
                    if (numUploadFiles[i].HasFile)
                    {
                        //string extension = numUploadFiles[i].FileName.Substring(numUploadFiles[i].FileName.IndexOf('.'), numUploadFiles[i].FileName.Length);
                        //extension = extension.ToLower(); // convert characters to lower.
                        //if (extension != "pdf" || extension != "jpg")
                        //{
                        RequestAttachment ra = new RequestAttachment
                        {
                            IdRequest = r.IdRequest,
                            FileName = numUploadFiles[i].FileName.Substring(0, numUploadFiles[i].FileName.IndexOf('.')),
                            FileTyp = numUploadFiles[i].FileName.Substring(numUploadFiles[i].FileName.IndexOf('.') ,
                            numUploadFiles[i].FileName.Length - numUploadFiles[i].FileName.IndexOf('.')),
                            FileItSelf = numUploadFiles[i].FileBytes
                        };

                        dc.RequestAttachments.InsertOnSubmit(ra);
                        //}
                    }


                }
            }
            else
            {
                RequestAttachment ra = new RequestAttachment
                {
                    IdRequest = r.IdRequest,
                    FileName = null,
                    FileTyp = null,
                    FileItSelf = null
                };
                dc.RequestAttachments.InsertOnSubmit(ra);
            }
            dc.SubmitChanges();
            //---------------------------
            var WorkfolwId = from v in dc.WorkflowDocuments // get idWorkFlow (it is incremental) .
                             where v.IdStep == 1 && v.IdDoc == int.Parse(RequestDList.SelectedValue)
                             select v;
            int myIdWorkFlowDoc = 0; // a variable to hold idWorkflow.
            int myDepartment = 0;
            foreach (var v in WorkfolwId)
            {
                myDepartment = v.IdDept;
                myIdWorkFlowDoc = v.IdWorkflowDoc;
            }
            // add record to postionWorkFlow after produce request instantly. 

            Action a = new Action
            {
                IdActionType = 1,
                ActionbyUserId = int.Parse(Session["Id"].ToString()),
                IdRequest = r.IdRequest
            };
            dc.Actions.InsertOnSubmit(a);
            dc.SubmitChanges();
            //-----------------------
            PositionOfCurrentDoc p = new PositionOfCurrentDoc
            {
                IdWorkflowDoc = myIdWorkFlowDoc,
                IdRequest = r.IdRequest,
                IdDept = myDepartment /*deptOfWorkFlow*/ ,
                IdAction = a.IdAction
            };

            dc.PositionOfCurrentDocs.InsertOnSubmit(p);
            dc.SubmitChanges();
            Response.Write("<script>alert('Done.');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }
        //-----------------------
    }
    private List<string> FileExtentions(List<string> ext)
    {
        ext.Add(".pdf"); ext.Add(".jpg"); ext.Add(".png"); ext.Add(".bmp");
        return ext; 
    }
    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
       
        if (IsPostBack)
        {
            int i = 0;
            ViewState["argsValid"] = true; // initial state like doc require no attached file.
            if (RequestDList.SelectedValue != "0" && int.Parse(ViewState["NumFileUpload"].ToString()) > 0)
            {
                int count = (int)ViewState["NumFileUpload"]; // viewstate to hold number of upload file in the page.
                FileUpload[] file = new FileUpload[count];
                foreach (var item in Panel1.Controls) // search for file  upload tool inside the panel1.
                {
                    if (item is FileUpload)
                    {
                        file[i++] = (FileUpload)item;   // fill the item has found in the fileUpload array. 
                    }
                }
                CustomValidator3.ErrorMessage = "";     // erase error message because of multiple loads.
                bool ErrorHappend = false;
                List<string> extension = new List<string>(); ;
                extension =  FileExtentions(extension); // fill the array with appropriate extentions.
 
                for (int j = 0; j < count; j++)
                {
                    if (file[j].FileBytes.Length > 1024 * 1024*10)
                    {
                        CustomValidator3.ErrorMessage += " File" + (j + 1) + " is more than 1MB <br>"; // Accorrding
                        ErrorHappend = true;                    // to situation error message will define.
                    }
                    if (!file[j].HasFile)
                    {
                        CustomValidator3.ErrorMessage += " File "+ (j + 1) + " has not Selected <br>";
                        ErrorHappend = true;
                    }
                    else
                    {
                        //may i would use the traditional way (easy for coding) s.endWith(".pdf")..etc.
                        // but i used this way to less coupling if i want to add extension i add it to the list.
                        string s = file[j].FileName.ToLower(); // lowercase for every letter.
                        s = s.Substring(s.IndexOf('.'), s.Length - s.IndexOf('.')); // take the extention from file.
                        if (!extension.Contains(s)) //extension not allowed.
                        {
                            ErrorHappend = true;
                            CustomValidator3.ErrorMessage += " Not supported extention<br>";
                            break;
                        }
                    }
                }
                if (ErrorHappend)
                    args.IsValid = false;       // data not valid then error message will print.
                else
                    args.IsValid = true;        // data is valid every thing is ok.
                ViewState["argsValid"] = args.IsValid; 
            }
        }
    }
}