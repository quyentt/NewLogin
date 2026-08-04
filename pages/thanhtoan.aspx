<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thanhtoan.aspx.cs" Inherits="Apis.NewLogin.pages.thanhtoan" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra cứu thông tin &amp; thanh toán phí nhập học</title>
    <link rel="shortcut icon" type="image/x-icon" href="../assets/images/logo.ico" />
    <link rel="stylesheet" href="../assets/csstuyensinh/styles.css?v=5">
    <link rel="stylesheet" href="../assets/csstuyensinh/tra-cuu-new.css?v=<%= Guid.NewGuid().ToString() %>">
    <link rel="stylesheet" href="../assets/fonts/FontAwesome.Pro.6.4.2/css/all.css">
</head>

<body>

    <div class="overlay" id="overlay" style="position: fixed; margin-top: 150px; z-index: 1051; margin-left: 50%; display: none">
        <i style="color: #00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>

    <%
        string _host = Request.Url.Host.ToLower();
        string _logoPath = "";
        string _schoolName = "Trường";
        string _schoolEmail = "";
        string _schoolHotline = "1900 1234";

        if (_host.Contains("eaut"))
        {
            _logoPath = "../assets/logocactruong/donga.png";
            _schoolName = "Trường Đại học Công nghệ Đông Á";
            _schoolEmail = "hotro@eaut.edu.vn";
        }
        else if (_host.Contains("utt"))
        {
            _logoPath = "../assets/logocactruong/CNGT.jpg";
            _schoolName = "Trường Đại học Công nghệ Giao thông Vận tải";
            _schoolEmail = "hotro@utt.edu.vn";
        }
        else if (_host.Contains("cmc"))
        {
            _logoPath = "../assets/logocactruong/cmc.jpg";
            _schoolName = "Trường Đại học CMC";
            _schoolEmail = "hotro@cmc.edu.vn";
        }
        else if (_host.Contains("hunre"))
        {
            _logoPath = "../assets/logocactruong/hunre.jpg";
            _schoolName = "Trường Đại học Tài nguyên và Môi trường Hà Nội";
            _schoolEmail = "hotro@hunre.edu.vn";
        }
        else if (_host.Contains("vnuf"))
        {
            _logoPath = "../assets/logocactruong/Logo_vnuf.jpg";
            _schoolName = "Trường Đại học Lâm nghiệp";
            _schoolEmail = "hotro@vnuf.edu.vn";
        }
    %>

    <!-- ==================== HEADER ==================== -->
    <header class="aps-tc-header">
        <div class="aps-tc-container">
            <div class="aps-tc-header_in">
                <a href="../login.aspx" class="aps-tc-back aps-tc-back--onheader">
                    <i class="fal fa-arrow-left"></i>
                    Quay lại trang đăng nhập
                </a>
            </div>
        </div>
    </header>

    <!-- ==================== HERO ==================== -->
    <section class="aps-tc-container">
        <div class="aps-tc-hero">
            <h1 class="aps-tc-hero_title">TRA CỨU THÔNG TIN &amp; THANH TOÁN PHÍ NHẬP HỌC</h1>
            <p class="aps-tc-hero_sub">Nhập thông tin để tra cứu và thanh toán các khoản phí nhập học</p>
            <div class="aps-tc-steps">
                <span class="aps-tc-step aps-tc-step--done aps-tc-step--active">
                    <span class="aps-tc-step_num">1</span>
                    <span class="aps-tc-step_label">Nhập Mã HS/SV/CCCD</span>
                </span>
                <span class="aps-tc-step_arrow aps-tc-step_arrow--on">
                    <svg viewBox="0 0 40 12" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M1 6h32" />
                        <path d="m33 2 5 4-5 4" />
                    </svg>
                </span>
                <span class="aps-tc-step aps-tc-step--done">
                    <span class="aps-tc-step_num">2</span>
                    <span class="aps-tc-step_label">Chọn khoản thanh toán</span>
                </span>
                <span class="aps-tc-step_arrow">
                    <svg viewBox="0 0 40 12" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M1 6h32" />
                        <path d="m33 2 5 4-5 4" />
                    </svg>
                </span>
                <span class="aps-tc-step">
                    <span class="aps-tc-step_num">3</span>
                    <span class="aps-tc-step_label">Thực hiện thanh toán</span>
                </span>
            </div>
        </div>
    </section>

    <!-- ==================== MAIN ==================== -->
    <main class="aps-tc-main">
        <div class="aps-tc-container">

            <!-- ---- Thẻ tra cứu ---- -->
            <section class="aps-tc-card aps-tc-card--search">
                <div class="aps-tc-search">
                    <span class="aps-tc-search_ill" aria-hidden="true">
                        <img src="../assets/images/img-timkiem.png" alt="" class="img-search" />
                    </span>
                    <div class="aps-tc-search_box">
                        <label class="aps-tc-label" for="txtSearch">Nhập Mã HS, SV/CCCD, Mã hồ sơ</label>
                        <div class="aps-tc-input-wrap">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="5" width="18" height="14" rx="2.5" />
                                <circle cx="8.5" cy="11" r="2" />
                                <path d="M5.5 16c.4-1.3 1.6-2 3-2s2.6.7 3 2" />
                                <path d="M14 10h4M14 13h4" />
                            </svg>
                            <input id="txtSearch" class="aps-tc-input form-control" type="text" value="" placeholder="Nhập Mã HS, SV/CCCD, Mã hồ sơ" />
                        </div>
                    </div>
                    <button type="button" class="aps-tc-btn aps-tc-btn--orange" id="btnSearch">
                        <i class="fal fa-search-dollar"></i>
                        Tra cứu
                    </button>
                </div>
                <!-- Kế hoạch tuyển sinh (giữ để JS còn hoạt động) -->
                <div style="display: none">
                    <select id="dropSearch_KeHoach" class="form-select select-opt"></select>
                </div>
            </section>

            <!-- ---- Empty state ---- -->
            <div id="zonekosv">
                <div class="aps-tc-card" style="text-align: center; padding: 40px 20px;">
                    <img src="../assets/images/xettuyen-emty.png" alt="" style="max-width: 300px; opacity: .85;" />
                </div>
            </div>

            <!-- ---- Có sinh viên ---- -->
            <div id="zonecosv" style="display: none">

                <!-- ---- Thông tin cá nhân ---- -->
                <section class="aps-tc-card">
                    <div class="aps-tc-card_head">
                        <i class="fa-duotone fa-solid fa-user" style="font-size:20px;color:var(--aps-blue);"></i>
                        <h2 class="aps-tc-card_title">Thông tin cá nhân</h2>
                    </div>
                    <div class="aps-tc-info-grid">
                        <div>
                            <p class="aps-tc-info_lbl">Họ và tên</p>
                            <p class="aps-tc-info_val"><b id="lblHoTen1"></b></p>
                        </div>
                        <div>
                            <p class="aps-tc-info_lbl">Mã sinh viên</p>
                            <p class="aps-tc-info_val"><b id="lblMaSinhVien"></b></p>
                        </div>
                        <div>
                            <p class="aps-tc-info_lbl">Ngày sinh</p>
                            <p class="aps-tc-info_val"><b id="lblNgaySinh"></b></p>
                        </div>
                        <div>
                            <p class="aps-tc-info_lbl">Lớp</p>
                            <p class="aps-tc-info_val"><b id="lblLopQuanLy"></b></p>
                        </div>
                        <div>
                            <p class="aps-tc-info_lbl">Ngành</p>
                            <p class="aps-tc-info_val"><b id="lblNganh"></b></p>
                        </div>
                        <div>
                            <p class="aps-tc-info_lbl">Khóa</p>
                            <p class="aps-tc-info_val"><b id="lblKhoa"></b></p>
                        </div>
                    </div>
                </section>

                <!-- ---- Danh sách khoản cần thanh toán ---- -->
                <section class="aps-tc-card">
                    <div class="aps-tc-card_head">
                        <i class="fa-duotone fa-solid fa-clipboard-list-check" style="font-size:20px;color:var(--aps-blue);"></i>
                        <h2 class="aps-tc-card_title">Danh sách khoản cần thanh toán</h2>
                        <span class="aps-tc-card_note">Tổng tiền đã chọn:&nbsp;<span id="lbSoTienDaChon"></span></span>
                    </div>

                    <div class="aps-tc-selectall">
                        <input class="aps-tc-check" type="checkbox" id="chkSelectAll_ThanhToan" name="chkSelectAll_ThanhToan" />
                        <label for="chkSelectAll_ThanhToan">Chọn tất cả</label>
                    </div>

                    <div class="aps-tc-table-wrap">
                        <table class="aps-tc-table table transcrip-table tabs-scores" id="tblThanhToan">
                            <thead>
                                <tr>
                                    <th class="aps-tc-c-center" scope="col" style="width: 60px;">STT</th>
                                    <th scope="col">Nội dung</th>
                                    <th class="aps-tc-c-right" scope="col">Số tiền</th>
                                    <th scope="col">Ghi chú</th>
                                    <th class="aps-tc-c-center" scope="col">Chi tiết</th>
                                    <th class="aps-tc-c-center" scope="col"></th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                            <tfoot></tfoot>
                        </table>
                    </div>

                    <div class="d-flex justify-content-end mt-3" id="zonebtnNopTruoc" style="display: none !important">
                        <div class="btn btn-default" id="btnDelete_NopTruoc"><i class="fal fa-trash me-2"></i>Hủy nộp trước</div>
                        <div class="btn btn-dask-blue ms-2" id="btnAdd_NopTruoc"><i class="fal fa-plus me-2"></i>Nộp trước</div>
                    </div>

                    <div class="aps-tc-pay">
                        <span class="aps-tc-pay_lbl">Phương thức thanh toán</span>
                        <div class="aps-tc-select-wrap">
                            <svg class="aps-tc-sel-ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="4" width="18" height="16" rx="2" />
                                <path d="M7 8h2M7 12h2M7 16h2M13 8h4M13 12h4M13 16h4" />
                            </svg>
                            <select class="aps-tc-select form-select" id="drpNganHang" aria-label="Phương thức thanh toán"></select>
                            <svg class="aps-tc-sel-caret" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="m6 9 6 6 6-6" />
                            </svg>
                        </div>
                        <div type="button" class="aps-tc-btn aps-tc-btn--green" id="btnThucHienThanhToan">
                            <i class="fal fa-money-check-edit-alt"></i>
                            THỰC HIỆN THANH TOÁN
                        </div>
                        <div class="aps-tc-pay_secure">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="4" y="10" width="16" height="11" rx="2.5" />
                                <path d="M8 10V7a4 4 0 0 1 8 0v3" />
                            </svg>
                            Hệ thống bảo mật theo tiêu chuẩn PCI-DSS
                        </div>
                    </div>
                </section>

                <!-- ---- Tabs + thống kê ---- -->
                <section class="aps-tc-card">
                    <ul class="nav nav-tabs aps-tc-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active aps-tc-tab is-active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">Xuất hóa đơn</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link aps-tc-tab" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">Thông tin tài chính</button>
                        </li>
                    </ul>

                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <div class="aps-tc-table-wrap">
                                <table class="aps-tc-table table table-file" id="tbldata_HoaDon">
                                    <thead>
                                        <tr>
                                            <th class="aps-tc-c-center" scope="col">STT</th>
                                            <th scope="col">Học kỳ</th>
                                            <th class="aps-tc-c-center" scope="col">Đợt</th>
                                            <th scope="col">Khoản thu</th>
                                            <th scope="col">Nội dung</th>
                                            <th class="aps-tc-c-right" scope="col">Số tiền</th>
                                            <th class="aps-tc-c-center" scope="col">Ngày tạo</th>
                                            <th class="aps-tc-c-center" scope="col"><input type="checkbox" class="chkSystemSelectAll"></th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                    <tfoot></tfoot>
                                </table>
                            </div>
                            <div class="justify-content-end mt-3" id="lblNutHDDT" style="float: right"></div>
                        </div>

                        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="aps-tc-stats finance-dashboard">
                                <div class="aps-tc-stat aps-tc-stat--green finance-dashboard-item">
                                    <div class="finance-dashboard-content">
                                        <div class="aps-tc-stat_num amount txtTongTien_KhoanPhaiNop">0<small>VND</small></div>
                                        <p class="aps-tc-stat_lbl">Khoản phải nộp</p>
                                        <button type="button" class="aps-tc-stat_link btnDetail_KhoanPhaiNop" style="background:none;border:none;padding:0;">
                                            <span>Chi tiết</span>
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M5 12h14M13 6l6 6-6 6" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <div class="aps-tc-stat aps-tc-stat--blue finance-dashboard-item">
                                    <div class="finance-dashboard-content">
                                        <div class="aps-tc-stat_num amount txtTongTien_KhoanDaNop">0<small>VND</small></div>
                                        <p class="aps-tc-stat_lbl">Khoản đã nộp</p>
                                        <button type="button" class="aps-tc-stat_link btnDetail_KhoanDaNop" style="background:none;border:none;padding:0;">
                                            <span>Chi tiết</span>
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M5 12h14M13 6l6 6-6 6" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <div class="aps-tc-stat aps-tc-stat--orange finance-dashboard-item">
                                    <div class="finance-dashboard-content">
                                        <div class="aps-tc-stat_num amount txtTongTien_KhoanDuocMien">0<small>VND</small></div>
                                        <p class="aps-tc-stat_lbl">Khoản được miễn</p>
                                        <button type="button" class="aps-tc-stat_link btnDetail_KhoanDuocMien" style="background:none;border:none;padding:0;">
                                            <span>Chi tiết</span>
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M5 12h14M13 6l6 6-6 6" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <div class="aps-tc-stat aps-tc-stat--red finance-dashboard-item">
                                    <div class="finance-dashboard-content">
                                        <div class="aps-tc-stat_num amount txtTongTien_KhoanDaRut">0<small>VND</small></div>
                                        <p class="aps-tc-stat_lbl">Khoản đã rút</p>
                                        <button type="button" class="aps-tc-stat_link btnDetail_KhoanDaRut" style="background:none;border:none;padding:0;">
                                            <span>Chi tiết</span>
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M5 12h14M13 6l6 6-6 6" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <div class="aps-tc-stat aps-tc-stat--purple finance-dashboard-item">
                                    <div class="finance-dashboard-content">
                                        <div class="aps-tc-stat_num amount txtTongTien_PhieuHoaDon">0<small>VND</small></div>
                                        <p class="aps-tc-stat_lbl">Danh sách phiếu hóa đơn</p>
                                        <button type="button" class="aps-tc-stat_link btnDetail_PhieuHoaDon" style="background:none;border:none;padding:0;">
                                            <span>Chi tiết</span>
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M5 12h14M13 6l6 6-6 6" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- ---- Lưu ý ---- -->
                <div class="aps-tc-notice">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="9" />
                        <path d="M12 11v5" />
                        <path d="M12 8h.01" />
                    </svg>
                    <span><b>Lưu ý:</b> Sau khi thanh toán thành công, tài khoản email sinh viên sẽ được cấp và gửi về số điện thoại/email đã đăng ký.</span>
                </div>
            </div>

        </div>
    </main>

    <!-- ==================== FOOTER ==================== -->
    <footer class="aps-tc-footer">
        <div class="aps-tc-container">
            <div class="aps-tc-footer_grid">
                <div class="aps-tc-footer_logo">
                    <img src="<%= _logoPath %>" alt=""
                         onerror="this.onerror=null;this.style.display='none';" />
                </div>
                <div>
                    <h3 class="aps-tc-foot_title">HỖ TRỢ THÍ SINH</h3>
                    <p class="aps-tc-foot_line">Hotline: <%= _schoolHotline %></p>
                    <p class="aps-tc-foot_line">Email: <%= _schoolEmail %></p>
                    <p class="aps-tc-foot_line">Thời gian hỗ trợ: 7:30 - 17:00 (T2 - T6)</p>
                </div>
                <div>
                    <h3 class="aps-tc-foot_title">KẾT NỐI VỚI CHÚNG TÔI</h3>
                    <div class="aps-tc-socials">
                        <a href="#" class="aps-tc-social aps-tc-social--fb" aria-label="Facebook">
                            <svg viewBox="0 0 24 24" fill="currentColor">
                                <path d="M13 22v-8h2.7l.4-3.1H13V8.9c0-.9.3-1.5 1.6-1.5H16V4.6c-.3 0-1.2-.1-2.3-.1-2.3 0-3.9 1.4-3.9 4v2.3H7.2V14H9.8v8H13z" />
                            </svg>
                        </a>
                        <a href="#" class="aps-tc-social aps-tc-social--yt" aria-label="YouTube">
                            <svg viewBox="0 0 24 24" fill="currentColor">
                                <path d="M22 8.2a2.6 2.6 0 0 0-1.8-1.8C18.6 6 12 6 12 6s-6.6 0-8.2.4A2.6 2.6 0 0 0 2 8.2 27 27 0 0 0 1.6 12 27 27 0 0 0 2 15.8a2.6 2.6 0 0 0 1.8 1.8C5.4 18 12 18 12 18s6.6 0 8.2-.4a2.6 2.6 0 0 0 1.8-1.8A27 27 0 0 0 22.4 12 27 27 0 0 0 22 8.2zM10 15V9l5.2 3L10 15z" />
                            </svg>
                        </a>
                        <a href="#" class="aps-tc-social aps-tc-social--zl" aria-label="Zalo">Zalo</a>
                        <a href="#" class="aps-tc-social aps-tc-social--web" aria-label="Website">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
                                <circle cx="12" cy="12" r="9" />
                                <path d="M3 12h18M12 3c2.5 2.5 2.5 15.5 0 18M12 3c-2.5 2.5-2.5 15.5 0 18" />
                            </svg>
                        </a>
                    </div>
                </div>
                <div>
                    <h3 class="aps-tc-foot_title">BẢO MẬT &amp; AN TOÀN</h3>
                    <p class="aps-tc-foot_line">Thông tin của bạn được bảo mật và mã hóa tuyệt đối.</p>
                </div>
            </div>
        </div>
        <div class="aps-tc-copyright">© 2026 <%= _schoolName %>. All rights reserved.</div>
    </footer>

    <!-- ==================== MODALS (bootstrap - giữ nguyên hoạt động) ==================== -->
    <!-- Modal chi tiết 1 -->
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

    <!-- Modal xác nhận chi tiết -->
    <div class="modal fade finance-modal" id="modalXacNhanChiTiet" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="finance-user-info in-modal">
                        <p><b>Danh sách <span id="lblXacNhanChiTiet"></span></b></p>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="fw-bold text-dark-blue fs-16p mt-4">Số tiền đã chọn<span id="lbSoTienXacNhanChiTiet" style="color: red; float: right"></span></p>
                    <table class="table transcrip-table tabs-scores" id="tblXacNhanChiTiet">
                        <thead>
                            <tr>
                                <th class="text-center" scope="col">STT</th>
                                <th scope="col" class="text-center">Học phần</th>
                                <th scope="col" class="text-center">Kiểu học</th>
                                <th scope="col" class="text-center">Lớp học phần</th>
                                <th scope="col" class="text-center">Loại khoản</th>
                                <th scope="col" class="text-center">Số tiền</th>
                                <th scope="col" class="text-center">Số tín</th>
                                <th scope="col" class="text-center">Học kỳ, đợt</th>
                                <th class="text-center" scope="col"><input type="checkbox" class="chkSelectSystemAll"></th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                        <tfoot></tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <div class="d-flex justify-content-end">
                        <a class="btn btn-outline-orange" id="btnSave_XacNhanChiTiet" data-bs-dismiss="modal" aria-label="Close">
                            <i class="fal fa-tasks me-2"></i>
                            <span>Thanh Toán đơn chi tiết</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thêm khoản Nộp trước -->
    <div class="modal fade" id="modalKhoanNopTruoc">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="finance-user-info in-modal">
                        <p><b>Thêm khoản Nộp trước</b></p>
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
                                        <div class="form-item d-flex form-add-info">
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
                                        <div class="form-item d-flex form-add-info">
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
                                        <div class="form-item d-flex form-add-info">
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

    <!-- Loading overlay khi thực hiện thanh toán -->
    <div id="aps-tc-loader">
        <div class="aps-tc-loader_box">
            <i class="fad fa-sync-alt fa-spin"></i>
            <div class="aps-tc-loader_text">Đang xử lý thanh toán, vui lòng đợi...</div>
            <div class="aps-tc-loader_sub">Hệ thống đang tạo mã QR / kết nối cổng thanh toán</div>
        </div>
    </div>
