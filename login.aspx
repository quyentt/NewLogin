<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Apis.NewLogin.Login" %>

<!DOCTYPE html>
<html lang="vi" class="aps-html">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cổng thông tin sinh viên &amp; nhập học trực tuyến</title>
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.ico" />
    <link rel="stylesheet" href="assets/css/login-new.css" />
    <link rel="stylesheet" href="assets/fonts/FontAwesome.Pro.6.4.2/css/all.css" />
</head>

<body class="aps-body">
    <form id="formLoginSSO" runat="server">
        <div class="aps-wrap aps-login">

            <!-- ================= HEADER ================= -->
            <header class="aps-header">
                <%
                    string _host = Request.Url.Host.ToLower();
                    string _logoPath = logo;
                    if (string.IsNullOrEmpty(_logoPath))
                    {
                        if (_host.Contains("eaut")) _logoPath = "assets/logocactruong/donga.png";
                    }
                %>
                <div class="aps-brand">
                    <img src="<%= _logoPath %>" alt=""
                         onerror="this.onerror=null;this.style.display='none';" />
                </div>
                <div class="aps-header_center">
                    <h2 class="aps-title">CỔNG THÔNG TIN SINH VIÊN &amp; NHẬP HỌC TRỰC TUYẾN</h2>
                    <p class="aps-subnote" style="margin-top: 10px;font-size: 16px;">
                        Tân sinh viên hoàn tất các bước nhập học và thanh toán trực tuyến dễ dàng, nhanh chóng
                    </p>
                </div>
                <div class="aps-header_right" aria-hidden="true"></div>
            </header>

            <!-- ================= MAIN ================= -->
            <main class="aps-main" style="margin-top: 30px;">

                <!-- ---- Left: Intro ---- -->
                <section class="aps-card aps-intro">
                    <div class="aps-intro_head">
                        <span class="aps-intro_badge">
                            <svg viewBox="0 0 24 24" fill="#fff">
                                <path d="M12 3 1 9l11 6 9-4.9V17h2V9L12 3zM5 13.2V17c0 1.7 3.1 3 7 3s7-1.3 7-3v-3.8l-7 3.8-7-3.8z" />
                            </svg>
                        </span>
                        <h2 class="aps-intro_title">DÀNH CHO TÂN SINH VIÊN NHẬP HỌC</h2>
                    </div>

                    <p class="aps-intro_lead">
                        Thí sinh thực hiện nhập học trực tuyến theo 3 bước đơn giản:<br />
                        <b>Nhập CCCD → Thanh toán phí nhập học → Nhận tài khoản qua email</b><br />
                        để tiếp tục hoàn tất hồ sơ và các bước tiếp theo.
                        <img class="aps-intro_illus" src="assets/images/img.png" alt="" />
                    </p>

                    <div class="aps-steps-thanhtoan">
                        <div class="aps-steps">
                            <span class="aps-steps_arrow aps-steps_arrow--1">
                                <svg viewBox="0 0 30 10" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round">
                                    <path d="M1 5h22" stroke-dasharray="3 3" />
                                    <path d="M23 1.5 28 5l-5 3.5" />
                                </svg>
                            </span>
                            <span class="aps-steps_arrow aps-steps_arrow--2">
                                <svg viewBox="0 0 30 10" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round">
                                    <path d="M1 5h22" stroke-dasharray="3 3" />
                                    <path d="M23 1.5 28 5l-5 3.5" />
                                </svg>
                            </span>
                            <div class="aps-step">
                                <div class="aps-step_top">
                                    <span class="aps-step_badge">1</span>
                                    <span class="aps-step_icon">
                                        <img src="assets/images/icon-step-01.png" alt="Nhập CCCD" />
                                    </span>
                                </div>
                                <p class="aps-step_title">NHẬP CCCD</p>
                                <p class="aps-step_text">Nhập số CCCD/CMND để tra cứu thông tin.</p>
                            </div>
                            <div class="aps-step">
                                <div class="aps-step_top">
                                    <span class="aps-step_badge">2</span>
                                    <span class="aps-step_icon">
                                        <img src="assets/images/icon-step-02.png" alt="Thanh toán phí" />
                                    </span>
                                </div>
                                <p class="aps-step_title">THANH TOÁN PHÍ</p>
                                <p class="aps-step_text">Thanh toán phí nhập học an toàn, nhanh chóng.</p>
                            </div>
                            <div class="aps-step">
                                <div class="aps-step_top">
                                    <span class="aps-step_badge">3</span>
                                    <span class="aps-step_icon">
                                        <img src="assets/images/icon-step-03.png" alt="Nhận tài khoản" />
                                    </span>
                                </div>
                                <p class="aps-step_title">NHẬN TÀI KHOẢN &amp;<br />HOÀN TẤT HỒ SƠ</p>
                                <p class="aps-step_text">Nhận tài khoản qua email để đăng nhập và hoàn tất hồ sơ.</p>
                            </div>
                        </div>
                        <div class="aps-intro_actions">
                            <a href="pages/thanhtoan.aspx" class="aps-btn aps-btn--orange">
                                <i class="fa-duotone fa-solid fa-credit-card"></i>
                                THANH TOÁN PHÍ NHẬP HỌC
                                <i class="fal fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </section>

                <!-- ---- Right: Login ---- -->
                <section class="aps-card aps-login-card">
                    <div class="aps-login_lock">
                        <i class="fas fa-lock-alt"></i>
                    </div>
                    <h2 class="aps-login_title">ĐĂNG NHẬP</h2>

                    <asp:Label runat="server" ID="lblNotify" CssClass="aps-notify" ForeColor="Red" Text=""></asp:Label>

                    <div class="aps-field">
                        <span class="aps-field_icon">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="8" r="4" />
                                <path d="M4 20c1.4-3.6 5-5 8-5s6.6 1.4 8 5" />
                            </svg>
                        </span>
                        <asp:TextBox ID="username" runat="server" placeholder="Nhập tài khoản hoặc email" autocomplete="username" />
                    </div>

                    <div class="aps-field">
                        <span class="aps-field_icon">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="4" y="10" width="16" height="11" rx="2.5" />
                                <path d="M8 10V7a4 4 0 0 1 8 0v3" />
                            </svg>
                        </span>
                        <asp:TextBox ID="password" runat="server" TextMode="Password" CssClass="form-control_login__password" placeholder="Mật khẩu" autocomplete="current-password" />
                        <button type="button" class="aps-field_toggle change_icon_wrap" aria-label="Hiện mật khẩu">
                            <i class="fal fa-eye change_icon"></i>
                        </button>
                    </div>

                    <div class="aps-login_meta">
                        <a href="pages/forgetpass.aspx" class="aps-link">Quên mật khẩu</a>
                        <a href="#" class="aps-link aps-link--help">
                            <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="9" />
                                <path d="M9.5 9.5a2.5 2.5 0 1 1 3.5 2.3c-.8.4-1 .9-1 1.7" />
                                <path d="M12 17h.01" />
                            </svg>
                            Trợ giúp!
                        </a>
                    </div>

                    <asp:Button ID="cms_authenticate_do_login" runat="server" CssClass="aps-btn aps-btn--primary" Text="ĐĂNG NHẬP" OnClick="cms_authenticate_do_login_Click" />

                    <%
                        if (urlgoogle != "" || urlmicrosoft != "")
                        {
                    %>
                    <div class="aps-divider">hoặc đăng nhập</div>
                    <%
                        }
                        if (urlgoogle != "")
                        {
                    %>
                    <div id="btnDangNhapGoogle" runat="server">
                        <a href="<%=urlgoogle %>" class="aps-btn aps-btn--google btn-google">
                            <svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true">
                                <path fill="#4285F4" d="M23.5 12.3c0-.8-.1-1.6-.2-2.3H12v4.5h6.5c-.3 1.5-1.1 2.8-2.4 3.7v3h3.9c2.3-2.1 3.5-5.2 3.5-8.9z" />
                                <path fill="#34A853" d="M12 24c3.2 0 5.9-1.1 7.9-2.9l-3.9-3c-1.1.7-2.5 1.2-4 1.2-3 0-5.6-2-6.5-4.8H1.5v3.1C3.5 21.3 7.4 24 12 24z" />
                                <path fill="#FBBC05" d="M5.5 14.5c-.2-.7-.4-1.5-.4-2.5s.1-1.7.4-2.5V6.4H1.5C.7 8 .3 9.9.3 12s.4 4 1.2 5.6l4-3.1z" />
                                <path fill="#EA4335" d="M12 4.8c1.7 0 3.2.6 4.4 1.7l3.3-3.3C17.9 1.2 15.2 0 12 0 7.4 0 3.5 2.7 1.5 6.4l4 3.1C6.4 6.7 9 4.8 12 4.8z" />
                            </svg>
                            Đăng nhập với Google
                        </a>
                    </div>
                    <%
                        }
                        if (urlmicrosoft != "")
                        {
                    %>
                    <a id="btnDangNhapMicrosoft" href="<%=urlmicrosoft %>" class="aps-btn aps-btn--microsoft">
                        <img src="assets/images/microsoft_logg.svg" alt="" />
                        Đăng nhập với Microsoft
                    </a>
                    <%
                        }
                    %>
                </section>
            </main>

            <!-- ================= FEATURES ================= -->
            <footer class="aps-features">
                <div class="aps-feature">
                    <span class="aps-feature_icon"><i class="fa-duotone fa-solid fa-shield-check"></i></span>
                    <div>
                        <p class="aps-feature_title">Bảo mật tuyệt đối</p>
                        <p class="aps-feature_text">Thông tin được bảo mật an toàn tuyệt đối</p>
                    </div>
                </div>
                <div class="aps-feature">
                    <span class="aps-feature_icon"><i class="fa-duotone fa-thin fa-lock-keyhole"></i></span>
                    <div>
                        <p class="aps-feature_title">Thanh toán an toàn</p>
                        <p class="aps-feature_text">Hệ thống thanh toán được bảo mật 24/7</p>
                    </div>
                </div>
                <div class="aps-feature">
                    <span class="aps-feature_icon"><i class="fa-duotone fa-thin fa-headset"></i></span>
                    <div>
                        <p class="aps-feature_title">Hỗ trợ 24/7</p>
                        <p class="aps-feature_text">Đội ngũ hỗ trợ luôn sẵn sàng giải đáp mọi thắc mắc</p>
                    </div>
                </div>
                <div class="aps-feature">
                    <span class="aps-feature_icon"><i class="fa-duotone fa-solid fa-badge-check"></i></span>
                    <div>
                        <p class="aps-feature_title">Xác nhận nhanh chóng</p>
                        <p class="aps-feature_text">Xử lý và xác nhận thông tin nhanh chóng</p>
                    </div>
                </div>
            </footer>

            <div class="aps-copyright">
                <marquee>
                    Đơn vị phát triển: Công ty Cổ Phần dịch vụ Công nghệ APIS - Địa chỉ: Tầng 6 Tháp Tây, Tòa nhà Hancorp,
                    Số 72 Trần Đăng Ninh, P. Cầu Giấy, Hà Nội - Điện thoại: 024 3204 5867
                </marquee>
            </div>
        </div>
    </form>

    <script src="assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            sessionStorage.removeItem("objUserN");
            localStorage.removeItem('strChucNang');
            localStorage.removeItem('strChucNang_Id');

            if (isEmbeddedWebView()) {
                var $g = $('a.btn-google');
                if ($g.length) {
                    var url = $g.attr('href');
                    $g.attr('href', '#');
                    $g.on('click', function (e) {
                        e.preventDefault();
                        alert("Không thể xác thực đăng nhập Google trong web nhúng. Hãy bấm ... ở góc phải rồi chọn Mở bằng Safari hoặc Chrome để đăng nhập Google.");
                        window.location.href = "phone://open-external?url=" + encodeURIComponent(url);
                    });
                }
            }

            // Show / hide password
            var $pwd = $('.form-control_login__password');
            var $icon = $('.change_icon');
            $('.change_icon_wrap').on('click', function () {
                var input = $pwd.get(0);
                if (!input) return;
                if (input.type === 'password') {
                    input.type = 'text';
                    $icon.removeClass('fa-eye').addClass('fa-eye-slash');
                } else {
                    input.type = 'password';
                    $icon.removeClass('fa-eye-slash').addClass('fa-eye');
                }
            });
        });

        // Auto redirect Microsoft SSO for congsinhvien portal
        setTimeout(function () {
            try {
                if (window.location.href.indexOf('congsinhvien') != -1) {
                    var pointMi = $("#btnDangNhapMicrosoft");
                    var url = pointMi.attr("href");
                    if (url) window.location.href = url;
                    if (pointMi.length > 0) pointMi.trigger("click");
                }
            } catch (e) { }
        }, 3000);

        function isEmbeddedWebView() {
            var ua = navigator.userAgent || navigator.vendor || window.opera;
            var isAndroidWebView =
                /; wv\)/i.test(ua) ||
                (/Android/i.test(ua) && /Version\/[\d.]+/i.test(ua));
            var isiOS = /iPhone|iPad|iPod/i.test(ua);
            var isiOSWebView = isiOS && /AppleWebKit/i.test(ua) && !/Safari/i.test(ua);
            var isInAppBrowser =
                /Zalo/i.test(ua) ||
                /FBAN|FBAV/i.test(ua) ||
                /Instagram/i.test(ua) ||
                /Line/i.test(ua) ||
                /Messenger/i.test(ua);
            return isAndroidWebView || isiOSWebView || isInAppBrowser;
        }
    </script>
</body>
</html>
