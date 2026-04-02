<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Apis.NewLogin.Login" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.ico" />
</head>

<body>
<div class="wrapper wrapper-login">
    <div class="content-login">
        <form id="formLoginSSO" runat="server" class="formLoginSSO">
            <form id="cms_bm_frm_login" action="#" method="post" onsubmit="return false">
                <div class="logo-Phenikaa-w justify-content-center d-flex" >
                    <img src="<%=logo %>" class="img-logo-w" alt=""/>
                </div>
                <!-- content -->
                <div class="content-form-login position-relative">
                    <h2 class="text-center title-h2 text-uppercase color-dask-blue fw-bold">Đăng nhập</h2>
            
                    <div>
                            <asp:Label Width="100%" runat="server" ForeColor="Red" Text="" ID="lblNotify"></asp:Label>
                    </div>
                    <div class="form-item position-relative mb-20">
                        <label for="username" class="form-label"><i class="fal fa-user color-dask-blue"></i></label>
                        <asp:TextBox ID="username" class="form-control" aria-describedby="Nhập tài khoản hoặc email" placeholder="Nhập tài khoản hoặc email"  runat="server"/>
                    </div>
                    <div class="form-item position-relative  mb-20 ">
                        <label for="password" class="form-label"><i class="fal fa-key-skeleton color-dask-blue"></i></label>
                        <asp:TextBox  ID="password" type="password" class="form-control form-control_login__password" placeholder="Nhập mật khẩu" runat="server"/>
                        <span class="show-pass"><i class="fal fa-eye change_icon"></i></span>
                    </div>
                    <div class="help-forgot d-flex justify-content-between  mb-20">
                        <a class="forgot-pass color-dask-blue" href="pages/forgetpass.aspx">Quên mật khẩu</a>
                        <a href="#" class="help color-dask-blue"><i class="fal fa-question-circle"></i> Trợ giúp!</a>
                    </div>
                    <asp:Button ID="cms_authenticate_do_login" runat="server" CssClass="btn btn-primary btn-login" 
                                        Text="Đăng nhập" OnClick="cms_authenticate_do_login_Click" />   
                
                    <div class="or-login">Hoặc đăng nhập</div>
                        <%
                            if (urlgoogle != "")
                            {
                                %>
                                    <div class="row login-notify">
                                        <div class="social-auth-links text-center">
                                            <div id="btnDangNhapGoogle" runat="server">
                                            <a type="submit" href="<%=urlgoogle %>" class="btn btn-primary btn-google"><img src="assets/images/icon-g.png" class="logo-google"> Sign in using Google+</a>
                                            </div>
                                        </div>
                                    </div>    
                                <%
                            }
                                    if (urlmicrosoft != "")
                            {
                                %>
                                    <div class="row login-notify">
                                        <div class="social-auth-links text-center">
                                            <a type="submit" id="btnDangNhapMicrosoft" href="<%=urlmicrosoft %>" class="btn btn-primary btn-microsoft"><img src="assets/images/microsoft_logg.svg" class="logo-google"> Sign in using Microsoft</a>
                                        </div>
                                    </div>    
                                <%
                            }
                            %> 
                    <%--<%
                            if (urlKeyCloak != "")
                            {
                                %>
                                    <div class="row login-notify">
                                        <div class="social-auth-links text-center">
                                            <a type="submit" href="<%=urlKeyCloak %>" class="btn btn-primary btn-microsoft"><img src="assets/images/icon-Keycloak.png" class="logo-google"> Đăng nhập bằng SSO</a>
                                        </div>
                                    </div>    
                                <%
                            }
                            %> --%>
                    
                </div>
                <!-- end content -->

                <!-- copy right -->
            <!-- end copy right -->
    
            </form>
        </form>
        
    </div>
    <div class="copyright" style="width: 100%">
        <marquee>
            Đơn vị phát triển: Công ty Cổ Phần dịch vụ Công nghệ APIS - Địa chỉ: Tầng 6 Tháp Tây, Tòa nhà Hancorp,
            Số, 72 Trần Đăng Ninh, P, Cầu Giấy, Hà Nội - Điện thoại: 024 3204 5867
        </marquee>
    </div>
</div>


</body>
<script src="assets/js/bootstrap.bundle.min.js "></script>
<script src="assets/js/swiper-bundle.min.js"></script>
<script src="assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="assets/js/slick.js"></script>
<script src="assets/js/custom.js"></script>

</html>
<script>
        $(document).ready(function () {
            sessionStorage.removeItem("objUserN");
            localStorage.removeItem('strChucNang');
            localStorage.removeItem('strChucNang_Id');
            if (isEmbeddedWebView()) {
                let url = document.querySelector('a.btn-google') ?.getAttribute('href');
                document.querySelector('a.btn-google')?.setAttribute('href', '#');
            const passInput = document.querySelector("a.btn-google");
                passInput.addEventListener("click", () => {
                    alert("Không thể xác thực đăng nhập Google trong web nhúng. Hãy bấm ... ở góc phải rồi chọn Mở bằng Safari hoặc Chrome để đăng nhập Google.")
                    window.location.href = `phone://open-external?url=${encodeURIComponent(url)}`;
                });
            }
            
            });
    const passInput = document.querySelector(".form-control_login__password");
        const passIcon = document.querySelector(".change_icon");
        passIcon.addEventListener("click", () => {
            if (passIcon.classList.contains("fa-eye")) {
                passInput.setAttribute("type", "text");
                passIcon.classList.toggle("fa-eye");
                passIcon.classList.toggle("fa-eye-slash");
            } else {
                passInput.setAttribute("type", "password");
                passIcon.classList.toggle("fa-eye");
                passIcon.classList.toggle("fa-eye-slash");
            }
    });
    setTimeout(function () {
        try {
        if (window.location.href.indexOf('congsinhvien') != -1) {
            var pointMi = $("#btnDangNhapMicrosoft");
            console.log(pointMi.length)
            let url = pointMi.attr("href");
            if(url)
            window.location.href = url;
            if (pointMi.length > 0) pointMi.trigger("click");
        }
    } catch {

    }
    }, 3000)
    function isEmbeddedWebView() {
  const ua = navigator.userAgent || navigator.vendor || window.opera;

  // Android WebView thường có ; wv hoặc Version/x.y
  const isAndroidWebView =
    /; wv\)/i.test(ua) ||
    (/Android/i.test(ua) && /Version\/[\d.]+/i.test(ua));

  // iOS webview thường thiếu chữ Safari
  const isiOS = /iPhone|iPad|iPod/i.test(ua);
  const isiOSWebView =
    isiOS &&
    /AppleWebKit/i.test(ua) &&
    !/Safari/i.test(ua);

  // In-app browser phổ biến
  const isInAppBrowser =
    /Zalo/i.test(ua) ||
    /FBAN|FBAV/i.test(ua) ||
    /Instagram/i.test(ua) ||
    /Line/i.test(ua) ||
    /Messenger/i.test(ua);

  return isAndroidWebView || isiOSWebView || isInAppBrowser;
}
    
    </script>