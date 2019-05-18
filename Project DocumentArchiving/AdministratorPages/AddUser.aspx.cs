using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddEmploayee : System.Web.UI.Page
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
        var CheckFound = from d in dc.Users
                         select d;
        List<string> duplicated = new List<string>(); // list to avoid probability of arrangement.
        foreach (var v in CheckFound)
        {
            if (v.UserId == int.Parse(IdUserTBox.Text))
                duplicated.Add("User ID : " + IdUserTBox.Text);
            if (v.UserName == UserNameTBox.Text)
            {
                duplicated.Add("User Name : " + UserNameTBox.Text);
            }
        }
        if (DateTime.Now.Subtract(DateTime.Parse(DateOfBirthTBox.Text)).Days <= 0)
            duplicated.Add("Date is not valid ");

        string s = "";
        bool found = false;
        foreach (var v in duplicated)
        {
            s += " " + v;
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
        if (checkValueIsFound())
            return;
        if(!bool.Parse(ViewState["NameOfUserValidation"].ToString()))
            return ; 

        bool isActiveAccount; // to know the value of radioButtonList.
        if (IsActiveRList.SelectedValue == "1") isActiveAccount = true;
        else isActiveAccount = false; 
            DataClassesDataContext dc = new DataClassesDataContext();
            //isActive add ,modifae .. 
            User u1 = new User { UserId = int.Parse(IdUserTBox.Text), FirstName = FirstNameTBox.Text, 
                LastName = LastNameTBox.Text, IdDept = int.Parse(DepartmentNameDList.SelectedValue), 
                UserName = UserNameTBox.Text, Password = PasswordTBox.Text, 
                TypeLogin = TypeLoginDList.SelectedItem.ToString(), TypeUserId = byte.Parse(TypeUserDlist.SelectedValue), 
                Email = EmailTBox.Text, DateOfBirth = System.DateTime.Parse(DateOfBirthTBox.Text) ,
                IsActive = isActiveAccount };
            dc.Users.InsertOnSubmit(u1);
            dc.SubmitChanges();
            Response.Write("<script>alert('Done');</script>");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('Error" + ex.Message+"');</script>");
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string s = FirstNameTBox.Text; // put the name in a temp variable.
        bool isValidValue = false;
        s = s.ToLower(); // convert the letters to lower case mode.
        for (int i = 0; i < s.Length; i++)
        {
            for (int j = 'a'; j < 'z'; j++)
            {
                  // the letter will compare its value with all letters (a-z).
                  // if this loop end and isvalidValue is has false value then
                  // this char is definintly not letter then we will break the loop
                 // in the next instraction.
                if (s[i] != j)
                    isValidValue = false;
                else
                {
                    isValidValue = true;
                    break; // will break only from the inner loop.
                }

            }
            if (!isValidValue) // the loop end and this variable has false value then 
                break;         // this char is not a letter.
               
        }
        if (isValidValue)
            args.IsValid = true;
        else args.IsValid = false;
        ViewState["NameOfUserValidation"] = isValidValue;
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string s = LastNameTBox.Text; // put the name in a temp variable.
        bool isValidValue = false;
        s = s.ToLower(); // convert the letters to lower case mode.
        for (int i = 0; i < s.Length; i++)
        {
            for (int j = 'a'; j <= 'z'; j++)
            {
                // the letter will compare its value with all letters (a-z).
                // if this loop end and isvalidValue is has false value then
                // this char is definintly not letter then we will break the loop
                // in the next instraction.
                if (s[i] != j)
                    isValidValue = false;
                else
                {
                    isValidValue = true;
                    break; // will break only from the inner loop.
                }
            }
            if (!isValidValue) // the loop end and this variable has false value then 
                break;         // this char is not a letter.
        }
        if (isValidValue)
            args.IsValid = true;
        else args.IsValid = false;
        ViewState["NameOfUserValidation"] = isValidValue;
    }
}