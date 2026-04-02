<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPass.aspx.cs" Inherits="Apis.NewLogin.Pages.ForgetPass" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/css/styles.css">
</head>

<body>
<div class="wrapper wrapper-login">
    <div class="content-login">
        <div class="logo-Phenikaa-w justify-content-center d-flex">
             <img src="../<%= Apis.CommonV1.Base.AppSetting.GetString("Logo") %>" class="img-logo-w" alt="">
        </div>
        <!-- content -->
        <div class="content-form-login position-relative box-forgot-pass">
            <div class="forgot-pass-img text-center"><img src="../assets/images/forgot-pass.png"></div>
            <h2 class="text-center title-h2 color-dask-blue">Khôi phục mật khẩu</h2>
            <form runat="server">
                <form  action="#" method="post" onsubmit="return false">
                    <div class="form-item position-relative mb-20">
                        <label for="exampleInputEmail1" class="form-label"><i class="fal fa-envelope-open-text"></i></label>
                        <input type="email" class="form-control"  id="email_getpassword" name="email_getpassword" autocomplete="off" autofocus="autofocus" aria-describedby="Vui lòng nhập email của bạn" placeholder="Vui lòng nhập email của bạn">
                    </div>
                            <asp:Label Width="100%" runat="server" Text="" ID="lblNotify_FP"></asp:Label>
                    <div class="help-forgot d-flex justify-content-between  mb-20">
                        <a href="#" class="forgot-pass color-dask-blue">Thử cách khác</a>
                        <a href="#" class="help color-dask-blue"><i class="fal fa-question-circle"></i> Trợ giúp!</a>
                    </div> 
                    <asp:Button ID="cms_forget_password" runat="server" CssClass="btn btn-primary btn-login"  type="submit" Text="Gửi" OnClick="getPassword_Click"></asp:Button>
                                <%--<asp:Button ID="cms_forget_password" runat="server" CssClass="btn btn-primary btn-block btn-flat" Text="Gửi" />--%>
                </form>
            </form>
        </div>
        <!-- end content -->

        <!-- copy right -->
        <div class="copyright ">
            <marquee>
                Đơn vị phát triển: Công ty Cổ Phần dịch vụ Công nghệ APIS - Địa chỉ: Tầng 6 Tháp Tây, Tòa nhà Hancorp,
                Số, 72 Trần Đăng Ninh, P, Cầu Giấy, Hà Nội - Điện thoại: 024 3204 5867
            </marquee>
        </div>
        <!-- end copy right -->

    </div>
</div>


</body>
<script src="../assets/js/bootstrap.bundle.min.js "></script>
<script src="../assets/js/swiper-bundle.min.js"></script>
<script src="../assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="../assets/js/slick.js"></script>
<script src="../assets/js/custom.js"></script>

</html>