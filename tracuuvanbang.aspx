<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tracuuvanbang.aspx.cs" Inherits="Apis.NewLogin.tracuuvanbang" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra cứu văn bằng - Trường Đại học Công nghệ Đông Á</title>
    <meta name="description" content="Cổng tra cứu văn bằng, chứng chỉ - Trường Đại học Công nghệ Đông Á (EAUT)">
    <link rel="shortcut icon" type="image/png" href="assets/logocactruong/donga.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&family=Noto+Serif:ital,wght@0,400;0,700;1,400&family=Oswald:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/awesome-5.min.css">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/select2.min.css">
    <link rel="stylesheet" href="assets/assettracuuvanbang/css/tracuu-donga.css?v=<%= Guid.NewGuid().ToString() %>">
</head>

<body>
    <div class="overlay" id="overlay" style="display:none"></div>

    <div class="eaut-page">
        <!-- ============ HERO ============ -->
        <header class="eaut-hero">
            <div class="container-xxl">
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
                    <h1>Tra cứu <span>văn bằng</span> &amp; <span>chứng chỉ</span></h1>
                    <p>Xác thực thông tin văn bằng, chứng chỉ do Trường Đại học Công nghệ Đông Á cấp.</p>
                </div>
            </div>
        </header>

        <!-- ============ MAIN ============ -->
        <main class="eaut-main">
            <div class="container-xxl">
                <div class="eaut-card">
                    <div class="eaut-form eaut-form--top">
                        <div class="eaut-form-title">
                            <div class="ico"><i class="fal fa-file-certificate"></i></div>
                            <div>
                                <h2>Thông tin tra cứu</h2>
                                <p class="eaut-form-desc mb-0">Nhập số hiệu văn bằng hoặc họ tên và ngày sinh, sau đó nhập mã bảo vệ.</p>
                            </div>
                        </div>

                        <div class="row g-3">
                            <!-- Hệ đào tạo (đang ẩn) -->
                            <div class="col-12 eaut-field sv-info-detail-item" style="display:none">
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

                            <!-- Số vào sổ (đang ẩn) -->
                            <div class="col-12 col-lg-6 eaut-field" style="display:none">
                                <label for="txtSoVaoSo">Số vào sổ</label>
                                <div class="eaut-input">
                                    <i class="fal fa-book"></i>
                                    <input id="txtSoVaoSo" class="form-control" placeholder="" autocomplete="off">
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

                            <!-- Captcha + nút tìm kiếm -->
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
                                <tfoot></tfoot>
                            </table>
                        </div>
                        <div class="eaut-empty" id="emptyKetQuaTimKiem">
                            <div class="ico"><i class="fal fa-search"></i></div>
                            <h3>Chưa có dữ liệu</h3>
                            <p>Nhập thông tin phía trên và bấm <b>Tìm kiếm</b> để tra cứu văn bằng.</p>
                        </div>
                    </div>
                </div>

                <!-- Hướng dẫn -->
                <div class="eaut-guide">
                    <div class="eaut-guide-item">
                        <div class="num">1</div>
                        <div>
                            <h4>Nhập thông tin văn bằng</h4>
                            <p>Nhập số hiệu in trên văn bằng, hoặc họ tên và ngày sinh của người được cấp.</p>
                        </div>
                    </div>
                    <div class="eaut-guide-item">
                        <div class="num">2</div>
                        <div>
                            <h4>Nhập mã bảo vệ</h4>
                            <p>Gõ đúng các ký tự trong ảnh. Nếu khó đọc, bấm nút <i class="fal fa-sync-alt"></i> để đổi mã khác.</p>
                        </div>
                    </div>
                    <div class="eaut-guide-item">
                        <div class="num">3</div>
                        <div>
                            <h4>Xem chi tiết</h4>
                            <p>Bấm biểu tượng <i class="fal fa-eye"></i> ở cột Chi tiết để xem đầy đủ thông tin văn bằng.</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- ============ FOOTER ============ -->
        <footer class="eaut-footer">
            <div class="eaut-footer-top">
                <div class="container-xxl">
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
                <div class="container-xxl d-flex justify-content-between flex-wrap gap-2">
                    <span>Copyright © <%= DateTime.Now.Year %> Trường Đại học Công nghệ Đông Á</span>
                    <span>Đơn vị phát triển: Công ty Cổ phần Dịch vụ Công nghệ APIS</span>
                </div>
            </div>
        </footer>
    </div>

    <!-- ============ MODAL CHI TIẾT ============ -->
    <div class="modal fade eaut-modal" id="zoneChiTietKetQuaTimKiem" tabindex="-1" aria-labelledby="lblChiTietTitle" style="display: none">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable modal-fullscreen-md-down">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="lblChiTietTitle"><i class="fal fa-file-certificate me-2"></i>Chi tiết văn bằng: <span class="lblHoTen"></span></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                </div>
                <div class="modal-body">
                    <!-- ===== VĂN BẰNG 2 MẶT + HIỆU ỨNG MỞ BÌA ===== -->
                    <div class="dp-stage">
                        <div class="dp-book" id="dpBook">
                            <!-- Mặt tiếng Anh -->
                            <div class="dp-page dp-page--en">
                                <div class="dp-inner">
                                    <div class="dp-nation">THE SOCIALIST REPUBLIC OF VIETNAM</div>
                                    <div class="dp-motto">Independence - Freedom - Happiness</div>
                                    <div class="dp-school">EAST ASIA UNIVERSITY OF TECHNOLOGY</div>
                                    <div class="dp-confer">confers</div>
                                    <div class="dp-title" id="dpTitleEn"></div>
                                    <div class="dp-major" id="dpMajorEn"></div>
                                    <div class="dp-rows">
                                        <div class="dp-row"><span>Upon:</span><b id="dpNameEn"></b></div>
                                        <div class="dp-row"><span>Date of birth:</span><b id="dpDobEn"></b></div>
                                        <div class="dp-row"><span>Degree classification:</span><b id="dpRankEn"></b></div>
                                    </div>
                                    <div class="dp-sign">
                                        <i id="dpPlaceEn">Bacninh,</i>
                                        <b>RECTOR</b>
                                    </div>
                                    <div class="dp-foot">
                                        <div>Reg. No.: <span id="dpRegEn"></span></div>
                                    </div>
                                </div>
                            </div>
                            <!-- Mặt tiếng Việt -->
                            <div class="dp-page dp-page--vn">
                                <div class="dp-inner">
                                    <div class="dp-nation">CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</div>
                                    <div class="dp-motto">Độc lập - Tự do - Hạnh phúc</div>
                                    <div class="dp-school">TRƯỜNG ĐẠI HỌC CÔNG NGHỆ ĐÔNG Á</div>
                                    <div class="dp-confer">cấp</div>
                                    <div class="dp-title" id="dpTitleVn"></div>
                                    <div class="dp-major" id="dpMajorVn"></div>
                                    <div class="dp-rows">
                                        <div class="dp-row"><span>Cho:</span><b id="dpNameVn"></b></div>
                                        <div class="dp-row"><span>Ngày sinh:</span><b id="dpDobVn"></b></div>
                                        <div class="dp-row"><span>Hạng tốt nghiệp:</span><b id="dpRankVn"></b></div>
                                    </div>
                                    <div class="dp-sign">
                                        <i id="dpPlaceVn">Bắc Ninh, ngày &nbsp; tháng &nbsp; năm</i>
                                        <b>HIỆU TRƯỞNG</b>
                                    </div>
                                    <div class="dp-foot">
                                        <div>Số hiệu: <span class="dp-serial" id="dpSoHieu"></span></div>
                                        <div>Số vào sổ gốc cấp văn bằng: <span id="dpSoVaoSo"></span></div>
                                    </div>
                                </div>
                            </div>

                            <!-- Bìa (2 cánh) -->
                            <div class="dp-door dp-door--a" aria-hidden="true">
                                <div class="dp-door-text"><small>Bằng tốt nghiệp</small><span>Trường Đại học Công nghệ Đông Á</span></div>
                            </div>
                            <div class="dp-door dp-door--b" aria-hidden="true">
                                <div class="dp-door-text"><small>Diploma</small><span>East Asia University of Technology</span></div>
                            </div>
                            <button type="button" class="dp-seal" id="dpSeal" aria-label="Mở văn bằng">
                                <img src="assets/logocactruong/donga.png" alt="">
                                <span class="dp-hint">Chạm để mở</span>
                            </button>
                        </div>

                        <div class="dp-actions">
                            <span class="dp-verified"><i class="fas fa-badge-check"></i> Thông tin văn bằng đã được xác thực trên hệ thống của Trường</span>
                            <button type="button" class="dp-replay" id="dpReplay"><i class="fal fa-redo"></i> Xem lại hiệu ứng</button>
                        </div>
                    </div>

                    <!-- ===== THÔNG TIN CHI TIẾT ===== -->
                    <div class="row g-3 mt-2">
                        <div class="col-12 col-lg-4">
                            <div class="eaut-detail-group h-100">
                                <h6>Thông tin cá nhân</h6>
                                <dl class="eaut-dl">
                                    <dt>Họ và tên</dt><dd class="lblHoTen"></dd>
                                    <dt>Giới tính</dt><dd class="lblGioiTinh"></dd>
                                    <dt>Ngày sinh</dt><dd class="lblNgaySinh"></dd>
                                    <dt>Nơi sinh</dt><dd class="lblNoiSinh"></dd>
                                    <dt>Dân tộc</dt><dd class="lblDanToc"></dd>
                                    <dt>Quốc tịch</dt><dd class="lblQuocTich"></dd>
                                </dl>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="eaut-detail-group h-100">
                                <h6>Thông tin đào tạo</h6>
                                <dl class="eaut-dl">
                                    <dt>Mã số sinh viên</dt><dd class="lblMaSoSinhVien"></dd>
                                    <dt>Ngành đào tạo</dt><dd class="lblNganh"></dd>
                                    <dt>Chuyên ngành</dt><dd class="lblChuyenNganh"></dd>
                                    <dt>Lớp</dt><dd class="lblLop"></dd>
                                    <dt>Trình độ đào tạo</dt><dd class="lblTrinhDo"></dd>
                                    <dt>Hình thức đào tạo</dt><dd class="lblHinhThucDaoTao"></dd>
                                    <dt>Khóa học</dt><dd class="lblKhoaHoc"></dd>
                                </dl>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="eaut-detail-group h-100">
                                <h6>Thông tin văn bằng</h6>
                                <dl class="eaut-dl">
                                    <dt>Quyết định tốt nghiệp</dt><dd class="lblQuyetDinhTotNghiep"></dd>
                                    <dt>Năm tốt nghiệp</dt><dd class="lblNamTotNghiep"></dd>
                                    <dt>Xếp loại</dt><dd class="lblXepLoai"></dd>
                                    <dt>Số hiệu văn bằng</dt><dd class="lblSoHieuVanBang"></dd>
                                    <dt>Số vào sổ</dt><dd class="lblSoVaoSo"></dd>
                                    <div id="zoneNgayCapBang"><dt>Ngày cấp bằng</dt><dd class="lblNgayCapBang"></dd></div>
                                    <dt>Ghi chú</dt><dd class="lblGhiChu"></dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="alert"></div>
</body>

<script src="assets/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="assets/js/select2.min.js"></script>
<script src="assets/js/swiper-bundle.min.js"></script>
<script src="assets/js/slick.js"></script>
<script src="assets/js/custom.js"></script>
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

<script src="tracuuvanbang.js?v=<%= Guid.NewGuid().ToString() %>"></script>

<script type="text/javascript">
    const captcha = new Captcha($('#canvas'), {
        length: 4
    });
    var main_doc = {};
    main_doc['tracuuvanbang'] = new tracuuvanbang();

    $(document).ready(function () {
        main_doc.tracuuvanbang.init();
    });
    function refreshImage() {
        captcha.refresh();
    }
</script>
</html>
