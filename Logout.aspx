<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="Apis.NewLogin.Logout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
       <script type="text/javascript">
                
            $(document).ready(function () {
                    sessionStorage.removeItem("objUser");
                    localStorage.removeItem('strChucNang');
                    localStorage.removeItem('strChucNang_Id'); 
                });
            
        </script>
     
</html>
