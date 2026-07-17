<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="theodoiquaynhaphoc.aspx.cs" Inherits="Apis.NewLogin.pages.tracuuchungchi" %>
<!DOCTYPE html>
<html lang="en" class="led-don-sv-html">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/css/styles.css?v=<%= Guid.NewGuid().ToString() %>">
    <style>
        table > tbody > tr:hover {
    background-color:unset;
}
    </style>
</head>

<body>
     <div class="overlay" id="overlay" style="display:none">
        <%--<i style="color:#00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>--%>
    </div>
    <div class="led-don-sv">
        <div class="led-don-sv-header">
            <div class="led-don-sv-header-logo">
                <img src="../assets/images/logo-cmc.png" alt="">
            </div>
            <div class="led-don-sv-header-title">
                Chào mừng tân sinh viên trường đại học cmc năm <span id="lblNamNhapHoc"></span>
            </div>
            <div class="led-don-sv-header-date" id="lblcurent_time">
            </div>
        </div>
        <div class="led-don-sv-content">
            <div class="led-don-sv-select-list">
                <div class="led-don-sv-select-item">
                    <div class="label">
                        Kế hoạch nhập học
                    </div>
                    <select class="form-select" id="dropKeHoachNhapHoc">
                        <option selected>Kế hoạch nhập học</option>
                      </select>
                </div>
                <div class="led-don-sv-select-item">
                    <div class="label">
                        Ca nhập học
                    </div>
                    <select class="form-select"  id="dropCaNhapHoc">
                        <option selected>Ca nhập học</option>
                      </select>
                </div>
                <div class="led-don-sv-select-item">
                    <div class="label">
                        Quầy nhập học
                    </div>
                    <select class="form-select"  id="dropQuayNhapHoc">
                        <option value="">Quầy nhập học</option>
                      </select>
                </div>
                
                <div class="led-don-sv-btn" id="btnDSHoanThanh" data-bs-toggle="modal" data-bs-target="#dahoanthanh">
                    Danh sách đã hoàn thành
                </div>
            </div>
            <div class="leb-table" id="tblTheoDoiQuayNhapHoc">
                <div class="theader">
                    <div class="led-table-cell">
                        STT
                    </div>
                    <div class="led-table-cell">
                        Họ và tên
                    </div>
                    <div class="led-table-cell">
                        Tỉnh/Thành phố
                    </div>
                    <div class="led-table-cell">
                        Số điện thoại
                    </div>
                    <div class="led-table-cell">
                        Ngày sinh
                    </div>
                    <div class="led-table-cell">
                        Ngành
                    </div>
                    <div class="led-table-cell">
                        Bước tiếp theo
                    </div>
                </div>
                
                    <div class="swiper mySwiper">
                        <div class="swiper-wrapper" >
                        </div>
                    </div>
                
            </div>
            <%--<table class="led-don-sv-table" id="tblTheoDoiQuayNhapHoc">
                <thead>
                    <tr>
                        <td style="text-align: center">STT</td>
                        <td>Họ và tên</td>
                        <td>Tỉnh/TP</td>
                        <td>CCCD/CMT</td>
                        <td>Ngày sinh</td>
                        <td>Ngành</td>
                        <td>Bước tiếp theo</td>
                    </tr>
                </thead>
                <tbody style="height: 300px"></tbody>
            </table>--%>
        </div>
    </div>
    
    <!-- modal -->
    <div class="modal fade" id="dahoanthanh" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Danh sách sinh viên đã hoàn thành</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="led-don-sv-table" id="tblHoanThanh">
                        <thead>
                            <tr>
                                <td>STT</td>
                                <td>Họ và tên</td>
                                <td>Tỉnh/TP</td>
                                <td>Số điện thoại</td>
                                <td>Ngày sinh</td>
                                <td>Ngành</td>
                                <td>Đã hoàn thành</td>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn led-don-sv-btn px-4" data-bs-dismiss="modal">Đóng</button>

                </div>
            </div>
        </div>
    </div>
    <div id="alert"></div>



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
<script type="text/javascript" src="../Config.js?v=1.3.1.3"></script><!--CORE JS-->
<script type="text/javascript">

    function Init_Prammater() {
        var rootPath        = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPath") %>';
        var rootPathUpload  = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>';
        var rootPathReport  = '';

        var appId           = '';
        var avatar           = '';
        var userId          = '';
        var tokenJWT        = '';

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
    
<script src="theodoiquaynhaphoc.js?v=<%=  Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['TheoDoiQuayNhapHoc'] = new TheoDoiQuayNhapHoc();
    $(document).ready(function () {
        main_doc.TheoDoiQuayNhapHoc.init();
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