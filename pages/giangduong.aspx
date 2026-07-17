<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="giangduong.aspx.cs" Inherits="Apis.NewLogin.pages.giangduong" %>
<!DOCTYPE html>
<html lang="en" class="led-event">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/css/styles.css?v=1">
    <style>
        .led-header-title {
    color: #008fd5;
}
        .led-main {
    background: url(../assets/images/led/CMC_bg-led-event.png);
}

.leb-table .swiper-slide {
    height: 3.6rem;
    display: flex;
    width: 100%;
}

.led-table-cell:nth-child(1) {
    width: 12%;
}

.led-table-cell:nth-child(2) {
    width: 10%;
}

.led-table-cell:nth-child(3) {
    flex: 1;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    word-break: break-word;
    line-height: 3.6rem;
    margin-top: -10px
}

.led-table-cell:nth-child(4) {
    width: 37%;
}

.led-table-cell:nth-child(5) {
    width: 7%;
}
.led-table-cell:nth-child(6) {
    width: 15%;
}
    </style>
</head>

<body>
    <div class="overlay" id="overlay" style="position:fixed; margin-top:150px; z-index:1051; margin-left:50%; display:none">
        <i style="color:#00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>
    <div class="led-main">
        <div class="led-header">
            <div class="led-logo">
                <%--<img src="../assets/images/led/logo-CMC-University-3-630x112.png" alt="">--%>
            </div>
            <div class="led-header-title">
                hệ thống thông tin giảng đường
            </div>
            <div class="led-header-right header-group">

               <%
                        if (iDangNhap)
                        {
                            %>
                                <a class="dropdown-item" href="logoutgiangduong.aspx"><i class="fal fa-sign-out"></i></a>    
                         <%
                             }
                             else
                             {
                                %>    
                                <a href="#" id="btnDangNhapGiangDuong" class="btn-login-home" data-bs-toggle="modal"
                                   data-bs-target="#modal-sv-registration">
                                    <i class="fas fa-user-circle"></i>
                                    <span>Đăng nhập</span>
                                </a>
                                <div id="zoneKhuVuc"></div>
                                 <%
                                     }
                                %>    
            </div>
        </div>
        <div class="led-content">
            <div class="top">
                <div class="left">Lịch giảng đường <span id="lblGiangDuong"></span> <span id="lblNgayThu"></span></div>
                <div class="right" id="lblcurent_time"></div>
            </div>

            <div class="leb-table">
                <div class="theader">
                    <div class="led-table-cell">
                        Thời gian
                    </div>
                    <div class="led-table-cell">
                        Phòng
                    </div>
                    <div class="led-table-cell">
                        Mã học phần
                    </div>
                    <div class="led-table-cell">
                        Lớp học phần
                    </div>
                    <div class="led-table-cell">
                        Số sv
                    </div>
                    <div class="led-table-cell">
                        Giảng viên
                    </div>
                </div>
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper" id="tblGiangDuong">
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div id="zoneprocessXXXX"></div>



    
<div class="modal fade sv-registration" id="modal-sv-registration" tabindex="-1"
     aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="content-login">
                <!-- content -->
                <form id="formLoginSSO" runat="server">
                    <form id="cms_bm_frm_login" action="#" method="post" onsubmit="return false">
                        
                        <div class="content-form-login position-relative">
                            <h2 class="text-center title-h2 text-uppercase color-dask-blue fw-bold">Đăng nhập</h2>
                            <form>
                                <div class="form-item position-relative mb-20">
                                    <label for="exampleInputEmail1" class="form-label"><i
                                            class="fal fa-user color-dask-blue"></i></label>
                                    <asp:TextBox ID="username" placeholder="Nhập tài khoản hoặc email" class="form-control"  runat="server"/>
                                </div>
                                <div class="form-item position-relative  mb-20 ">
                                    <label for="exampleInputPassword1" class="form-label"><i
                                            class="fal fa-key-skeleton color-dask-blue"></i></label>
                                    <asp:TextBox type="password" ID="password" placeholder="Nhập mật khẩu" class="form-control" runat="server"/>

                                    <span class="show-pass"><i class="fal fa-eye"></i></span>
                                    <span class="hide-pass"><i class="fal fa-eye-slash"></i></span>
                                </div>
                                <div class="help-forgot d-flex justify-content-between  mb-20">
                                    <a class="forgot-pass color-dask-blue"  href="../Pages/ForgetPass.aspx">Quên mật khẩu</a>
                                    <!--                    <a href="#" class="help color-dask-blue"><i class="fal fa-question-circle"></i> Trợ giúp!</a>-->
                                </div>
                                <asp:Button ID="cms_authenticate_do_login" runat="server" CssClass="btn btn-primary btn-login" 
                                                Text="Đăng nhập" OnClick="cms_authenticate_do_login_Click"/>
                                    
                                <div class="row login-notify" style="margin-bottom: -60px">
                                    <p class="box-notify">
                                        <asp:Label Width="100%" runat="server" ForeColor="Red" Text="" ID="lblNotify"></asp:Label>
                                    </p>
                                </div>
                                <%
                            if (urlgoogle != "")
                            {
                                %>
                                    <div class="or-login">Hoặc đăng nhập</div>
                                    <div class="row login-notify">
                                        <div class="social-auth-links text-center">
                                            <a type="submit" href="<%=urlgoogle %>" class="btn btn-primary btn-google"><img src="../assets/images/icon-g.png" class="logo-google"> Sign in using Google+</a>
                                        </div>
                                    </div>    
                                <%
                            }
                            %>  
                                <!--                <button type="submit" class="btn btn-primary btn-google"><img src="../assets/images/icon-g.png" class="logo-google"> Sign in using Google+</button>-->
                            </form>
                        </div>
                    </form>
                </form>
                <!-- end content -->

            </div>
        </div>
    </div>
