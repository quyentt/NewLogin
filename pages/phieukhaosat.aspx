<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="phieukhaosat.aspx.cs" Inherits="Apis.NewLogin.pages.phieukhaosat" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/css/styles.css?v=1">
    <link rel="stylesheet" href="khaosat-pro.css?v=1.0.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,400;0,500;0,700;0,800;1,400;1,500;1,700;1,800&display=swap" rel="stylesheet">
</head>

<body class="ks-pro ks-preview">
    <div class="overlay" id="overlay" style="position:fixed; margin-top:150px; z-index:1051; margin-left:50%; display:none">
        <i style="color:#00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>
    <div class="cmc-page">
        <div class="cmc-ks-header">
            <div class="container">
                <div class="d-flex">
                    <div class="cmc-logo">
                        <%--<a class="logo-desk" >
                            <img src="../assets/images/cmc-khaosat/logo.png" alt="">
                        </a>--%>
                        <a class="logo-mobi" >
                            <img src="logokhaosat.jpg" alt="">
                        </a>
                    </div>
                    <div class="cmc-menu d-flex align-items-center ms-auto">
                        <a  class="btn trans">
                            <i class="fal fa-ballot-check"></i>
                            <span>Phiếu khảo sát</span>
                        </a>
                        <%--<a  class="btn trans">
                            <i class="fal fa-user-edit"></i>
                            <span>Đăng ký</span>
                        </a>
                        <a  class="btn">
                            <i class="fal fa-sign-in"></i>
                            <span>Đăng nhập</span>
                        </a>--%>
                    </div>
                </div>
            </div>
        </div>
        <div class="ks-preview-wrap">
            <div class="cmc-breadcrumb">
                <ul>
                    <li><a><i class="fal fa-home"></i></a><i class="fal fa-chevron-right"></i></li>
                    <li>Phiếu khảo sát</li>
                </ul>
            </div>
            <div class="ks-preview-hero">
                <div class="ks-preview-badge"><i class="fal fa-eye"></i> Xem trước phiếu</div>
                <div class="cmc-main-title" id="lblTieuDe"></div>
                <div class="tern-name" id="lblMoTaPhieu"></div>
                <div class="ks-preview-meta">
                    <span><i class="fal fa-layer-group"></i> <b id="lblSoNhom">0</b> nhóm</span>
                    <span><i class="fal fa-list-ol"></i> <b id="lblSoCau">0</b> câu hỏi</span>
                    <span><i class="fal fa-asterisk"></i> <b id="lblSoBatBuoc">0</b> câu bắt buộc</span>
                    <span><i class="fal fa-check-circle"></i> Đã chọn <b id="lblDaTraLoi">0/0</b></span>
                </div>
            </div>
            <div id="tblNoiDung"></div>
            <p class="ks-preview-footer">© Khảo sát trực tuyến</p>
        </div>
    </div>
    <a id="button"><i class="fas fa-chevron-up"></i></a>
</body>
<script src="../assets/js/bootstrap.bundle.min.js "></script>
<script src="../assets/js/swiper-bundle.min.js"></script>
<script src="../assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="../assets/js/slick.js"></script>
<script src="../assets/js/jquery-searchbox.js"></script>
<script src="../assets/js/custom.js"></script>
<script src="../assets/js/crypto-js.js?v=3"></script>
<script src="../assets/pagination/jquery.simplePagination.min.js?v=1.9"></script>
<script src="../assets/js/masonry.pkgd.min.js"></script>
<script src="../assets/js/jquery.simplemarquee.js"></script>
    
<script type="text/javascript" src="../Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>    <!--CORE JS-->
<script type="text/javascript" src="../Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="../Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
<script type="text/javascript" src="../Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
<script type="text/javascript" src="../Config.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
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
    
<script src="phieukhaosat.js?v=<%=  Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['KhaoSat'] = new KhaoSat();
    $(document).ready(function () {
        main_doc.KhaoSat.init();
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