</body>

<!-- ==================== SCRIPTS (giữ nguyên toàn bộ) ==================== -->
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
<script type="text/javascript" src="../Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<script type="text/javascript" src="../Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<script type="text/javascript" src="../Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script>
<script type="text/javascript" src="../Config.js?v=<%= Guid.NewGuid().ToString() %>"></script>

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

<script src="thanhtoan.js?v=<%= Guid.NewGuid().ToString() %>"></script>

<script type="text/javascript">
    var main_doc = {};
    main_doc['ThanhToan'] = new ThanhToan();
    $(document).ready(function () {
        main_doc.ThanhToan.init();
    });
</script>

<script type="text/javascript">
    // Loading overlay khi bấm nút thực hiện thanh toán
    $(document).ready(function () {
        var $loader = $('#aps-tc-loader');
        var loaderTimer = null;

        function showLoader() {
            $loader.addClass('is-show');
            clearTimeout(loaderTimer);
            // fallback: tự ẩn sau 30s để không bị treo mãi
            loaderTimer = setTimeout(hideLoader, 30000);
        }

        function hideLoader() {
            $loader.removeClass('is-show');
            clearTimeout(loaderTimer);
        }

        // Bật khi click nút thanh toán
        $(document).on('click', '#btnThucHienThanhToan', function () {
            showLoader();
        });

        // Tắt khi có bất kỳ modal nào hiện lên (QR code, xác nhận, chi tiết...)
        $(document).on('shown.bs.modal', function () {
            hideLoader();
        });

        // Tắt khi có alert/thông báo xuất hiện (trường hợp lỗi)
        var alertEl = document.getElementById('alert');
        if (alertEl && window.MutationObserver) {
            new MutationObserver(function () {
                if (alertEl.children.length > 0) hideLoader();
            }).observe(alertEl, { childList: true, subtree: true });
        }
    });
</script>

</html>
