﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Apis.NewLogin.tracuuvanbang" %>
<%-- Tra cứu & xác thực văn bằng (không hiển thị ảnh văn bằng)
     - Không có ?m= : form tra cứu + bảng kết quả, bấm Chi tiết để xem thông tin
     - Có ?m=<mã>   : (quét QR trên bằng) hiển thị thẳng thông tin văn bằng --%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra cứu văn bằng - Trường Đại học Công nghệ Đông Á</title>
    <meta name="description" content="Tra cứu và xác thực thông tin văn bằng - Trường Đại học Công nghệ Đông Á (EAUT)">
    <link rel="shortcut icon" type="image/png" href="assets/logocactruong/donga.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/awesome-5.min.css">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/select2.min.css">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/tracuu-donga.css?v=<%= Guid.NewGuid().ToString() %>">
</head>

<body>
    <div class="overlay" id="overlay" style="display:none"></div>

    <div class="eaut-page">
        <!-- ============ HERO ============ -->
        <header class="eaut-hero eaut-hero--compact">
            <div class="container-xxl xt-wide">
                <div class="eaut-topbar">
                    <a class="eaut-brand" href="https://eaut.edu.vn" target="_blank" rel="noopener">
                        <img src="assets/logocactruong/donga.png" alt="Logo Trường Đại học Công nghệ Đông Á">
                        <div class="eaut-brand-text">
                            <div class="vn">Trường Đại học Công nghệ Đông Á</div>
                            <div class="en">East Asia University of Technology</div>
                        </div>
                    </a>
                    <a class="eaut-home" href="https://eaut.edu.vn" target="_blank" rel="noopener">
                        <i class="fal fa-home"></i><span>Trang chủ</span>
                    </a>
                </div>
                <div class="eaut-hero-title">
                    <div class="eaut-badge"><i class="fas fa-shield-check"></i> Cổng tra cứu chính thức</div>
                    <h1>Tra cứu &amp; xác thực <span>văn bằng</span></h1>
                </div>
            </div>
        </header>

        <!-- ============ MAIN ============ -->
        <main class="eaut-main">
            <div class="container-xxl xt-wide">
                <div class="eaut-card">

                    <!-- ===== CHẾ ĐỘ TRA CỨU (không có ?m=) ===== -->
                    <div id="xtSearch" style="display:none">
                        <div class="eaut-form eaut-form--top">
                            <div class="eaut-form-title">
                                <div class="ico"><i class="fal fa-file-certificate"></i></div>
                                <div>
                                    <h2>Thông tin tra cứu</h2>
                                    <p class="eaut-form-desc mb-0">Nhập số hiệu văn bằng hoặc họ tên và ngày sinh, sau đó nhập mã bảo vệ.</p>
                                </div>
                            </div>

                            <div class="row g-3">
                                <!-- Hệ đào tạo (ẩn) -->
                                <div class="col-12 eaut-field" style="display:none">
                                    <label for="drpHeDaoTao">Hệ đào tạo</label>
                                    <div class="eaut-input eaut-select">
                                        <i class="fal fa-graduation-cap"></i>
                                        <select id="drpHeDaoTao" class="form-select select-opt"></select>
                                    </div>
                                </div>

                                <div class="col-12 col-lg-6 eaut-field">
                                    <label for="drpLoaiVanBangChungChi">Loại văn bằng, chứng chỉ</label>
                                    <div class="eaut-input eaut-select">
                                        <i class="fal fa-file-certificate"></i>
                                        <select id="drpLoaiVanBangChungChi" class="form-select select-opt"></select>
                                    </div>
                                </div>

                                <div class="col-12 col-lg-6 eaut-field">
                                    <label for="txtSoHieuChungChi">Số hiệu</label>
                                    <div class="eaut-input">
                                        <i class="fal fa-award"></i>
                                        <input id="txtSoHieuChungChi" class="form-control" placeholder="Nhập số hiệu văn bằng" autocomplete="off">
                                    </div>
                                </div>

                                <!-- Số vào sổ (ẩn) -->
                                <div class="col-12 col-lg-6 eaut-field" style="display:none">
                                    <label for="txtSoVaoSo">Số vào sổ</label>
                                    <div class="eaut-input">
                                        <i class="fal fa-book"></i>
                                        <input id="txtSoVaoSo" class="form-control" autocomplete="off">
                                    </div>
                                </div>

                                <div class="col-12" id="zoneHoTenNgaySinh">
                                    <div class="row g-3">
                                        <div class="col-12 col-lg-6 eaut-field">
                                            <label for="txtHoTenDayDu">Họ tên đầy đủ</label>
                                            <div class="eaut-input">
                                                <i class="fal fa-user"></i>
                                                <input id="txtHoTenDayDu" class="form-control" placeholder="VD: Nguyễn Văn A" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="col-12 col-lg-6 eaut-field">
                                            <label for="txtNgaySinh">Ngày sinh</label>
                                            <div class="eaut-input">
                                                <i class="fal fa-calendar-alt"></i>
                                                <input id="txtNgaySinh" class="form-control" placeholder="dd/mm/yyyy" inputmode="numeric" maxlength="10" autocomplete="off">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12 col-lg-9 eaut-field">
                                    <label for="code">Mã bảo vệ <span class="req">*</span></label>
                                    <div class="eaut-captcha">
                                        <div class="eaut-captcha-img"><canvas id="canvas"></canvas></div>
                                        <button type="button" class="eaut-captcha-refresh" onclick="refreshImage()" title="Đổi mã khác" aria-label="Đổi mã khác">
                                            <i class="fal fa-sync-alt"></i>
                                        </button>
                                        <div class="eaut-input flex-grow-1">
                                            <i class="fal fa-shield-check"></i>
                                            <input id="code" class="form-control" placeholder="Nhập mã bảo vệ" autocomplete="off">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-3 eaut-field">
                                    <label class="d-none d-lg-block">&nbsp;</label>
                                    <button type="button" id="btnSearch" class="btn-eaut"><i class="fal fa-search"></i> Tìm kiếm</button>
                                </div>
                            </div>
                        </div>

                        <div class="eaut-result">
                            <div class="eaut-result-head">
                                <h2>Kết quả tìm kiếm</h2>
                                <span class="eaut-count" id="cntKetQuaTimKiem"></span>
                            </div>
                            <div class="eaut-table-wrap" id="wrapKetQuaTimKiem" style="display:none">
                                <table id="tblKetQuaTimKiem" class="eaut-table eaut-table--label">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="text-center">STT</th>
                                            <th scope="col">Họ và tên</th>
                                            <th scope="col">Giới tính</th>
                                            <th scope="col">Ngày sinh</th>
                                            <th scope="col">Nơi sinh</th>
                                            <th scope="col">Ngành đào tạo</th>
                                            <th scope="col">Chuyên ngành đào tạo</th>
                                            <th scope="col">Số hiệu văn bằng</th>
                                            <th scope="col">Số vào sổ</th>
                                            <th scope="col">Ngày cấp</th>
                                            <th scope="col">Tên văn bằng</th>
                                            <th scope="col" class="text-center">Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                            <div class="eaut-empty" id="emptyKetQuaTimKiem">
                                <div class="ico"><i class="fal fa-search"></i></div>
                                <h3>Chưa có dữ liệu</h3>
                                <p>Nhập thông tin phía trên và bấm <b>Tìm kiếm</b> để tra cứu văn bằng.</p>
                            </div>
                        </div>
                    </div>

                    <!-- ===== CHẾ ĐỘ QUÉT QR (có ?m=) ===== -->
                    <div id="xtQR" class="xt-qr" style="display:none">
                        <div class="xt-loading" id="xtLoading">
                            <div class="xt-spinner"></div>
                            <p>Đang xác thực thông tin văn bằng...</p>
                        </div>
                        <div class="eaut-empty" id="xtEmpty" style="display:none">
                            <div class="ico"><i class="fal fa-exclamation-triangle"></i></div>
                            <h3 id="xtEmptyTitle">Không tìm thấy văn bằng</h3>
                            <p id="xtEmptyDesc">Mã QR không hợp lệ hoặc văn bằng không tồn tại trên hệ thống.</p>
                            <a class="xt-link" href="xacthucvanbang.aspx" style="display: none;"><i class="fal fa-search"></i> Tra cứu bằng số hiệu văn bằng</a>
                        </div>
                        <div id="xtQRResult" style="display:none">
                            <div id="xtQRInfo"></div>
                            <div class="xt-meta">
                                <span><i class="fal fa-clock me-1"></i>Thời điểm xác thực: <b id="xtThoiGian"></b></span>
                                <a class="xt-link" href="xacthucvanbang.aspx"><i class="fal fa-search"></i> Tra cứu văn bằng khác</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- ============ FOOTER ============ -->
        <footer class="eaut-footer">
            <div class="eaut-footer-top">
                <div class="container-xxl xt-wide">
                    <div class="row g-4">
                        <div class="col-12 col-lg-4">
                            <div class="eaut-footer-brand">
                                <img src="assets/logocactruong/donga.png" alt="EAUT">
                                <div>
                                    <div class="vn">Trường Đại học Công nghệ Đông Á</div>
                                    <div class="en">East Asia University of Technology</div>
                                </div>
                            </div>
                            <p class="eaut-footer-note">Quyết định thành lập số: 1777/QĐ-TTg</p>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4">
                            <h5>Cơ sở Hà Nội</h5>
                            <ul class="eaut-contact">
                                <li><i class="fal fa-map-marker-alt"></i><span>Đường Phan Tây Nhạc, phường Xuân Phương, TP. Hà Nội</span></li>
                                <li><i class="fal fa-phone-alt"></i><span><a href="tel:02435552008">0243.555.2008</a> / <a href="tel:02422365888">024.2236.5888</a></span></li>
                                <li><i class="fal fa-envelope"></i><a href="mailto:tuyensinh@eaut.edu.vn">tuyensinh@eaut.edu.vn</a></li>
                                <li><i class="fal fa-globe"></i><a href="https://eaut.edu.vn" target="_blank" rel="noopener">eaut.edu.vn</a></li>
                            </ul>
                        </div>
                        <div class="col-12 col-md-6 col-lg-4">
                            <h5>Cơ sở Bắc Ninh</h5>
                            <ul class="eaut-contact">
                                <li><i class="fal fa-map-marker-alt"></i><span>Làng Đại học, phường Võ Cường, Bắc Ninh</span></li>
                                <li><i class="fal fa-phone-alt"></i><span><a href="tel:02435552008">0243.555.2008</a> / <a href="tel:02422365888">024.2236.5888</a></span></li>
                                <li><i class="fal fa-envelope"></i><a href="mailto:tuyensinh@eaut.edu.vn">tuyensinh@eaut.edu.vn</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="eaut-footer-bottom">
                <div class="container-xxl xt-wide d-flex justify-content-between flex-wrap gap-2">
                    <span>Copyright © <%= DateTime.Now.Year %> Trường Đại học Công nghệ Đông Á</span>
                    <span>Đơn vị phát triển: Công ty Cổ phần Dịch vụ Công nghệ APIS</span>
                </div>
            </div>
        </footer>
    </div>

    <!-- ============ MODAL CHI TIẾT (chế độ tra cứu) ============ -->
    <div class="modal fade eaut-modal" id="zoneChiTietKetQuaTimKiem" tabindex="-1" aria-labelledby="lblChiTietTitle" style="display: none">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable modal-fullscreen-md-down">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="lblChiTietTitle"><i class="fal fa-file-certificate me-2"></i>Thông tin văn bằng: <span id="lblChiTietHoTen"></span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <div id="xtModalInfo"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- ============ MẪU THÔNG TIN VĂN BẰNG (dùng chung cho QR và modal) ============ -->
    <template id="tplThongTin">
        <div class="xt-head">
            <div class="xt-avatar" data-f="KyTu"></div>
            <div class="xt-head-main">
                <div class="xt-head-label">Người được cấp bằng</div>
                <div class="xt-head-name" data-f="HoTen"></div>
                <div class="xt-chips">
                    <span class="xt-chip"><i class="fal fa-award"></i>Số hiệu <b data-f="SoHieu"></b></span>
                    <span class="xt-chip"><i class="fal fa-graduation-cap"></i><b data-f="TrinhDo"></b></span>
                    <span class="xt-chip"><i class="fal fa-calendar-check"></i>Tốt nghiệp <b data-f="NamTN"></b></span>
                </div>
            </div>
            <div class="xt-status">
                <i class="fas fa-check-circle xt-status-icon"></i>
                <div>
                    <div class="xt-status-title">Văn bằng hợp lệ</div>
                    <div class="xt-status-desc">Khớp với dữ liệu gốc của Nhà trường</div>
                </div>
            </div>
        </div>

        <section class="xt-strip">
            <h6><i class="fal fa-university"></i>Thông tin quản lý văn bằng</h6>
            <div class="xt-kv"><span>Đơn vị cấp</span><b>Trường Đại học Công nghệ Đông Á</b></div>
            <div class="xt-kv"><span>Trình độ</span><b data-f="TrinhDo"></b></div>
        </section>

        <div class="xt-grid">
            <section class="eaut-detail-group">
                <h6><i class="fal fa-user-graduate"></i>Thông tin người được cấp bằng</h6>
                <dl class="eaut-dl">
                    <dt>Họ và tên</dt><dd data-f="HoTen"></dd>
                    <dt>Ngày sinh</dt><dd data-f="NgaySinh"></dd>
                    <dt>Giới tính</dt><dd data-f="GioiTinh"></dd>
                    <dt>Ngành</dt><dd data-f="Nganh"></dd>
                    <dt>Hạng tốt nghiệp</dt><dd data-f="HangTN"></dd>
                    <dt>Năm tốt nghiệp</dt><dd data-f="NamTN"></dd>
                </dl>
            </section>
            <section class="eaut-detail-group">
                <h6><i class="fal fa-file-certificate"></i>Thông tin văn bằng</h6>
                <dl class="eaut-dl">
                    <dt>Tên văn bằng</dt><dd data-f="TenVB"></dd>
                    <dt>Số hiệu bằng</dt><dd data-f="SoHieu"></dd>
                    <dt>Số vào sổ cấp bằng</dt><dd data-f="SoVaoSo"></dd>
                    <dt>Ngày ký</dt><dd data-f="NgayKy"></dd>
                    <dt>Người ký</dt><dd>Hiệu trưởng</dd>
                </dl>
            </section>
        </div>

        <section class="xt-strip">
            <h6><i class="fal fa-info-circle"></i>Thông tin khác</h6>
            <div class="xt-kv"><span>Tình trạng văn bằng</span><b data-f="TinhTrang"></b></div>
        </section>
    </template>

    <div id="alert"></div>
</body>

<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="assets/js/select2.min.js"></script>
<script src="assets/js/crypto-js.js?v=3"></script>
<script src="assets/pagination/jquery.simplePagination.min.js?v=1.8"></script>

<script type="text/javascript" src="Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>    <!--CORE JS-->
<script type="text/javascript" src="Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
<script type="text/javascript" src="Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
<script type="text/javascript" src="Config.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
<script src="assets/js/jscaptcha.js?v=1.3.2.4"></script>
<script type="text/javascript">

    function Init_Prammater() {
        var rootPath        = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPath") %>';
        var rootPathUpload  = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>';
        var rootPathReport  = '<%= report %>';

        var appId           = '<%= app_id %>';
        var avatar          = '<%= avatar %>';
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

<script src="xacthucvanbang.js?v=<%= Guid.NewGuid().ToString() %>"></script>

<script type="text/javascript">
    const captcha = new Captcha($('#canvas'), {
        length: 4
    });
    var main_doc = {};
    main_doc['xacthucvanbang'] = new xacthucvanbang();
    $(document).ready(function () {
        main_doc.xacthucvanbang.init();
    });
    function refreshImage() {
        captcha.refresh();
    }
</script>
</html>
