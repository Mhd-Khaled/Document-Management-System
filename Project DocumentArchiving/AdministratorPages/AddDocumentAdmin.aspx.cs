using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Add_Document : System.Web.UI.Page
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
        var CheckFound = from d in dc.Documents
                         where d.DocumentName == DocumentNameTBox.Text
                         select d;
        if (CheckFound.Count() > 0)//if query has rows then document is already found in database.
        {
            Response.Write("<script>alert('Document of type " + DocumentNameTBox.Text + " is already exist');</script>");
            return true;
        }
        return false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue != "Yes") // if no then do nothing.
            return;
        try
        {
        if (checkValueIsFound())
            return; 


            DataClassesDataContext dc = new DataClassesDataContext();
            Document d1 = new Document { DocumentName = DocumentNameTBox.Text, IdDept = int.Parse(DepartmentDList.SelectedValue) };
            dc.Documents.InsertOnSubmit(d1);
            dc.SubmitChanges();
            Response.Write("<script>alert('Done.');</script>");
            DropDownList1.DataBind(); // to refresh dropdownList after adding a document.
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error" + ex.Message + "');</script>");
        }
    }
    private bool checkNounPaperIsFound()
    {
        // after get decide check the value.
        DataClassesDataContext dc = new DataClassesDataContext();
        // check if this doc is already exist.
        var CheckFound = from d in dc.DocDetails
                         where d.NameOfNounPaper == NameNounPaperTxt.Text && 
                         d.IdDoc == int.Parse(DropDownList1.SelectedValue)
                         select d;
        if (CheckFound.Count() > 0)//if query has rows then NounPaper is already found in database.
        {
            Response.Write("<script>alert('Duplicated values Noun Paper : " + DocumentNameTBox.Text + ", it is already exist');</script>");
            return true;
        }
        return false;
    }
    protected void InsertBtn_Click(object sender, EventArgs e)
    {

        string confirmValue = Request.Form["confirm_value"]; // get the answer of the user decide.
        if (confirmValue == "No") // if no then do nothing.
            return;
        try
        {
            if (checkNounPaperIsFound())
                return; 

            DataClassesDataContext dc = new DataClassesDataContext();
            var countPaper = from dt in dc.DocDetails // get the number of nounPaper of a document.
                             where dt.IdDoc == int.Parse(DropDownList1.SelectedValue)
                             group dt by dt.IdDoc into numNounPaper
                             select new
                             {
                                 myNounPaperCount = numNounPaper.Count()
                             };
            int count = 0;
            if (countPaper.Count() > 0) // in case query has no data or database is empty.
            {
                foreach (var v in countPaper)
                {
                    count = v.myNounPaperCount;
                }
            }
            DocDetail d = new DocDetail // insert values of new noun paper.
            {
                IdDoc = int.Parse(DropDownList1.SelectedValue),
                NumNounPaper = byte.Parse((count+1).ToString()),
                NameOfNounPaper = NameNounPaperTxt.Text
            };
            dc.DocDetails.InsertOnSubmit(d);
            dc.SubmitChanges();

            GridView1.DataBind();
            Response.Write("<script>alert('Done.');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('"+ex.Message+"');</script>");
        }

    }
    protected void DepartmentDList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DepartmentDList_SelectedIndexChanged1(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
}