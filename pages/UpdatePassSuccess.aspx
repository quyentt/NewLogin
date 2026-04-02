<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdatePassSuccess.aspx.cs" Inherits="Apis.NewLogin.Pages.UpdatePassSuccess" %>
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
            <div class="forgot-pass-img text-center"><img src="../assets/images/forgot-pass-successful.png"></div>
            <h2 class="text-center title-h2 color-dask-blue" style="line-height: 44px">Cập nhật mật khẩu<br> <b class="text-uppercase">
                        <asp:Label Width="100%" runat="server" Text="" ID="lblNotify_UPS"></asp:Label></b></h2>
            <p class="text-center mt-3 mb-0"><a href="../login.aspx" ><i class="fal fa-long-arrow-left"></i> Quay lại đăng nhập</a> </p>
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