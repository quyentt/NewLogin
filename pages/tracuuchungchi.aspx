<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tracuuchungchi.aspx.cs" Inherits="Apis.NewLogin.pages.tracuuchungchi" %>
<!DOCTYPE html>
<html lang="en" class="led-don-sv-html">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/assettracuuvanbang/css/styles.css?v=<%= Guid.NewGuid().ToString() %>">
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
    <div class="wrapper-admiss ad-fee">
        <!-- header -->
        <div class="header">
            <div class="container-xxl d-flex flex-column h-100">
                <div class="row">
                    <div class="col-12 col-lg-4 logo-top">
                        <a href="#"><img src="../assets/assettracuuvanbang/images/Logo PHENIKAA-UNI-02.png"></a>
                    </div>
                    <div class="col-12 col-lg-8">

                        <h1>Trường đại học phenikaa</h1>


                    </div>
                </div>
                <div class="text-center page-label mt-auto">
                    Trang tra cứu thông tin
                    <a href="">
                        <i class="fal fa-home"></i>
                        <span>Trang chủ</span>
                    </a>
                </div>
            </div>
        </div>
        <!-- end header -->
        <!-- content -->
        <div class="page-content lephixettuyen">
            <div class="container-xxl">
                <div class="sv-add-info">
                    <div class="looking-wrap">
                        <nav>
                            <div class="nav nav-tabs " id="nav-tab" role="tablist">
                                <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">
                                    Tra cứu kết quả thi chứng chỉ
                                </button>
                                <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">
                                    Tra cứu chứng chỉ
                                </button>

                            </div>
                        </nav>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                                <div class="looking-form mx-3 mt-4">
                                    <div class="row">
                                        <div class="col-12 col-md-6">
                                            <div class="ad-fee-form">

                                                <div class="row sv-info-detail-item">
                                                    <div class="col-12 col-md-3 text-lable">Số báo danh</div>
                                                    <div class="col-12 col-md-9">
                                                        <div class="form-item d-flex mb-15 form-add-info">
                                                            <div class="input-group">
                                                                <i class="fal fa-address-card"></i>
                                                                <input class="form-control" value="" placeholder="" id="txtSearch_SoBaoDanh"></div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row sv-info-detail-item">
                                                    <div class="col-12 col-md-3 text-lable">Ngày sinh</div>
                                                    <div class="col-12 col-md-9">
                                                        <div class="form-item d-flex mb-15 form-add-info">
                                                            <div class="input-group icon-right">
                                                                <i class="fal fa-calendar-alt"></i>
                                                                <input class="form-control" value=""  id="txtSearch_NgaySinh" placeholder="../../.."></div>
                                                        </div>
                                                    </div>

                                                </div>


                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 ">
                                            <div class="ad-fee-form h-100 d-flex align-items-end">
                                                <button type="submit" class="btn btn-orange mb-15 w-auto px-5" id="btnSearch_KetQua"><i class="fal fa-search me-2"></i>Tra cứu</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="ad-fee-result px-3">
                                    <div class="title-under-line text-dark-blue">
                                        <span class="position-relative">Kết quả tra cứu</span>
                                    </div>
                                    <table class="table table-file table-responsive" id="tblKetQua">
                                        <thead class="table-light">
                                            <tr>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                                <div class="looking-form mx-3 mt-4">
                                    <div class="row">
                                        <div class="col-12 col-md-6">
                                            <div class="ad-fee-form">

                                                <div class="row sv-info-detail-item">
                                                    <div class="col-12 col-md-3 text-lable">Số hiệu chứng chỉ</div>
                                                    <div class="col-12 col-md-9">
                                                        <div class="form-item d-flex mb-15 form-add-info">
                                                            <div class="input-group">
                                                                <i class="fal fa-diploma"></i>
                                                                <input class="form-control" value="" placeholder=""  id="txtSearch_SoChungChi"></div>
                                                        </div>
                                                    </div>

                                                </div>


                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 ">
                                            <div class="ad-fee-form h-100 d-flex align-items-end">
                                                <button class="btn btn-orange mb-15 w-auto px-5" id="btnSearch_ChungChi"><i class="fal fa-search me-2"></i>Tra cứu</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="ad-fee-result px-3">
                                    <div class="title-under-line text-dark-blue">
                                        <span class="position-relative">Kết quả tra cứu</span>
                                    </div>

                                    <table class="table table-file table-responsive">
                                        <thead class="table-light" id="tblChungChi">
                                            <tr>
                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end content -->
            
            <!-- footer -->
            <div class="footer">
                <div class="footer-top">
                    <div class="container-xxl">
                        <div class="footer-content">

                            <div class="footer-item">
                                <i class="fal fa-phone-volume"></i>
                                <div class="meta">
                                    <p class="top">Hotline:</p>
                                    <p class="mb-0"><a href="tel:03961.03968">03961.03968</a></a>
                                    </p>
                                </div>
                            </div>
                            <div class="footer-item">
                                <i class="fal fa-envelope-open"></i>
                                <div class="meta">
                                    <p class="top">Email:</p>
                                    <p class="mb-0"><a href="#">ttnnkn@phenikaa-uni.edu.vn </a></p>
                                </div>
                            </div>
                            <div class="footer-item">
                                <i class="fal fa-globe"></i>
                                <div class="meta">
                                    <p class="top">Website:</p>
                                    <p class="mb-0"><a href="  https://cfis.phenikaa-uni.edu.vn ">  https://cfis.phenikaa-uni.edu.vn </a></p>
                                </div>
                            </div>
                            <div class="footer-item">
                                <i class="fab fa-facebook-f"></i>
                                <div class="meta">
                                    <p class="top">facebook:</p>
                                    <p class="mb-0"><a href="https://www.facebook.com/cfis.pka"> https://www.facebook.com/cfis.pka</a></p>
                                </div>
                            </div>
                            <div class="footer-item w-100 mw-100">
                                <i class="fal fa-map-marked-alt"></i>
                                <div class="meta">
                                    <p class="top">Địa chỉ:</p>
                                    <p class="mb-0">Tầng 3, Nhà A10, Trường ĐH Phenikaa, Phố Nguyễn Văn Trác, Phường Yên Nghĩa, Quận Hà Đông, Hà Nội, Việt Nam.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="footer-end">
                    <div class="container-xxl">
                        <div class=" d-flex justify-content-between flex-wrap">
                            <p>Copyright © 2022 Trường Đại học PHENIKAA</p>
                            <p>Đơn vị phát triển: Công ty Cổ Phần dịch vụ Công nghệ APIS</p>
                        </div>
                    </div>
                </div>

            </div>
            <!-- end footer -->

        </div>
        <!-- Button trigger modal -->

        <!-- Modal -->
        <div class="modal fade" id="vanbang_chitiet" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Chi tiết - văn bằng chứng chỉ Nguyễn Thị Bích</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="vanbang-chitiet">
                            <div class="row vanbang-info">
                                <div class="col-12 col-lg-4 ">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Họ và tên</div>
                                        <div class="value">Nguyễn Thị Bích</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Giới tính</div>
                                        <div class="value">Nữ</div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-4">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Ngày sinh</div>
                                        <div class="value">15/11/1990</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Nơi sinh</div>
                                        <div class="value">Hải Dương</div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-4">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Dân tộc</div>
                                        <div class="value">Kinh</div>
                                    </div>

                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Quốc tịch</div>
                                        <div class="value">Việt Nam</div>
                                    </div>
                                </div>
                            </div>
                            <div class="row my-4">
                                <div class="col-12 col-lg-7">
                                    <img class="w-100" src="../assets/assettracuuvanbang/images/van-bang.jpg" alt="">
                                </div>
                                <div class="col-12 col-lg-5">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Mã số sinh viên</div>
                                        <div class="value">ABC</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">ngành đào tạo</div>
                                        <div class="value">Cơ khí chế tạo máy</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Chuyên ngành</div>
                                        <div class="value">Cơ khí</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Lớp</div>
                                        <div class="value">CK_2122</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Trình độ đào tạo</div>
                                        <div class="value">Đại học</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">HÌnh thức đào tạo</div>
                                        <div class="value">Chính quy</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Khóa học</div>
                                        <div class="value">2018-2022</div>
                                    </div>
                                    <div class="line my-2"></div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Quyết định tốt nghiệp</div>
                                        <div class="value">QĐ-2002-18-2022</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Năm tốt nghiệp</div>
                                        <div class="value">2000</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Xếp loại</div>
                                        <div class="value">Trung bình</div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Ngày và người ký bằng</div>
                                        <div class="value"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Tình trạng</div>
                                        <div class="value"></div>
                                    </div>

                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Ghi chú</div>
                                        <div class="value">nội dung ghi chú</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div id="alert"></div>
</body>
<script src="../assets/assettracuuvanbang/js/bootstrap.bundle.min.js "></script>
<script src="../assets/assettracuuvanbang/js/swiper-bundle.min.js"></script>
<script src="../assets/assettracuuvanbang/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="../assets/assettracuuvanbang/js/jquery-searchbox.js"></script>
<script src="../assets/assettracuuvanbang/js/select2.min.js"></script>
<script src="../assets/assettracuuvanbang/js/slick.js"></script>
<script src="../assets/assettracuuvanbang/js/custom.js"></script>
<script src="../assets/js/crypto-js.js?v=3"></script>
<script src="../assets/pagination/jquery.simplePagination.min.js?v=1.8"></script>
    
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
    
<script src="tracuuchungchi.js?v=<%=  Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['TraCuuChungChi'] = new TraCuuChungChi();
    $(document).ready(function () {
        main_doc.TraCuuChungChi.init();
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