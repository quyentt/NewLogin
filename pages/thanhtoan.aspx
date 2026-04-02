<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thanhtoan.aspx.cs" Inherits="Apis.NewLogin.pages.thanhtoan" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/csstuyensinh/styles.css?v=5">
    <style>
        
.wrapper-admiss-2 .lable-big {
  position: relative;
}
.wrapper-admiss-2 .header {
  background: url(../assets/images/admiss-2/banner-online-payment.png)
    top center;
  height: 312px;
  background-size: cover;
  background-repeat: no-repeat;
}
.wrapper-admiss-2 .lable-big {
  display: flex;
  justify-content: center;
  margin-top: 100px;
  font-size: 45px;
  margin-bottom: 0;
}
.wrapper-admiss-2 .page-content {
  margin-top: -140px;
  position: relative;
  z-index: 1;
}
.wrapper-admiss-2 .fee-form-wrap {
  display: flex;
  gap: 40px;
  padding-bottom: 30px;
}
.wrapper-admiss-2 .fee-form-wrap .image {
  flex-shrink: 0;
}
.wrapper-admiss-2 .ad-fee-form {
  flex: 1;
}

    </style>
</head>


<body>

    <div class="overlay" id="overlay" style="position: fixed; margin-top: 150px; z-index: 1051; margin-left: 50%; display: none">
        <i style="color: #00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>
    <div class="wrapper-admiss ad-fee wrapper-admiss-2">
        <!-- header -->
        <div class="header">
            <div class="container-xl">

                <div class="row">
                    <div class="col-12 admiss-text-header">
                        <div class="lable-big">Thanh toán trực tuyến</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end header -->
        <!-- content -->
        <div class="page-content lephixettuyen">
            <div class="container-xl">
                <div class="sv-add-info">
                    <div class="sv-add-info-content sv-info-profile">
                        <div class="fee-form-wrap">
                            <div class="image">
                                <img src="../assets/images/admiss-2/online-payment.png" alt="">
                            </div>
                            <div class="ad-fee-form">
                                <div class="row sv-info-detail-item" style="display: none">

                                    <div class="col-12 col-md-4 text-lable">Kế hoạch tuyển sinh</div>
                                    <div class="col-12 col-md-8">
                                        <div class="form-item d-flex mb-15 form-add-info">
                                            <div class="input-group">
                                                <i class="fal fa-file-user"></i>
                                                <select id="dropSearch_KeHoach" class="form-select select-opt"></select>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row sv-info-detail-item" style="margin-top: 70px">
                                    <div class="col-12 col-md-4 text-lable">Tra cứu thông tin đăng ký</div>
                                    <div class="col-12 col-md-8">
                                        <div class="form-item d-flex mb-15 form-add-info">
                                            <div class="input-group">
                                                <i class="fal fa-address-card"></i>
                                                <input id="txtSearch" class="form-control" value="" placeholder="Nhập Mã HS, SV/CCCD, Mã hồ sơ">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-4 ms-auto">
                                        <button type="submit" class="btn btn-orange mb-15" id="btnSearch"><i class="fal fa-search-dollar me-2"></i>Tra cứu</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="line"></div>
                    <div class="ad-fee-result zone-bus" id="zonekosv">
                        <div class="emty text-center py-5">
                            <img src="../assets/images/xettuyen-emty.png" alt="">
                        </div>
                    </div>
                    <div class="ad-fee-result zone-bus" id="zonecosv" style="display: none">
                        <div class="title-under-line text-dark-blue">
                            <span class="position-relative">Thông tin cá nhân</span>
                        </div>
                        <div class="row">
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="label">Họ và tên:</span>
                                    <b id="lblHoTen1"></b>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="label">Mã sinh viên:</span>
                                    <b id="lblMaSinhVien"></b>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="label">Ngày sinh:</span>
                                    <b id="lblNgaySinh"></b>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="label">Lớp:</span>
                                    <b id="lblLopQuanLy"></b>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="label">Ngành:</span>
                                    <b id="lblNganh"></b>
                                </div>
                            </div>
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="label">Khóa:</span>
                                    <b id="lblKhoa"></b>
                                </div>
                            </div>
                            <div class="d-flex justify-content-end col-12 mt-4">
                                <div class=" justify-content-end d-flex mb-15 flex-wrap w-100" style="max-width: 650px;">
                                    <div class="form-item d-flex  form-add-info flex-grow-1 me-2">
                                        <div class="input-group">
                                            <i class="fal fa-credit-card"></i>
                                            <i class="fal fa-angle-down"></i>
                                            <select class="form-select" aria-label="Default select example" id="drpNganHang"></select>
                                        </div>
                                    </div>


                                    <div class="btn btn-dask-blue" id="btnThucHienThanhToan"><i class="fal fa-paper-plane me-2"></i>Thực hiện thanh toán</div>
                                </div>
                            </div>
                        </div>
                        <p class="fw-bold text-dark-blue fs-16p mt-4">Thông tin thanh toán<span id="lbSoTienDaChon" style="color: red; float: right"></span></p>
                        <table class="table transcrip-table tabs-scores " id="tblThanhToan">
                            <thead>
                                <tr>
                                    <th class="text-center" scope="col">STT</th>
                                    <th scope="col" class="text-center">Nội dung</th>
                                    <th scope="col" class="text-center">Số tiền</th>
                                    <th scope="col" class="text-center">Ghi chú</th>
                                    <th class="text-center" scope="col"><input type="checkbox" id="chkSelectAll_ThanhToan" name="chkSelectAll_ThanhToan"></th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                            <tfoot></tfoot>
                        </table>
                        <div class="d-flex justify-content-end" id="zonebtnNopTruoc" style="display: none !important">
                            <div class="btn btn-default" id="btnDelete_NopTruoc"><i class="fal fa-trash me-2"></i>Hủy nộp trước</div>
                            <div class="btn btn-dask-blue" id="btnAdd_NopTruoc"><i class="fal fa-plus me-2"></i>Nộp trước</div>
                        </div>
                        <ul class="nav nav-tabs mt-5" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Xuất hóa đơn</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Thông tin tài chính</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <table class="table table-file " id="tbldata_HoaDon">
                                    <thead class="table-light" >
                                        <tr>
                                            <th class="text-center" scope="col">STT</th>
                                            <th scope="col">Học kỳ</th>
                                            <th class="text-center" scope="col">Đợt</th>
                                            <th scope="col">Khoản thu</th>
                                            <th scope="col">Nội dung</th>
                                            <th scope="col">Số tiền</th>
                                            <th class="text-center" scope="col">Ngày tạo</th>
                                            <th class="text-center" scope="col"><input type="checkbox" class="chkSystemSelectAll"></th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                    <tfoot></tfoot>
                                </table>
                                <div class="justify-content-end" id="lblNutHDDT" style="float: right">
                                    <%--<div class="btn btn-dask-blue btnXuat_HDDT" id="" title="HDDTNHAP" style="margin-right: 5px"><i class="fal fa-paper-plane me-2"></i>HDDT Nháp</div>--%>
                                    <%--<div class="btn btn-dask-blue" id="btnXuatHDNhap"><i class="fal fa-paper-plane me-2"></i>Xem hóa đơn nháp</div>--%>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <div class=" finance-dashboard container-fluid">
                                    <div class="row">
                                        <!-- khoản phải nộp -->
                                        <div class="col-12 col-md-6">
                                            <div class="finance-dashboard-item" style="border-color: #0e9347;">
                                                <div class="finance-dashboard-content">
                                                    <p class="amount txtTongTien_KhoanPhaiNop" style="color: #0e9347;">0 <span>vnđ</span></p>
                                                    <p>Khoản phải nộp</p>
                                                    <button type="button" class="btnDetail_KhoanPhaiNop"><span>Chi tiết</span><i class="fal fa-arrow-right"></i></button>

                                                </div>
                                                <div class="finance-dashboard-icon">
                                                    <img src="../assets/images/finance/finance-icon-1.png">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- khoản được miễn -->
                                        <div class="col-12 col-md-6">
                                            <div class="finance-dashboard-item" style="border-color: #c97629;">
                                                <div class="finance-dashboard-content">
                                                    <p class="amount txtTongTien_KhoanDuocMien" style="color: #c97629;">0 <span>vnđ</span></p>
                                                    <p>Khoản được miễn</p>
                                                    <button type="button" class="btnDetail_KhoanDuocMien"><span>Chi tiết</span><i class="fal fa-arrow-right"></i></button>

                                                </div>
                                                <div class="finance-dashboard-icon">
                                                    <img src="../assets/images/finance/finance-icon-2.png">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- khoản đã nộp -->
                                        <div class="col-12 col-md-6">
                                            <div class="finance-dashboard-item" style="border-color: #3d8ac7;">
                                                <div class="finance-dashboard-content">
                                                    <p class="amount txtTongTien_KhoanDaNop" style="color: #3d8ac7;">0 <span>vnđ</span></p>
                                                    <p>Khoản đã nộp</p>
                                                    <button type="button" class="btnDetail_KhoanDaNop"><span>Chi tiết</span><i class="fal fa-arrow-right"></i></button>

                                                </div>
                                                <div class="finance-dashboard-icon">
                                                    <img src="../assets/images/finance/finance-icon-3.png">
                                                </div>
                                            </div>
                                        </div>
                                        <!-- khoản đã rút -->
                                        <div class="col-12 col-md-6">
                                            <div class="finance-dashboard-item" style="border-color: #ed5729;">
                                                <div class="finance-dashboard-content">
                                                    <p class="amount txtTongTien_KhoanDaRut" style="color: #ed5729;">0 <span>vnđ</span></p>
                                                    <p>Khoản đã rút</p>
                                                    <button type="button" class="btnDetail_KhoanDaRut"><span>Chi tiết</span><i class="fal fa-arrow-right"></i></button>

                                                </div>
                                                <div class="finance-dashboard-icon">
                                                    <img src="../assets/images/finance/finance-icon-4.png">
                                                </div>
                                            </div>
                                        </div>

                                        <!--Danh sách phiếu hóa đơn -->
                                        <div class="col-12 col-md-6">
                                            <div class="finance-dashboard-item" style="border-color: #0094e3;">
                                                <div class="finance-dashboard-content">
                                                    <p class="amount txtTongTien_PhieuHoaDon" style="color: #0094e3;">0 <span>vnđ</span></p>
                                                    <p>Danh sách phiếu hóa đơn </p>
                                                    <button type="button" class="btnDetail_PhieuHoaDon"><span>Chi tiết</span><i class="fal fa-arrow-right"></i></button>

                                                </div>
                                                <div class="finance-dashboard-icon">
                                                    <img src="../assets/images/finance/finance-icon-11.png">
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- end content -->


        </div>

    </div>
    
