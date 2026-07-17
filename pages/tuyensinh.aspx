<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tuyensinh.aspx.cs" Inherits="Apis.NewLogin.pages.tuyensinh" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
    <title>Education management</title>
    <link rel="stylesheet" href="../assets/csstuyensinh/styles.css?v=7">
    <link rel="stylesheet" href="../config.css?v=5">
    <link rel="shortcut icon" type="image/x-icon" href="../assets/images/logo.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1">
    <style>
        #srctxtAvartar{
            width: 193px;
        }
        #phieuxettuyen .custom-select {
  margin-left: -24px;
  margin-top: 5px;
  margin-bottom: 15px;
}
/*#zonebatdau
  .select2-container--default
  .select2-selection--single
  .select2-selection__rendered {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  word-break: break-word;
}*/
#phieuxettuyen .select2-selection.select2-selection--single {
  padding-left: 0;
}
#phieuxettuyen .register-item-btn:hover {
  color: #fff !important;
}
#phieuxettuyen .select2-selection,
#phieuxettuyen .select2-dropdown {
  border-radius: 6px !important;
}
.select2-results::-webkit-scrollbar {
  width: 3px;
}
#phieuxettuyen .register-item-btn {
  padding-top: 4px;
}
#phieuxettuyen .select2-container--default .select2-selection--single .select2-selection__rendered {
    white-space: normal !important;
    word-break: break-word !important;
    height: auto !important;
    line-height: 1.3 !important;
}
#phieuxettuyen .select2.select2-container--default .select2-selection--single {
    height: 100% !important;            /* Tăng chiều cao khung */
    padding: 8px 12px !important;           /* Khoảng cách trong */
    display: flex;
    align-items: center;
}
    </style>
</head>

