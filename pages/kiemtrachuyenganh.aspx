<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kiểm tra chuyên ngành nhập học</title>
    <link rel="shortcut icon" type="image/x-icon" href="../assets/images/logo.ico" />
    <link rel="stylesheet" href="../assets/csstuyensinh/styles.css?v=5">
    <link rel="stylesheet" href="../assets/csstuyensinh/tra-cuu-new.css?v=<%= Guid.NewGuid().ToString() %>">
    <link rel="stylesheet" href="../assets/fonts/FontAwesome.Pro.6.4.2/css/all.css">
    <style>
        .aps-ktcn-form { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px 20px; }
        .aps-ktcn-form .aps-tc-field { display: flex; flex-direction: column; }
        .aps-ktcn-form label { font-weight: 600; margin-bottom: 6px; color: #333; }
        .aps-ktcn-form input { padding: 10px 12px; border: 1px solid #d0d5dd; border-radius: 8px; font-size: 15px; }
        .aps-ktcn-form input:focus { outline: none; border-color: #1e5eb6; box-shadow: 0 0 0 3px rgba(30, 94, 182, .12); }
        .aps-ktcn-actions { text-align: right; margin-top: 16px; }
        .aps-ktcn-table td, .aps-ktcn-table th { vertical-align: middle; }
        .aps-ktcn-table tr.is-selected { background: #eaf3ff !important; }
        .aps-ktcn-badge-cur { display: inline-block; padding: 4px 10px; background: #16a34a; color: #fff; border-radius: 999px; font-size: 12px; font-weight: 600; }
        .aps-ktcn-rdo { display: inline-flex; align-items: center; gap: 6px; cursor: pointer; }
        .aps-ktcn-rdo input { transform: scale(1.15); cursor: pointer; }
        #zoneResult { margin-top: 20px; }
        .aps-ktcn-empty { text-align: center; padding: 40px 20px; color: #666; }
        @media (max-width: 768px) {
            .aps-ktcn-form { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

    <div class="overlay" id="overlay" style="position: fixed; margin-top: 150px; z-index: 1051; margin-left: 50%; display: none">
        <i style="color: #00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>

    <%
        string _host = Request.Url.Host.ToLower();
        string _logoPath = "";
        string _schoolName = "Trường";

        if (_host.Contains("eaut"))
        {
            _logoPath = "../assets/logocactruong/donga.png";
            _schoolName = "Trường Đại học Công nghệ Đông Á";
        }
        else if (_host.Contains("utt"))
        {
            _logoPath = "../assets/logocactruong/CNGT.jpg";
            _schoolName = "Trường Đại học Công nghệ Giao thông Vận tải";
        }
        else if (_host.Contains("cmc"))
        {
            _logoPath = "../assets/logocactruong/cmc.jpg";
            _schoolName = "Trường Đại học CMC";
        }
        else if (_host.Contains("hunre"))
        {
            _logoPath = "../assets/logocactruong/hunre.jpg";
            _schoolName = "Trường Đại học Tài nguyên và Môi trường Hà Nội";
        }
        else if (_host.Contains("vnuf"))
        {
            _logoPath = "../assets/logocactruong/Logo_vnuf.jpg";
            _schoolName = "Trường Đại học Lâm nghiệp";
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
            <% if (_logoPath != "") { %>
                <div style="text-align: center; margin-bottom: 12px;">
                    <img src="<%= _logoPath %>" alt="" style="max-height: 70px;" onerror="this.style.display='none';" />
                </div>
            <% } %>
            <h1 class="aps-tc-hero_title">KIỂM TRA CHUYÊN NGÀNH NHẬP HỌC &amp; XÁC NHẬN</h1>
            <p class="aps-tc-hero_sub">Thí sinh nhập thông tin cá nhân để kiểm tra và xác nhận chương trình đào tạo nhập học</p>
        </div>
    </section>

    <!-- ==================== MAIN ==================== -->
    <main class="aps-tc-main">
        <div class="aps-tc-container">

            <!-- ---- Form nhập thông tin ---- -->
            <section class="aps-tc-card">
                <div class="aps-tc-card_head">
                    <i class="fa-duotone fa-solid fa-id-card" style="font-size:20px;color:var(--aps-blue);"></i>
                    <h2 class="aps-tc-card_title">Thông tin thí sinh</h2>
                </div>

                <div class="aps-ktcn-form">
                    <div class="aps-tc-field">
                        <label for="txtCCCD">CCCD <span style="color:red">*</span></label>
                        <input type="text" id="txtCCCD" maxlength="20" placeholder="Nhập số CCCD/CMND" autocomplete="off" />
                    </div>
                    <div class="aps-tc-field">
                        <label for="txtHoTen">Họ và tên <span style="color:red">*</span></label>
                        <input type="text" id="txtHoTen" maxlength="100" placeholder="Nhập họ và tên đầy đủ" autocomplete="off" />
                    </div>
                    <div class="aps-tc-field">
                        <label for="txtNgaySinh">Ngày sinh <span style="color:red">*</span></label>
                        <input type="text" id="txtNgaySinh" maxlength="10" placeholder="dd/mm/yyyy" autocomplete="off" />
                    </div>
                </div>

                <div class="aps-ktcn-actions">
                    <button type="button" class="aps-tc-btn aps-tc-btn--orange" id="btnKiemTra">
                        <i class="fal fa-search"></i>
                        KIỂM TRA VÀ XÁC THỰC
                    </button>
                </div>
            </section>

            <!-- ---- Kết quả ---- -->
            <div id="zoneResult" style="display:none">
                <section class="aps-tc-card">
                    <div class="aps-tc-card_head">
                        <i class="fa-duotone fa-solid fa-clipboard-list-check" style="font-size:20px;color:var(--aps-blue);"></i>
                        <h2 class="aps-tc-card_title">Bạn kiểm tra và chọn chương trình học tương ứng</h2>
                    </div>

                    <div class="aps-tc-table-wrap">
                        <table class="aps-tc-table aps-ktcn-table table" id="tblChuongTrinh">
                            <thead>
                                <tr>
                                    <th class="text-center" style="width: 60px;">STT</th>
                                    <th>Ngành trúng tuyển</th>
                                    <th class="text-center">Mã chương trình</th>
                                    <th>Tên chương trình</th>
                                    <th class="text-center">Hiện tại</th>
                                    <th class="text-center" style="width: 100px;">Chọn</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>

                    <div class="aps-ktcn-actions">
                        <button type="button" class="aps-tc-btn aps-tc-btn--green" id="btnDongY">
                            <i class="fal fa-check"></i>
                            ĐỒNG Ý
                        </button>
                    </div>
                </section>
            </div>

        </div>
    </main>

    <div id="alert"></div>
    <div id="azzlock"></div>

</body>

<!-- ==================== SCRIPTS ==================== -->
<script src="../assets/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="../assets/js/custom.js"></script>
<script src="../assets/js/crypto-js.js?v=3"></script>

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

<script src="kiemtrachuyenganh.js?v=<%= Guid.NewGuid().ToString() %>"></script>

<script type="text/javascript">
    var main_doc = {};
    main_doc['KiemTraChuyenNganh'] = new KiemTraChuyenNganh();
    $(document).ready(function () {
        main_doc.KiemTraChuyenNganh.init();
    });
</script>

</html>
