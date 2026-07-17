<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="theodoinhaphoc.aspx.cs" Inherits="Apis.NewLogin.pages.theodoinhaphoc" %>
<!DOCTYPE html>
<html lang="en" class="led-event ad-moni">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/css/styles.css?v=1">
    <style>
        table > tbody > tr:hover {
            background-color:unset;
        }
        .table tr:nth-child(even) {
             background: unset; 
        }
    </style>
</head>

<body>
     <div class="overlay" id="overlay" style="position:fixed; margin-top:150px; z-index:1051; margin-left:50%; display:none">
        <i style="color:#00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>
    <div class="led-main ">
        <div class="led-header">
            <div class="led-logo led-header-right" style="justify-content: flex-start">
                <span id="lblcurent_time"></span>
            </div>
            <div class="led-header-title">
                Bảng theo dõi nhập học trực tuyến
            </div>
            <div class="led-header-right">
                <%
                        if (iDangNhap)
                        {
                            %>
                                <a class="dropdown-item" href="logouttheodoinhaphoc.aspx"><i class="fal fa-sign-out"></i></a>    
                         <%
                             }
                             else
                             {
                                %>    
                                <a href="#" class="btn-login-home" data-bs-toggle="modal"
                                   data-bs-target="#modal-sv-registration">
                                    <i class="fas fa-user-circle"></i>
                                    <span>Đăng nhập</span>
                                </a>
                                 <%
                                     }
                                %>    
            </div>
        </div>
        <div class="led-content">
            <div id="zoneprocessTheoDoi"></div>
            <table class="table mb-0" id="tblTheoDoiNhapHoc">
                <thead>
                    
                </thead>
                <tbody></tbody>
                <tfoot style="text-align: right"></tfoot>
            </table>

        </div>
    </div>




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
    
<script type="text/javascript" src="../Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>    <!--CORE JS-->
<script type="text/javascript" src="../Core/systemroot.js?v=<%=  Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="../Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
<script type="text/javascript" src="../Core/systemextend.js?v=<%=  Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
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
    
<script src="theodoinhaphoc.js?v=<%=  Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['TheoDoiNhapHoc'] = new TheoDoiNhapHoc();
    $(document).ready(function () {
        main_doc.TheoDoiNhapHoc.init();
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