<body>
<div class="wrapper-admiss" id="wrapperadmiss">
    <!-- header -->
    <div class="overlay" id="overlay" style="position:fixed; margin-top:150px; z-index:1051; margin-left:50%; display:none">
        <i style="color:#00a65a; font-size: 80px" class="fad fa-sync-alt fa-spin"></i>
    </div>
    <div class="header" id="backgroundheader" style="background-image: unset">
        <div class="container-xl">
            <div class="row">
                <div class="col-12 col-lg-4 logo-top">
                    <a href="" class="LOGOHEADER"></a>
                </div>
                <div class="col-12 col-lg-8">
                    <div class="header-group">
                        <a id="btnDongPhi" href="./thanhtoan.aspx" class="btn-admission btn-orange" style="display: none">
                          <i class="fal fa-money-check-edit-alt"></i>
                          <span>Thanh toán</span>
                        </a>
                        <ul class="list-unstyled mb-0 main-menu">
                            <li>
                                <a href="#" class="switchzone" name="zoneketqua">
                                    <i class="fal fa-home"></i>
                                    <span>Kết quả</span>
                                </a>
                            </li>
                            <li>
                                <a href="#" class="switchzone" name="zonelephi">
                                    <i class="fal fa-file-search"></i>
                                    <span>Tra cứu</span>
                                </a>
                            </li>
                        </ul>
                        <a href="#" class="btn-admission switchzone" name="zonebatdau">
                            <i class="fal fa-book-reader"></i>
                            <span>Đăng ký xét tuyển</span>
                        </a>
                        <%
                        if (iDangNhap)
                        {
                            %>
                                <div class="nav-account">
                                    <div class="dropdown">
                                        <button class="btn-user-image d-flex" type="button" data-bs-toggle="dropdown">
                                            <div class="user-image">
                                                <img src="../assets/images/avata-user.png" class="img-student" id="imgavatar">
                                            </div>
                                            <span><%=fullname %></span>
                                            <i class="fal fa-chevron-down user-arrow"></i>
                                        </button>
                                        <ul class="dropdown-menu user-drop">
                                            <li>
                                                <div class="img-user"><img src="../assets/images/avata-user.png"
                                                                           class="user-avata-img" id="imgavatardrop">
                                                    <span><%=fullname %></span>
                                                    <p>Cập nhật lần cuối 22/02/2022</p>
                                                </div>
                                            </li>
                                            <li><a class="dropdown-item" href="logout.aspx"><i class="fal fa-sign-out"></i> Đăng xuất</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>    
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
            </div>
            <div class="row">
                <div class="col-12 admiss-text-header">
                    <h3 class="LBLDAUTRANG"></h3>
                    <div class="lable-big" id="lblTieuDe"><img src="../assets/images/letter.png" id="lblTrang"> ĐĂNG KÝ XÉT TUYỂN</div>
                </div>
            </div>
        </div>
    </div>
    <!-- end header -->
    <div id="main-content-wrapper">
    <!-- content -->
    <div class="page-content zone-bus" id="zonebatdau">
        <div class="container-xl">
            <div class="row INFOSCHOOL" id="info-school">
            </div>
            <div class="row" id="phieuxettuyen">
            </div>
        </div>
    </div>
    <!-- end content -->

    <!-- content -->
    <div class="page-content zone-bus" id="zonedangky" style="display: none">
        <div class="container-xl">
            <div class="sv-add-info">
                <div class="sv-lable">
                    <button class="bnt bnt-back switchzone" name="zonebatdau" ><i class="fal fa-arrow-left"></i></button>
                    <h4 id="lblphieuxettuyen"></h4>
                </div>
                <div class="sv-add-info-content sv-info-profile">
                    <div class="sv-info-detail">
                        <div class="sv-info-detail-form">
                            <div class="row sv-info-detail-item">
                                <div class="col-12 sv-lable-big mb-20"><h5 class="text-uppercase">Thông tin thí
                                    sinh</h5></div>
                            </div>
                            <div class="row sv-info-detail-item" id="zoneTaiKhoan">
                                <div class="col-12 col-md-4 text-lable-groud">
                                    <div class="avata-user">
                                        <a href="#" class="add-avata"><i class="fal fa-camera"></i></a>
                                        <div class="img-avata-user"><img id="txtAvartar" src="assets/images/avata-user-1.jpg"></div>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Họ và tên đệm<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-users"></i>
                                                    <input class="form-control" id="txtHoDem"
                                                           placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Tên<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <input class="form-control" id="txtTen"
                                                           placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Ngày, tháng, năm sinh<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <input class="form-control input-datepicker" id="txtNgaySinh"
                                                           placeholder="dd/mm/yyyy">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Nơi sinh<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <input class="form-control" id="txtNoiSinh"
                                                           >
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Quốc tịch<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <select id="dropQuocTich" class="form-select select-opt"></select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Giới tính<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <select id="dropGioiTinh" class="form-select select-opt"></select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Số điện thoại<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-phone-square"></i>
                                                    <input class="form-control"  id="txtSoDienThoai"
                                                           placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">E-Mail<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-envelope-open"></i>
                                                    <input class="form-control" id="txtEmail"
                                                           placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Số CMND/CCCD<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-address-card"></i>
                                                    <input class="form-control"  id="txtCMT"
                                                           placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Ngày cấp<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <input class="form-control input-datepicker" id="txtNgayCap"
                                                           placeholder="dd/mm/yyyy">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 col-md-4 text-lable">Nơi cấp<span>*</span></div>
                                        <div class="col-12 col-md-8">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user-alt"></i>
                                                    <input class="form-control" id="txtNoiCap" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div id="tblTuNhapHoSo"></div>
                            <div class="row sv-info-detail-item mt-4 sv-info-regis">
                                <div class="col-12 sv-lable-big mb-20"><h5 class="text-uppercase">THÔNG TIN ĐĂNG KÝ</h5>
                                </div>
                                
                                <div id="tblCauHinhThongTin">
                                </div>
                                
                                <div id="tblCauHinhThongTin_TT" style="display: none">
                                </div>
                                
                                <div class="row sv-info-regis-item">
                                    <div class="col-12 col-md-2 col-stt"></div>
                                    <div class="col-12 col-md-5 col-branch"></div>
                                    <div class="col-12 col-md-4 col-subject">
                                        <div class="row">
                                            <div class="col-12 col-md-4 text-lable"></div>
                                            <div class="col-12 col-md-8">
                                                <button type="submit" class="btn btn-more-wishes" id="btnThemDongMoi">Thêm nguyện vọng<i
                                                        class="fal fa-plus"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-1 text-center col-delete"></div>
                                </div>

                                <div class="table-subject mt-4">
                                    <div class="TIEUDECAUHINHNGANH">
                                </div>
                                    <table class="table table-bordered" id="tblMonThi">
                                        <thead>
                                        <tr>
                                            <th scope="col" class="text-center">STT</th>
                                            <th scope="col">Môn</th>
                                            <th scope="col">Điểm</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="checkcamdoan">
                                        <label class="form-check-label CAMDOAN" for="checkcamdoan" style="cursor: pointer">Tôi đã đọc và hiểu rõ các quy định về tiêu chí và điều kiện xét tuyển của Nhà trường. Tôi xin cam đoan những lời khai trong đơn đăng ký xét tuyển này là đúng sự thật. Nếu sai, tôi xin chịu hoàn toàn trách nhiệm và chịu xử lý theo quy định.</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="sv-info-regis-button">
                    <div class="row">
                        <div class="col-12 col-sm-8"></div>
                        <div class="col-12 col-sm-4 sv-button">
                            <a class="btn btn-continue" id="btnDangKy">Đăng ký <i class="fal fa-user-edit"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- end content -->

    <!-- content -->
    <div class="page-content file-admiss zone-bus" id="zoneketqua" style="display: none">
        <div class="container-xl">
            <div class="page-content-cover">
                <table class="table table-file" id="tblKetQuaNguyenVong">
                    <thead>
                        <tr>
                            <th scope="col">Mã hồ sơ</th>
                            <th scope="col">Hình thức xét tuyển</th>
                            <th scope="col">Danh Sách Nguyện Vọng</th>
                            <th scope="col">Kết quả</th>
                            <th scope="col">Đã nộp</th>
                            <th scope="col">Phải nộp</th>
                            <th scope="col">Thanh toán</th>
                            <th scope="col">Trạng thái</th>
                            <th scope="col">Sửa</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


        </div>
    </div>
    <!-- end content -->

    
    <!-- content -->
    <div class="page-content file-admiss zone-bus" id="zonelephi" style="display: none">
         <div class="container-xl">
            <div class="sv-add-info">
                <div class="sv-add-info-content sv-info-profile">
                    <div class="ad-fee-form">
                        <div class="row sv-info-detail-item">
                            <div class="col-12 col-md-3 text-lable">Kế hoạch tuyển sinh</div>
                            <div class="col-12 col-md-6">
                                <div class="form-item d-flex mb-15 form-add-info">
                                    <div class="input-group">
                                        <i class="fal fa-file-user"></i>
                                        <select id="dropSearch_KeHoach" class="form-select select-opt">
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-3"></div>
                        </div>
                        <div class="row sv-info-detail-item">
                            <div class="col-12 col-md-3 text-lable">Tra cứu thông tin đăng ký</div>
                            <div class="col-12 col-md-6">
                                <div class="form-item d-flex mb-15 form-add-info">
                                    <div class="input-group">
                                        <i class="fal fa-address-card"></i>
                                        <input id="txtSearch_CMND" class="form-control" value=""
                                               placeholder="Nhập số CMNN/CCCD"></div>
                                </div>
                            </div>
                            <div class="col-12 col-md-3">
                                <button type="submit" id="btnSearch_LePhi" class="btn btn-orange mb-15"><i
                                        class="fal fa-search-dollar me-2"></i>Tra cứu
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="line"></div>
                <div class="ad-fee-result zone-pay" id="pay_empty">
                    <div class="emty text-center py-5">
                        <img src="../assets/images/xettuyen-emty.png" alt="">
                    </div>
                </div>
                <div class="ad-fee-result zone-pay" id="pay_thanhtoan" style="display: none">
                    <div class="title-under-line text-dark-blue">
                        <span class="position-relative">Thông tin thí sinh</span>
                    </div>
                    <div class="row">
                        <div class="col-12 col-md-6" id="hHoTen">
                            <div class="d-flex align-items-center mb-2">
                                <span class="label">Họ và tên:</span>
                                <b class="lblHoTen"></b>
                            </div>
                        </div>
                        <div class="col-12 col-md-6" id="hSoDienThoai">
                            <div class="d-flex align-items-center mb-2">
                                <span class="label">Số điện thoại:</span>
                                <span class="lblSoDienThoai"></span>
                            </div>
                        </div>
                        <div class="col-12 col-md-6" id="hCMND">
                            <div class="d-flex align-items-center mb-2">
                                <span class="label">Số CMND/CCCD:</span>
                                <span class="lblCMND"></span>
                            </div>
                        </div>

                        <div class="col-12 col-md-6" id="hEmail">
                            <div class="d-flex align-items-center mb-2">
                                <span class="label">Email:</span>
                                <span class="lblEmail"></span>
                            </div>
                        </div>
                    </div>
                    <div class="fw-bold text-dark-blue fs-16p mt-4">
                        Trạng thái nộp tiền
                    </div>
                    <table class="table table-file" id="tblTrangThai_NopTien">
                        <thead class="table-light" >
                            <tr>
                                <th scope="col" class="text-center">STT</th>
                                <th scope="col">Nội dung</th>
                                <th scope="col">Số tiền</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                    <div class="fw-bold text-dark-blue fs-16p mt-4">
                        Thông tin đăng ký
                    </div>
                    <table class="table table-file"  id="tblDangKy_NopTien">
                        <thead class="table-light">
                            <tr>
                                <th scope="col" class="text-center">STT</th>
                                <th scope="col">Mã hồ sơ</th>
                                <th scope="col">Nguyện vọng</th>
                                <th scope="col">Phương thức</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                    
                    <div class="fw-bold text-dark-blue fs-16p mt-4">
                        Tổng số tiền cần nộp
                    </div>
                    <table class="table table-file" id="tblPhaiNop">
                        <thead class="table-light">
                            <tr>
                                <th scope="col" class="text-center">STT</th>
                                <th scope="col">Nội dung</th>
                                <th scope="col">Số tiền</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                    <div class="fw-bold text-dark-blue fs-16p mt-4">
                        Phương thức thanh toán
                    </div>
                    <table class="table table-file bank-table" id="tblThanhToan">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Phương thức</th>
                                <th scope="col">Link</th>
                                <th scope="col">Hướng dẫn</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="col">QR Code</th>
                                <th scope="col"><b id="btnNopLePhi" class="btn pointer"><i class="fal fa-hand-holding-usd me-2"></i> Nộp lệ phí</b></th>
                            </tr>
                        </tbody>
                        <tfoot></tfoot>
                    </table>
                    <div class="fw-bold text-dark-blue fs-16p mt-4">
                        Kết quả tuyển sinh
                    </div>
                    <table class="table table-file bank-table" id="tblKetQuaTuyenSinh">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Loại điểm</th>
                                <th scope="col">Điểm</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                    <div class="ad-fee-total text-right d-block">
                        <%--<button class="btn" id="btnNopLePhi"><i class="fal fa-hand-holding-usd me-2"></i> Nộp lệ phí xét tuyển</button>--%>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- end content -->
        
    </div>
    <!-- footer -->
    <div class="footer">
        <div class="footer-top">
            <div class="container-xl">
                <a href="#" class="logo-footer d-block text-center LOGOFOOTER">
                </a>
                <div class="footer-content">
                    <div class="footer-item">
                        <i class="fal fa-map-marked-alt"></i>
                        <div class="meta">
                            <p class="top">Địa chỉ:</p>
                            <p class="mb-0 DIACHI"></p>
                        </div>
                    </div>
                    <div class="footer-item">
                        <i class="fal fa-phone-volume"></i>
                        <div class="meta">
                            <p class="top">Hotline:</p>
                            <p class="mb-0"><a class="SODIENTHOAICODINH"></a>Tuyển sinh: <a href="tel:"><b class="SODIENTHOAIDIDONG"></b></a>
                            </p>
                        </div>
                    </div>
                    <div class="footer-item">
                        <i class="fal fa-envelope-open"></i>
                        <div class="meta">
                            <p class="top">Email:</p>
                            <p class="mb-0"><a href="#" class="EMAIL"></a></p>
                        </div>
                    </div>
                    <div class="footer-item">
                        <i class="fal fa-globe"></i>
                        <div class="meta">
                            <p class="top">Website:</p>
                            <p class="mb-0"><a href="#" class="WEBSITE"></a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-end">
            <div class="container-xl">
                <div class=" d-flex justify-content-between flex-wrap">
                    <p>Copyright © Apis</p>
                    <p>Đơn vị phát triển: Công ty Cổ Phần dịch vụ Công nghệ APIS</p>
                </div>
            </div>
        </div>

    </div>
    <!-- end footer -->
    
    <div id="alert"></div>
</div>
    
<!-- Modal Thông báo đăng ký hoàn thành-->
<div class="modal fade registration-notice" id="modal-registration-notice" tabindex="-1" aria-labelledby="zoomfileLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="zoomfileLabel">Thông Báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body KETQUATONG" id="mailThanhCong">
                <p class="text-center LOGOMAIL"><img src="../assets/images/logo-phenikaa-1.png" style="max-height: 64px"/></p>
                <h4 class="text-center mt-2"><b class="TENTRUONG"></b></h4>
                <h2 class="text-center txt-tc mt-3"> HỆ THỐNG ĐÃ GHI NHẬN THÔNG TIN ĐĂNG KÝ XÉT TUYỂN</h2>
                <p class="HUONGDAN">Thí sinh nộp lệ phí xét tuyển để hoàn tất quá trình đăng ký. <a href="https://daotao.utt.edu.vn/Upload/ApisQuanLyTuyenSinh/HDSD/HDDKXT2022_V2.pdf?v=1" target="_blank">Tải hướng dẫn</a> </p>
                <h4 class="hotline">Hotline tuyển sinh: <span class="SODIENTHOAIDIDONG">094.651.1010</span></h4>
                <div class="info-school mb-20">
                    <p><b class="TENTRUONG">Trường Đại học </b></p>
                    <p >Địa chỉ: <span class="DIACHI"></span></p>
                    <p >Điện thoai: <span class="SODIENTHOAICODINH">024.62918118</span></p>
                    <p >Hotline tuyển sinh: <span class="SODIENTHOAIDIDONG">094.651.1010</span></p>
                    <p>Email: <span  class="EMAIL"></span></p>
                </div>


                <h5>CẢM ƠN BẠN ĐÃ CHỌN <span class="TENTRUONG_VIETTAT"></span></h5>
                <p>Tài khoản đăng nhập vào hệ thống của bạn là:</p>
                <div class="sv-account mt-2 mb-20">
                    <p>Tên đăng nhập: <span id="lblTenDangNhap"></span></p>
                    <p>Mật khẩu: <span id="lblMatKhau"></span></p>
                    <p>Mã hồ sơ: <span id="lblMaHoSo"></span></p>
                </div>
                <p><a href="#" x  data-bs-toggle="modal" data-bs-target="#modal-sv-registration">Nhấp vào đây để đăng nhập.</a></p>

                <p>Vui lòng kiểm tra và xác nhận email của bạn đã đăng ký. Điều này sẽ giúp bạn nhận được các thông báo
                    của
                    Nhà trường và các tin nhắn quan trọng khác rất cần thiết cho việc xét tuyển của bạn.</p>
                <p><i>Trân trọng! Thông tin này đã được gửi qua email khi bạn đăng ký.</i> </p>
                <div id="tblThongTinDangKy" style="display: none;">
                    <h5>THÔNG TIN ĐÃ ĐĂNG KÝ </h5>
                    <table style="margin-top: -10px;">
                        <thead>
                            <tr>
                                <td>Trường thông tin</td>
                                <td style="margin-left: 10px;">Kết quả</td>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- <tr>
                                <td>Họ tên</td>
                                <td>Nguyễn văn A</td>
                            </tr><tr>
                                <td>Giới tính</td>
                                <td>Nữ</td>
                            </tr><tr>
                                <td>Ngày sinh</td>
                                <td>12/12/1002</td>
                            </tr><tr>
                                <td>Dân tộc</td>
                                <td>Cháo</td>
                            </tr> -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="lblDisableChucNang"></div>
<script type="text/javascript">AXYZCLRVN = () => "<%= lblXYZCLRVN %>"</script>
    <%--PhenNikia--%>
    <%--
    <p class="text-center"><img src="../assets/images/PNK_LOGO.jpg" style="max-height: 64px"/></p>
    <h4 class="text-center mt-2"><b>UWE BRISTOL - PHENIKAA CAMPUS</b></h4>
    <h2 class="text-center txt-tc mt-3"> CHÚC MỪNG BẠN ĐÃ ĐĂNG KÝ THÀNH CÔNG</h2>
    <p>Để được hướng dẫn nộp hồ sơ tại văn phòng UWE Bristol - Phenikaa Campus, xin vui lòng liên hệ các số hotline sau:</p>
    <div class="info-school mb-20">
        <p>Hotline 1: 0981.324.886</p>
        <p>Hotline 2: 028.710.23450</p>
        <p>Hotline 3: 0246.2918.118 (máy lẻ: 141)</p>
        <p><b>UWE Bristol - Phenikaa Campus</b></p>
        <p>Địa chỉ: Đại học Phenikaa, Đường Nguyễn Văn Trác, Yên Nghĩa, Hà Đông, Hà Nội.</p>
        <p>Email: uwebristol@phenikaa-uni.edu.vn</p>
    </div>


    <h5>CẢM ƠN BẠN ĐÃ LỰA CHỌN UWE BRISTOL - PHENIKAA CAMPUS</h5>
    <p>Tài khoản đăng nhập để theo dõi quá trình tuyển sinh của bạn là:</p>
    <div class="sv-account mt-2 mb-20">
        <div class="avata-sv"><img src="../assets/images/avata-user.png"></div>
        <p>Tên đăng nhập: <span id="lblTenDangNhap"></span></p>
        <p>Mật khẩu: <span id="lblMatKhau"></span></p>
    </div>
    <p><a href="#" x  data-bs-toggle="modal" data-bs-target="#modal-sv-registration">Nhấp vào đây để đăng nhập.</a></p>

    <p>Thông tin về tài khoản của bạn đã được gửi qua email khi bạn đăng ký. Xin vui lòng kiểm tra và xác nhận email để tiếp tục theo dõi các thông báo quan trọng về quy trình tuyển sinh của chương trình.</p>
    <p><i>UWE Bristol - Phenikaa Campus trân trọng cảm ơn!</i> </p>

    --%>
<!-- Modal Xác nhận đăng ký -->
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
<script src="../assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="../assets/js/select2.min.js"></script>
<script src="../assets/js/swiper-bundle.min.js"></script>
<script src="../assets/js/slick.js"></script>
<script src="../assets/js/custom.js"></script>
<script src="../assets/js/crypto-js.js?v=4"></script>
<script src="../assets/pagination/jquery.simplePagination.min.js?v=1.10"></script>
    
<script type="text/javascript" src="../Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>    <!--CORE JS-->
<script type="text/javascript" src="../Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="../Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
<script type="text/javascript" src="../Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
<script type="text/javascript" src="../Config.js?v=1.3.1.2"></script><!--CORE JS-->
<script src="<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>/Core/uploadfile.js?v=1.0.0.12"></script><!--CORE JS-->
<script src="<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>/Core/uploadavatar.js?v=1.0.0.12"></script><!--CORE JS-->
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
    
<script src="tuyensinh.js?v=<%= Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    var main_doc = {};
    main_doc['TuyenSinh'] = new TuyenSinh();
    $(document).ready(function () {
        main_doc.TuyenSinh.init();
    });
</script>
</html>