<!-- Modal chi tiết 1-->
    <div class="modal fade finance-modal" id="finance_detail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="finance-user-info in-modal">
                        <p><b>Danh sách <span id="lblLoaiKhoanThu"></span></b></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table transcrip-table tabs-scores" id="tblChiTietKhoan">
                        <thead></thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
<!-- modal Thêm học phần theo chương trình đào tạo -->
<div class="modal fade" id="modalKhoanNopTruoc">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <div class="finance-user-info in-modal ">
                    <p><b>Thêm khoản Nộp trước</b> </p>

                </div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex align-items-end flex-wrap flex-md-nowrap mb-10">
                    <div class="flex-grow-1">
                        <div class="row">
                            <div class="row">
                                <div class="">
                                    <label class="mt-7">Khoản</label>
                                    <div class="form-item d-flex  form-add-info">
                                        <div class="input-group">
                                            <i class="far fa-hands-usd"></i>
                                            <select id="dropKhoanNopTruoc" class="select-opt form-select"></select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="">
                                    <label class="mt-7">Số tiền</label>
                                    <div class="form-item d-flex  form-add-info">
                                        <div class="input-group">
                                            <i class="far fa-money-check-edit-alt"></i>
                                            <input type="text" id="txtSoTienNopTruoc" class="form-control inputsotien">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="">
                                    <label class="mt-7">Nội dung</label>
                                    <div class="form-item d-flex  form-add-info">
                                        <div class="input-group">
                                            <i class="far fa-money-check-edit"></i>
                                            <input type="text" id="txtNoiDungNopTruoc" class="form-control">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="d-flex justify-content-end">
                    <a class="btn btn-outline-orange" id="btnSave_KhoanNopTruoc" data-bs-dismiss="modal" aria-label="Close">
                        <i class="fal fa-tasks me-2"></i>
                        <span>Lưu</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
    <div id="alert"></div>
</body>
    
<!-- modal Thêm học phần theo đơn vị -->
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

<script type="text/javascript" src="../Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<!--CORE JS-->
<script type="text/javascript" src="../Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<!--CORE JS-->
<script type="text/javascript" src="../Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<!--CORE JS-->
<script type="text/javascript" src="../Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<!--CORE JS-->
<script type="text/javascript" src="../Config.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<!--CORE JS-->
<script type="text/javascript">

    var edu = {};
    edu['system'] = new systemroot();
    edu['extend'] = new systemextend();
    edu['constant'] = new constant();
    edu['util'] = new util();
    $(document).ready(function () {
        edu.system.startApp();
        edu.extend.init();
        edu.constant.init();
    });
</script>

<script src="thanhtoan.js?v=<%=  Guid.NewGuid().ToString() %>"></script>

<script type="text/javascript">
    var main_doc = {};
    main_doc['ThanhToan'] = new ThanhToan();
    $(document).ready(function () {
        main_doc.ThanhToan.init();
    });
</script>



</html>
