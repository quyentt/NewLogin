<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyCode.aspx.cs" Inherits="Apis.NewLogin.Pages.VerifyCode" %>
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
            <h2 class="text-center title-h2 color-dask-blue">Nhập mã xác nhận</h2>
            <form  runat="server">
                <form action="#" method="post" onsubmit="return false">
                    <div class="form-item position-relative mb-20">
                        <label for="exampleInputEmail1" class="form-label"><i class="fal fa-lock-alt"></i></label>
                        <input class="form-control" id="verify_code" name="verify_code"  placeholder="Nhập mã xác nhận" autocomplete="off" autofocus="autofocus" />
                    </div>
                    <div class="help-forgot d-flex justify-content-between  mb-20">
                        <asp:LinkButton runat="server" CssClass="forgot-pass color-dask-blue" ID="btnResend_VC" OnClick="resend_verifyCode_Click" Text="Tôi chưa nhận được mã"></asp:LinkButton><br>
                        <a href="#" class="help color-dask-blue"><i class="fal fa-question-circle"></i> Trợ giúp!</a>
                    </div>
                    <asp:Button ID="cms_verify_code" runat="server" CssClass="btn btn-primary btn-login" Text="Gửi" OnClick="authenCode_Click" />
                    <p class="text-center mt-3 mb-0"> 
                        <asp:Label Width="100%" runat="server" Text="" ID="lblNotify_VC"></asp:Label>
                        <a href="#"><asp:HyperLink CssClass="italic" Width="100%" runat="server" Text="" ID="linkEmail_VC" target="_blank" /></a> 
                    </p>
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
