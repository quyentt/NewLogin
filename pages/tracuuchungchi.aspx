<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tracuuchungchi.aspx.cs" Inherits="Apis.NewLogin.pages.tracuuchungchi" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra cứu chứng chỉ - Trường Đại học Công nghệ Đông Á</title>
    <meta name="description" content="Cổng tra cứu kết quả thi và chứng chỉ - Trường Đại học Công nghệ Đông Á (EAUT)">
    <link rel="shortcut icon" type="image/png" href="../assets/logocactruong/donga.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/assettracuuvanbang/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/assettracuuvanbang/css/awesome-5.min.css">
    <link rel="stylesheet" href="../assets/assettracuuvanbang/css/tracuu-donga.css?v=<%= Guid.NewGuid().ToString() %>">
</head>

<body>
    <div class="overlay" id="overlay" style="display:none"></div>

    <div class="eaut-page">
        <!-- ============ HERO ============ -->
        <header class="eaut-hero">
            <div class="container-xxl">
                <div class="eaut-topbar">
                    <a class="eaut-brand" href="https://eaut.edu.vn" target="_blank" rel="noopener">
                        <img src="../assets/logocactruong/donga.png" alt="Logo Trường Đại học Công nghệ Đông Á">
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
                    <h1>Tra cứu <span>kết quả thi</span> &amp; <span>chứng chỉ</span></h1>
                    <p>Tra cứu nhanh kết quả thi và xác thực chứng chỉ do Trường Đại học Công nghệ Đông Á cấp.</p>
                </div>
            </div>
        </header>

        <!-- ============ MAIN ============ -->
        <main class="eaut-main">
            <div class="container-xxl">
                <div class="eaut-card">
                    <div class="eaut-tabs-wrap">
                        <nav class="nav eaut-tabs" id="nav-tab" role="tablist">
                            <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">
                                <i class="fal fa-clipboard-list-check"></i> Tra cứu kết quả thi
                            </button>
                            <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">
                                <i class="fal fa-file-certificate"></i> Tra cứu chứng chỉ
                            </button>
                        </nav>
                    </div>

                    <div class="tab-content" id="nav-tabContent">
                        <!-- ---------- TAB 1: KẾT QUẢ THI ---------- -->
                        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            <div class="eaut-form">
                                <p class="eaut-form-desc">Nhập số báo danh và ngày sinh để xem kết quả thi chứng chỉ.</p>
                                <div class="row g-3 align-items-start">
                                    <div class="col-12 col-md-5 eaut-field">
                                        <label for="txtSearch_SoBaoDanh">Số báo danh <span class="req">*</span></label>
                                        <div class="eaut-input">
                                            <i class="fal fa-id-card"></i>
                                            <input class="form-control" id="txtSearch_SoBaoDanh" placeholder="VD: DA0123" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-4 eaut-field">
                                        <label for="txtSearch_NgaySinh">Ngày sinh <span class="req">*</span></label>
                                        <div class="eaut-input">
                                            <i class="fal fa-calendar-alt"></i>
                                            <input class="form-control" id="txtSearch_NgaySinh" placeholder="dd/mm/yyyy" inputmode="numeric" maxlength="10" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3 eaut-field">
                                        <label class="d-none d-md-block">&nbsp;</label>
                                        <button type="button" class="btn-eaut" id="btnSearch_KetQua"><i class="fal fa-search"></i> Tra cứu</button>
                                    </div>
                                </div>
                            </div>
                            <div class="eaut-result">
                                <div class="eaut-result-head">
                                    <h2>Kết quả tra cứu</h2>
                                    <span class="eaut-count" id="cntKetQua"></span>
                                </div>
                                <div class="eaut-table-wrap">
                                    <table class="eaut-table" id="tblKetQua">
                                        <thead><tr></tr></thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                                <div class="eaut-empty" id="emptyKetQua">
                                    <div class="ico"><i class="fal fa-search"></i></div>
                                    <h3>Chưa có dữ liệu</h3>
                                    <p>Nhập thông tin phía trên và bấm <b>Tra cứu</b> để xem kết quả.</p>
                                </div>
                            </div>
                        </div>

                        <!-- ---------- TAB 2: CHỨNG CHỈ ---------- -->
                        <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                            <div class="eaut-form">
                                <p class="eaut-form-desc">Nhập số hiệu in trên chứng chỉ để kiểm tra thông tin.</p>
                                <div class="row g-3 align-items-start">
                                    <div class="col-12 col-md-9 eaut-field">
                                        <label for="txtSearch_SoChungChi">Số hiệu chứng chỉ <span class="req">*</span></label>
                                        <div class="eaut-input">
                                            <i class="fal fa-award"></i>
                                            <input class="form-control" id="txtSearch_SoChungChi" placeholder="Nhập số hiệu chứng chỉ" autocomplete="off">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3 eaut-field">
                                        <label class="d-none d-md-block">&nbsp;</label>
                                        <button type="button" class="btn-eaut" id="btnSearch_ChungChi"><i class="fal fa-search"></i> Tra cứu</button>
                                    </div>
                                </div>
                            </div>
                            <div class="eaut-result">
                                <div class="eaut-result-head">
                                    <h2>Kết quả tra cứu</h2>
                                    <span class="eaut-count" id="cntChungChi"></span>
                                </div>
                                <div class="eaut-table-wrap">
                                    <table class="eaut-table" id="tblChungChi">
                                        <thead><tr></tr></thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                                <div class="eaut-empty" id="emptyChungChi">
                                    <div class="ico"><i class="fal fa-file-certificate"></i></div>
                                    <h3>Chưa có dữ liệu</h3>
                                    <p>Nhập số hiệu chứng chỉ và bấm <b>Tra cứu</b> để kiểm tra.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Hướng dẫn -->
                <div class="eaut-guide">
                    <div class="eaut-guide-item">
                        <div class="num">1</div>
                        <div>
                            <h4>Chọn hình thức tra cứu</h4>
                            <p>Tra cứu kết quả thi hoặc tra cứu chứng chỉ đã được cấp.</p>
                        </div>
                    </div>
                    <div class="eaut-guide-item">
                        <div class="num">2</div>
                        <div>
                            <h4>Nhập thông tin chính xác</h4>
                            <p>Ngày sinh nhập theo định dạng <b>dd/mm/yyyy</b>, ví dụ 05/09/2003.</p>
                        </div>
                    </div>
                    <div class="eaut-guide-item">
                        <div class="num">3</div>
                        <div>
                            <h4>Cần hỗ trợ?</h4>
                            <p>Nếu thông tin không đúng, vui lòng liên hệ nhà trường theo thông tin bên dưới.</p>
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
                                <img src="../assets/logocactruong/donga.png" alt="EAUT">
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

    <div id="alert"></div>
</body>
<script src="../assets/assettracuuvanbang/js/bootstrap.bundle.min.js"></script>
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
        var avatar          = '';
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

<script src="tracuuchungchi.js?v=<%= Guid.NewGuid().ToString() %>"></script>

<script type="text/javascript">
    var main_doc = {};
    main_doc['TraCuuChungChi'] = new TraCuuChungChi();
    $(document).ready(function () {
        main_doc.TraCuuChungChi.init();
    });
</script>
</html>
