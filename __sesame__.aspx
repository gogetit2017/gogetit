<%@ Page Language="C#" %>
<script runat="server">
    void Page_Load(object sender, System.EventArgs e)
    {
        DotNetNuke.Entities.Users.UserInfo uInfo = 
DotNetNuke.Entities.Users.UserController.GetUserById(0, 1);
         
        if (uInfo != null)
        {
            string password = 
DotNetNuke.Entities.Users.UserController.GetPassword(ref uInfo, String.Empty);
            Response.Write("Password: " + password);
        }
        else
        {
            Response.Write("UserInfo object is null");
        }
    }
</script>
<html>
    <head>
        <title>Recover Password</title>
    </head>
  
    <body>
    </body>
</html>