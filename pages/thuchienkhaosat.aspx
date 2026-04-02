<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thuchienkhaosat.aspx.cs" Inherits="Apis.NewLogin.pages.thuchienkhaosat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/css/styles.css?v=12">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,300;0,400;0,500;0,700;0,800;1,400;1,500;1,700;1,800&display=swap" rel="stylesheet">
</head>

<body class="question-grs">
    <div class="overlay" id="overlay" style="position:fixed; margin-top:150px; z-index:1051; margin-left:50%; display:none">
        <i style="color:#00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>
    <div class="cmc-page">
        <div class="cmc-ks-header">
            <div class="container-fluid">
                <div class="d-flex">
                    <div class="cmc-logo">
                        <a class="logo-desk" >
                            <img src="../logokhaosat.png" alt="">
                        </a>
                        <a class="logo-mobi" >
                            <!--<img src="../assets/images/cmc-khaosat/logo-mobi.png" alt="">-->
                        </a>
                    </div>
                    <div class="cmc-menu d-flex align-items-center ms-auto">
                        <a class="btn trans">
                            <i class="fal fa-ballot-check"></i>
                            <span>Phiếu khảo sát</span>
                        </a>
                        <a class="btn trans" href="../index.aspx">
                            <i class="fal fa-user-edit"></i>
                            <span>Đăng ký</span>
                        </a>
                        <a class="btn btnLuuKetQua" id="btnLuuKetQua">
                            <i class="fal fa-paper-plane"></i>
                            <span>Hoàn thành khảo sát</span>
                        </a>
                        <a class="btn trans" id="btnLogout">
                            <i class="fal fa-sign-out"></i>
                            <span>Đăng xuất</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="cmc-question-page">
            <div class="cmc-question-nav">
                <div class="cmc-emulator-user">
                    <div class="user-object">
                        <div class="avata">
                            <img src="" alt="">
                        </div>
                        <div>
                            <p>Bạn đang khảo cho đối tượng</p>
                            <p class="name" id="lblDoiTuong"></p>
                        </div>
                    </div>
                    <div class="complate-ratio">
                        <p>Tỷ lệ hoàn thành khảo sát</p>
                        <p class="ratio" id="lblTinhTrang"></p>
                    </div>
                </div>
                <div class="cmc-nav-title">
                    <p>Danh sách phiếu khảo sát</p>
                    <a >
                    </a>
                </div>
                <ul class="cmc-question-list" id="tblDoiTuong">
                    
                </ul>
            </div>
            <div class="cmc-question-content">
                <div class="cmc-breadcrumb">

                    <ul>
                        <li>
                            <a >
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="16" viewBox="0 0 18 16" fill="none">
                                        <g clip-path="url(#clip0_118_21797)">
                                            <path d="M17.829 7.5625L15.9999 5.96093V1.5C15.9999 1.36739 15.9472 1.24021 15.8535 1.14644C15.7597 1.05267 15.6325 0.999995 15.4999 0.999995H12.4999C12.3673 0.999995 12.2401 1.05267 12.1464 1.14644C12.0526 1.24021 11.9999 1.36739 11.9999 1.5V2.46093L9.32897 0.124995C9.23785 0.0453458 9.12094 0.00144958 8.99991 0.00144958C8.87889 0.00144958 8.76197 0.0453458 8.67085 0.124995L0.170849 7.5625C0.0710197 7.64981 0.00996474 7.7732 0.00111537 7.90553C-0.00773401 8.03786 0.0363471 8.16829 0.123661 8.26812C0.210976 8.36795 0.334371 8.429 0.466701 8.43785C0.599031 8.4467 0.729457 8.40262 0.829286 8.31531L1.99991 7.28968V14.5C2.00032 14.8977 2.15849 15.279 2.43971 15.5602C2.72092 15.8414 3.10221 15.9996 3.49991 16H14.4999C14.8976 15.9996 15.2789 15.8414 15.5601 15.5602C15.8413 15.279 15.9995 14.8977 15.9999 14.5V7.28968L17.1705 8.31437C17.2709 8.39646 17.3993 8.43633 17.5285 8.42557C17.6578 8.41481 17.7778 8.35426 17.8632 8.2567C17.9486 8.15914 17.9928 8.0322 17.9864 7.90268C17.98 7.77316 17.9236 7.65118 17.829 7.5625ZM14.9999 14.5C14.9999 14.6326 14.9472 14.7598 14.8535 14.8535C14.7597 14.9473 14.6325 15 14.4999 15H3.49991C3.3673 15 3.24013 14.9473 3.14636 14.8535C3.05259 14.7598 2.99991 14.6326 2.99991 14.5V6.41468L8.99991 1.16468L14.9999 6.41468V14.5ZM14.9999 5.08593L12.9999 3.33593V2H14.9999V5.08593ZM6.49991 6.83343V10.1669C6.50065 10.3876 6.58867 10.5991 6.74475 10.7552C6.90083 10.9112 7.11231 10.9993 7.33304 11H10.6655C10.8865 10.9995 11.0982 10.9116 11.2545 10.7555C11.4109 10.5994 11.4991 10.3878 11.4999 10.1669V6.83343C11.4993 6.61243 11.4111 6.40069 11.2547 6.2445C11.0984 6.08832 10.8865 6.00041 10.6655 6H7.33304C7.11223 6.00066 6.90065 6.08869 6.74455 6.24485C6.58844 6.40102 6.50049 6.61262 6.49991 6.83343ZM7.49991 7H10.4999V10H7.49991V7Z" fill="#AAAAAA"></path>
                                        </g>
                                        <defs>
                                            <clipPath id="clip0_118_21797">
                                                <rect width="18" height="16" fill="white"></rect>
                                            </clipPath>
                                        </defs>
                                    </svg>
                            </a>
                            <i class="fal fa-chevron-right"></i>

                        </li>
                        <li>Danh sách câu hỏi theo nhóm</li>
                    </ul>
                </div>
                <div class="cmc-question-content-wrapper">


                    <div class="cmc-question-group">
                        <div class="modal fade" id="question_group" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-fullscreen">
                                <div class="modal-content">
                                    <div class="modal-header p-0">
                                        <div class="modal-tle-custom">
                                            <div class="cmc-question-title" id="lblTieuDe">
                                            </div>
                                            <div class="cmc-teacher" id="lblMoTaPhieu">
                                            </div>
                                        </div>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-0" id="tblNoiDung">
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
                <div class="cmc-menu d-flex align-items-center cmc-ks-header" style="float: right; padding-right: 10px">
                        <a class="btn btnLuuKetQua">
                            <i class="fal fa-paper-plane"></i>
                            <span>Hoàn thành khảo sát</span>
                        </a>
                    </div>
            </div>
        </div>

    </div>
    </div>

    <div id="alert"></div>
    <!-- Modal -->
    <div class="modal fade cmc-modal" id="taophieumau" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Tạo phiếu mẫu</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="input-row">
                        <span>Tên phiếu</span>
                        <input type="text" class="form-control">
                    </div>
                    <div class="input-row">
                        <span>Chọn phân loại</span>
                        <input type="text" class="form-control">
                    </div>

                    <div class="cmc-button-gr">
                        <button class="btn btn-cmc-outline">
                            <i class="fal fa-times-circle"></i>
                            <span>Hủy</span>
                        </button>
                        <button class="btn btn-cmc">
                            <i class="fal fa-save"></i>
                            <span>Lưu</span>
                        </button>
                    </div>
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
<script type="text/javascript" src="../Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="../Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
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
    
<script src="thuchienkhaosat.js?v=<%=  Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['ThucHienKhaoSat'] = new ThucHienKhaoSat();
    $(document).ready(function () {
        main_doc.ThucHienKhaoSat.init();
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