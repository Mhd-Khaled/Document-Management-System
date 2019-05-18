using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DowmloadReqAttach : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        byte[] fileData;
        DataClassesDataContext dc = new DataClassesDataContext();
        var getFile = from ra in dc.RequestAttachments
                      where ra.IdRequestFile == int.Parse(GridView1.SelectedRow.Cells[1].Text)
                      select ra;

        // first row is the onlt row that returned by getFile.
        fileData = getFile.First().FileItSelf.ToArray();

        Response.Clear();
        string s = GridView1.SelectedRow.Cells[3].Text.Trim() ; 
        s = s.ToLower();


        Response.Buffer = true;
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        switch (s) // to remove spaces.
        {
            case ".docx":
                Response.ContentType = "application/vnd.ms-word.document";
                break;
            case ".pdf":
                Response.ContentType = "application/pdf";
                break;
            case ".jpg":
                Response.ContentType = "image/jpeg";
                break;
            case ".xls":
                Response.ContentType = "application/vnd.ms-excel";
                break;
            case ".xlsx":
                Response.ContentType = "application/vnd.ms-excel";
                break;
            default:
                Response.ContentType = GridView1.SelectedRow.Cells[3].Text;
                break;
        }

        Response.BinaryWrite(fileData);
        Response.Flush();
        Response.End();
    }
}