</div>
</body>
<script src="../assets/js/bootstrap.bundle.min.js "></script>
<script src="../assets/js/swiper-bundle.min.js"></script>
<script src="../assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="../assets/js/slick.js"></script>
<script src="../assets/js/jquery-searchbox.js"></script>
<script src="../assets/js/custom.js"></script>
<script src="../assets/js/crypto-js.js?v=3"></script>
<script src="../assets/pagination/jquery.simplePagination.min.js?v=1.8"></script>
<script src="../assets/js/masonry.pkgd.min.js"></script>
<script src="../assets/js/jquery.simplemarquee.js"></script>
    
<script type="text/javascript" src="../Core/constant.js?v=1.3.1.1"></script>    <!--CORE JS-->
<script type="text/javascript" src="../Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="../Core/util.js?v=1.3.1.14"></script>        <!--CORE JS-->
<script type="text/javascript" src="../Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
<script type="text/javascript" src="../Config.js?v=1.3.1.2"></script><!--CORE JS-->
<script type="text/javascript">

    function Init_Prammater() {
        var rootPath        = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPath") %>';
        var rootPathUpload  = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>';
        var rootPathReport  = '<%= report %>';

        var appId           = '<%= app_id %>';
        var avatar           = '<%= avatar %>';
        var userId          = '<%= user_id %>';
        var tokenJWT        = '<%= tokenjwt %>';

        var oConfig = {
            rootPath: rootPath,
            rootPathUpload: rootPathUpload,
            rootPathReport: rootPathReport,
                    
            avatar: avatar,
            folderAvatar: '',
            folderDoc: '',

            appId: appId,
            userId: userId,
            langId: '',
            tokenJWT: tokenJWT,
            iDisableChucNang: true
        };
                
        return oConfig;
    }
            
    var edu = {};
    edu['system']   = new systemroot();
    edu['extend']   = new systemextend();
    edu['constant'] = new constant();
    edu['util']     = new util();
    $(document).ready(function () {
        edu.system.startApp();
        edu.extend.init();
        edu.constant.init();
    });
</script>
    
<script src="giangduong.js?v=<%=  Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['GiangDuong'] = new GiangDuong();
    $(document).ready(function () {
        main_doc.GiangDuong.init();
    });
</script>
<%--<script>
    var swiper = new Swiper(".mySwiper", {
        direction: "vertical",
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        slidesPerView: "auto",
        loop: true,
        speed: 2000,
        autoplay: {
            delay: 0,
        },
    });
</script>--%>



</html>