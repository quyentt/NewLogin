<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdatePass.aspx.cs" Inherits="Apis.NewLogin.Pages.UpdatePass" %>
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
            <h2 class="text-center title-h2 color-dask-blue">Vui lòng tạo mật khẩu mới</h2>
            <form runat="server">
                <form action="#" method="post" onsubmit="return false">
                    <div class="form-item position-relative  mb-20 ">
                        <label for="exampleInputPassword1" class="form-label"><i class="fal fa-key-skeleton color-dask-blue"></i></label>
                        <input type="password" class="form-control"  id="new_pass" name="new_pass" placeholder="Nhập mật khẩu mới"  autocomplete="off" autofocus="autofocus" />
                        <span class="hide-pass"><i class="fal fa-eye"></i></span>
                        <span class="show-pass"><i class="fal fa-eye-slash"></i></span>
                    </div>
                    <div class="form-item position-relative  mb-20 ">
                        <label for="exampleInputPassword2" class="form-label"><i class="fal fa-key-skeleton color-dask-blue"></i></label>
                        <input type="password" class="form-control" id="renew_pass" name="renew_pass" placeholder="Nhập lại mật khẩu"  autocomplete="off" autofocus="autofocus" />
                        <span class="hide-pass"><i class="fal fa-eye"></i></span>
                        <span class="show-pass"><i class="fal fa-eye-slash"></i></span>
                    </div>
                    <asp:Button ID="cms_update_pass" runat="server" OnClick="updatePass_Click" CssClass="btn btn-primary btn-login" Text="Cập nhật" />
                    <p class="text-center mt-3 mb-0"> <asp:Label Width="100%" runat="server" Text="" ID="lblNotify_UP"></asp:Label> </p>
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

