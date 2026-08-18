<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Apis.NewLogin.Index" %>
<!DOCTYPE html>
<html lang="vi" translate="no" class="notranslate">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google" content="notranslate">
    <meta http-equiv="Content-Language" content="vi">
    <title>Education management</title>
    <link rel="stylesheet" href="assets/css/styles.css?v=<%= Guid.NewGuid().ToString() %>">
    <link href="assets/select2/css/select2.min.css" rel="stylesheet" />
    <link href="assets/pagination/simplePagination.min.css" rel="stylesheet" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.ico" />
</head>

<body>
<div class="wrapper">
    <div id="overlay" style="position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); z-index:2051; display:none; background:#fff; padding:30px 55px; border-radius:12px; box-shadow:0 8px 30px rgba(0,0,0,0.15); text-align:center; min-width:220px;">
        <i class="fas fa-spinner fa-spin fa-3x" style="color:#223771;"></i>
        <h5 style="margin:18px 0 0; color:#223771; font-weight:600; font-size:15px;">Đang tải dữ liệu...</h5>
    </div>
    <div class="left-sidebar">
        <div class="sidebar-top">
            <a href="javascript:void(0)" class="menu-icon">
                <i class="fal fa-indent"></i>
            </a>
            <a href="javascript:void(0)" class="menu-icon-mobi">
                <i class="fal fa-indent"></i>
            </a>
            
            <div class="logo-single">
                <img src="logo.png" alt="" id="siteLogo">
            </div>
            <script>
                (function () {
                    var logoMap = {
                        'daotao.utt.edu.vn': 'assets/logocactruong/CNGT.jpg'
                    };
                    var host = (location.hostname || '').toLowerCase();
                    var src = logoMap[host];
                    if (src) {
                        var img = document.getElementById('siteLogo');
                        if (img) img.src = src;
                    }
                })();
            </script>
            <div class="line-1"></div>
            <div class="line-2"></div>
            <div class="line-hiden"></div>
        </div>

        <div class="sidebar-menu">
            <div class="accordion" >
                <div class="sidebar-menu-item refeshtrangchu">
                    <a class="sidebar-menu-header" href="#">
                        <i class="fas fa-house item-icon"></i>
                        <span>Trang chủ</span>
                    </a>
                </div>
            </div>
            <div class="accordion" id="sidebar-menu">
            </div>
        </div>
    </div>
    <div class="content-page ">
        <!-- navbar -->
        <div class="navbar">
            <div class="search-group-in-mobi">
                <i class="fal fa-search mobi-search-icon"></i>
                <form class="search-group">
                    <input type="email" class="search-form" placeholder="Tìm kiếm thông tin">
                    <button><i class="fal fa-search"></i></button>
                </form>
            </div>
            <div class="in-mobi-group">
                <div class="nav-account">
                    <div class="dropdown">
                        <button class=" " type="button" data-bs-toggle="dropdown">
                            <div class="user-image">
                                <img class="user-image" id="imgavatar" />
                            </div>
                            <span><%=fullname %></span>
                            <i class="fal fa-chevron-down user-arrow"></i>


                        </button>
                        
                        <ul class="dropdown-menu user-drop">
                            <li class="img-user">
                                <div class="user-avata-img">
                                    <img src="assets/images/avata.png" id="lblAvatar" />
                                </div>
                                <span  id="lblHoTenNguoiDangNhap"><%=fullname %></span>
                                <%--<p>Cập nhật lần cuối
                                    01/01/2022</p>--%>
                            </li>
                            <li><a class="dropdown-item" href="Pages/ChangePass.aspx"><i class="fal fa-key-skeleton"></i>Thay đổi mật
                                khẩu</a></li>
                            <li><a class="dropdown-item" id="btnLogout" style="cursor: pointer" ><i class="fal fa-sign-out"></i>Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">AXYZCLRVN = () => "<%= lblXYZCLRVN %>"</script>

        <!-- end navbar -->
        <!-- end navbar -->
        <!-- content -->
        <div class="content" id="main-content-wrapper">
            <!-- Popup cảnh báo hồ sơ chưa hoàn thành -->
            <div class="modal fade" id="dbHoSoWarnModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content db-hoso-modal">
                        <div class="db-hoso-modal-body">
                            <div class="db-hoso-modal-ic"><i class="fal fa-exclamation-triangle"></i></div>
                            <h4 class="db-hoso-modal-title">Hồ sơ sinh viên chưa hoàn thành</h4>
                            <p class="db-hoso-modal-desc">Vui lòng vào trang <b>Tự nhập hồ sơ</b> để nhập và tải lên đầy đủ thông tin bắt buộc.</p>
                        </div>
                        <div class="db-hoso-modal-footer">
                            <button type="button" class="db-hoso-btn-later" data-bs-dismiss="modal">Để sau</button>
                            <button type="button" class="db-hoso-btn-go" data-goto="#tunhaphoso" data-bs-dismiss="modal">Nhập hồ sơ ngay <i class="fal fa-arrow-right ms-1"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Quick access shortcuts -->
            <div class="db-quick" id="dbQuickAccess">
                <a href="#" class="db-quick-card" data-goto="#dangkyhoc">
                    <div class="db-quick-icon c1"><i class="fal fa-book-reader"></i></div>
                    <div class="db-quick-text">
                        <p class="db-quick-label">Học tập</p>
                        <p class="db-quick-title">Đăng ký học</p>
                    </div>
                </a>
                <a href="#" class="db-quick-card" data-goto="#thoikhoabieu">
                    <div class="db-quick-icon c2"><i class="fal fa-calendar-week"></i></div>
                    <div class="db-quick-text">
                        <p class="db-quick-label">Lịch</p>
                        <p class="db-quick-title">Thời khóa biểu</p>
                    </div>
                </a>
                <a href="#" class="db-quick-card" data-goto="#taichinh">
                    <div class="db-quick-icon c3"><i class="fal fa-wallet"></i></div>
                    <div class="db-quick-text">
                        <p class="db-quick-label">Tài chính</p>
                        <p class="db-quick-title">Học phí</p>
                    </div>
                </a>
                <a href="#" class="db-quick-card" data-goto="#tintuc">
                    <div class="db-quick-icon c4"><i class="fal fa-newspaper"></i></div>
                    <div class="db-quick-text">
                        <p class="db-quick-label">Thông tin</p>
                        <p class="db-quick-title">Tin tức &amp; thông báo</p>
                    </div>
                </a>
            </div>

            <!-- Tin tuc 3 muc + Su kien sap toi -->
            <div class="tintuc-home-wrap" id="zoneTinTucHome"></div>

            <!-- Legacy hidden -->
            <p class="hello-user" style="display:none">Xin chào!</p>
            <div class="dashboad" id="zonedashbroad" style="display:none"></div>
        </div>
        <!-- end content -->
        <div id="alert"></div>
        <!-- copy right -->
        <div class="copyright ">
            <marquee>
                Đơn vị phát triển: Công ty Cổ Phần dịch vụ Công nghệ APIS - Địa chỉ: Tầng 6 Tháp Tây, Tòa nhà Hancorp,
                Số, 72 Trần Đăng Ninh, P, Cầu Giấy, Hà Nội - Điện thoại: 024 3204 5867
            </marquee>
        </div>
        <!-- end copy right -->

    </div>
    <div class="chat-single-group">
        
        <div class="chat-box-group" id="zoneChat">
        </div>
    </div>
</div>
    

</body>
<script src="assets/js/bootstrap.bundle.min.js "></script>
<script src="assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="assets/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="assets/js/select2.min.js"></script>
<script src="assets/js/swiper-bundle.min.js"></script>
<script src="assets/js/slick.js"></script>
<script src="assets/js/tab.js"></script>
<script src="assets/js/crypto-js.js?v=32"></script>
<script src="assets/pagination/jquery.simplePagination.min.js?v=331"></script>
<script src="assets/js/masonry.pkgd.min.js"></script>
<script src="assets/js/custom.js"></script>
<script src="assets/js/cleave.min.js"></script>
    
    <script type="text/javascript" src="Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>    <!--CORE JS-->
    <script type="text/javascript" src="Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
    <script type="text/javascript" src="Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
    <script type="text/javascript" src="Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
    <script type="text/javascript" src="Config.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
    <script src="<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>/Core/uploadfile.js?v=1.0.0.12"></script><!--CORE JS-->
    <script src="<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>/Core/uploadavatar.js?v=1.0.0.12"></script><!--CORE JS-->
    <script async type="text/javascript" src="https://api-apis.com/socket.io/socket.io.js"></script><!--CORE JS-->
    <script src="Scripts/MathJax/es5/tex-mml-chtml.js"></script>
    <%
        if (Apis.CommonV1.Base.AppSetting.GetString("DONVI") == "CMC")
        {
            %>
                <script src="https://cmcu.edu.vn/wp-content/uploads/js-host/chatbot-iu.js"></script>
<script>
    window.Chatbot.init({
        chatflowid: "widget-1768376656952-rrbpia",
        apiHost: "https://api-wa.cmcu.edu.vn",
        provider: "openai-stream"
    });
</script>  
            <%
        }
        %>  
    <script type="text/javascript">
        function getBrowser(){
	var ua = navigator.userAgent, browser;

	// helper functions to deal with common regex
	function getFirstMatch(regex) {
		var match = ua.match(regex);
		return (match && match.length > 1 && match[1]) || '';
	}

	function getSecondMatch(regex) {
		var match = ua.match(regex);
		return (match && match.length > 1 && match[2]) || '';
	}

	// start detecting
	if (/opera|opr/i.test(ua)) {
		browser = {
			name: 'Opera',
			type: 'opera',
			version: getFirstMatch(/version\/(\d+(\.\d+)?)/i) || getFirstMatch(/(?:opera|opr)[\s\/](\d+(\.\d+)?)/i)
		}
	}  else if (/msie|trident/i.test(ua)) {
		browser = {
			name: 'Internet Explorer',
			type: 'msie',
			version: getFirstMatch(/(?:msie |rv:)(\d+(\.\d+)?)/i)
		}
	} else if (/chrome.+? edge/i.test(ua)) {
		browser = {
			name: 'Microsft Edge',
			type: 'msedge',
			version: getFirstMatch(/edge\/(\d+(\.\d+)?)/i)
		}
	} else if (/chrome|crios|crmo/i.test(ua)) {
		browser = {
			name: 'Google Chrome',
			type: 'chrome',
			version: getFirstMatch(/(?:chrome|crios|crmo)\/(\d+(\.\d+)?)/i)
		}
	} else if (/firefox/i.test(ua)) {
		browser = {
			name: 'Firefox',
			type: 'firefox',
			version: getFirstMatch(/(?:firefox)[ \/](\d+(\.\d+)?)/i)
		}
	} else if (!(/like android/i.test(ua)) && /android/i.test(ua)) {
		browser = {
			name: 'Android',
			type: 'android',
			version: getFirstMatch(/version\/(\d+(\.\d+)?)/i)
		}
	} else if (/safari/i.test(ua)) {
		browser = {
			name: 'Safari',
			type: 'safari',
			version: getFirstMatch(/version\/(\d+(\.\d+)?)/i)
		}
	} else {
		browser = {
			name: getFirstMatch(/^(.*)\/(.*) /),
			version: getSecondMatch(/^(.*)\/(.*) /)
		}
		browser.type = browser.name.toLowerCase().replace(/\s/g, '');
	}
	return browser;
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

    <!-- ====== Dashboard styles + logic (inline trong index.aspx) ====== -->
    <style>
        /* Popup canh bao ho so chua hoan thanh */
        .db-hoso-modal {
            border: none; border-radius: 16px; overflow: hidden;
            box-shadow: 0 20px 60px rgba(30, 60, 130, 0.25);
        }
        .db-hoso-modal-body {
            padding: 32px 28px 20px;
            text-align: center;
            background: linear-gradient(180deg, #fff7ed 0%, #fff 60%);
        }
        .db-hoso-modal-ic {
            width: 72px; height: 72px; border-radius: 50%;
            background: linear-gradient(135deg, #f97316, #ea580c);
            color: #fff; font-size: 32px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 18px;
            box-shadow: 0 8px 20px rgba(249, 115, 22, 0.35);
        }
        .db-hoso-modal-title {
            font-size: 18px; font-weight: 700; color: #9a3412;
            margin: 0 0 10px;
        }
        .db-hoso-modal-desc {
            font-size: 14px; color: #52525b; line-height: 1.6;
            margin: 0;
        }
        .db-hoso-modal-footer {
            display: flex; gap: 10px;
            padding: 16px 24px 24px;
            justify-content: center;
        }
        .db-hoso-btn-later {
            padding: 10px 22px; border-radius: 24px;
            border: 1px solid #d4d4d8; background: #fff; color: #52525b;
            font-size: 13.5px; font-weight: 500; cursor: pointer;
            transition: all 0.2s ease;
        }
        .db-hoso-btn-later:hover { background: #f4f4f5; border-color: #a1a1aa; }
        .db-hoso-btn-go {
            padding: 10px 22px; border-radius: 24px; border: none;
            background: linear-gradient(135deg, #f97316, #ea580c); color: #fff;
            font-size: 13.5px; font-weight: 500; cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.3);
            display: inline-flex; align-items: center;
        }
        .db-hoso-btn-go:hover { transform: translateY(-1px); box-shadow: 0 6px 16px rgba(249, 115, 22, 0.4); }
        @media (max-width: 480px) {
            .db-hoso-modal-footer { flex-direction: column; }
            .db-hoso-btn-later, .db-hoso-btn-go { width: 100%; justify-content: center; }
        }

        /* Quick access */
        .db-quick {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 14px;
            margin: 20px 22px 22px;
        }
        @media (max-width: 992px) { .db-quick { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 520px) { .db-quick { grid-template-columns: 1fr; margin: 16px 12px; } }
        .db-quick-card {
            background: #fff; border: 1px solid #e6ebf5; border-radius: 12px;
            padding: 16px 18px; display: flex; align-items: center; gap: 14px;
            cursor: pointer; transition: all 0.2s ease;
            text-decoration: none; color: #212529;
            box-shadow: 0 2px 8px rgba(30, 60, 130, 0.04);
        }
        .db-quick-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(37, 99, 235, 0.12);
            border-color: #c7d8f7; color: #212529; text-decoration: none;
        }
        .db-quick-icon {
            flex-shrink: 0; width: 48px; height: 48px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            color: #fff; font-size: 20px;
        }
        .db-quick-icon.c1 { background: linear-gradient(135deg, #2563eb, #1d4ed8); }
        .db-quick-icon.c2 { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .db-quick-icon.c3 { background: linear-gradient(135deg, #10b981, #059669); }
        .db-quick-icon.c4 { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .db-quick-text { flex: 1; min-width: 0; }
        .db-quick-label { font-size: 12px; color: #8a94a8; margin: 0 0 2px; text-transform: uppercase; letter-spacing: 0.3px; }
        .db-quick-title { font-size: 14.5px; font-weight: 600; color: #1a3b8b; margin: 0; }

        /* Tin tuc 3 muc - layout 2 cot: Tin dao tao (chinh) + Nha truong/Hoat dong SV (phu) */
        .tintuc-home-wrap { padding: 0 22px 24px; max-width: 100%; }
        .tintuc-home-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 18px;
            align-items: start;
        }
        .tintuc-home-side { display: flex; flex-direction: column; gap: 18px; }
        .tintuc-home-side .news-group-title { font-size: 13.5px; }
        .tintuc-home-side .news-group-header { padding: 10px 16px; }
        .tintuc-home-side .news-group-body { padding: 2px 16px; }
        .tintuc-home-side .news-group-item { padding: 8px 0; gap: 10px; }
        .tintuc-home-side .news-group-item-title { font-size: 13.5px; -webkit-line-clamp: 2; line-clamp: 2; }
        .tintuc-home-side .news-group-item-meta { font-size: 11.5px; }
        @media (max-width: 992px) {
            .tintuc-home-grid { grid-template-columns: 1fr; }
        }
        .tintuc-home-wrap .news-group {
            background: #fff; border: 1px solid #e6ebf5; border-radius: 12px;
            box-shadow: 0 2px 10px rgba(30, 60, 130, 0.05);
            margin-bottom: 0px; overflow: hidden;
        }
        .tintuc-home-wrap .news-group-header {
            display: flex; align-items: center; justify-content: space-between;
            padding: 12px 20px;
            background: linear-gradient(90deg, #eff4ff, #f8faff);
            border-bottom: 2px solid #2563eb;
        }
        .tintuc-home-wrap .news-group-title {
            font-size: 15px; font-weight: 700; color: #1a3b8b;
            text-transform: uppercase; letter-spacing: 0.4px;
            display: flex; align-items: center; gap: 8px;
        }
        .tintuc-home-wrap .news-group-title::before {
            content: ''; display: inline-block; width: 4px; height: 18px;
            background: #2563eb; border-radius: 2px;
        }
        .tintuc-home-wrap .news-group-more {
            font-size: 12.5px; font-weight: 500; color: #2563eb;
            padding: 4px 14px; border: 1px solid #c7d8f7; border-radius: 20px;
            cursor: pointer; text-decoration: none; background: #fff;
            transition: all 0.2s ease;
        }
        .tintuc-home-wrap .news-group-more:hover {
            background: #2563eb; color: #fff; border-color: #2563eb;
        }
        .tintuc-home-wrap .news-group-body { padding: 4px 20px; }
        .tintuc-home-wrap .news-group-item {
            display: flex; align-items: flex-start; gap: 12px;
            padding: 10px 0; border-bottom: 1px dashed #eef1f7;
            cursor: pointer; transition: padding-left 0.2s ease;
        }
        .tintuc-home-wrap .news-group-item:last-child { border-bottom: none; }
        .tintuc-home-wrap .news-group-item:hover { padding-left: 4px; }
        .tintuc-home-wrap .news-group-item:hover .news-group-item-title { color: #2563eb; }
        .tintuc-home-wrap .news-group-item-icon {
            flex-shrink: 0; width: 20px; color: #2563eb;
            font-size: 14px; padding-top: 2px; text-align: center;
        }
        .tintuc-home-wrap .news-group-item-content { flex: 1; min-width: 0; }
        .tintuc-home-wrap .news-group-item-title {
            font-size: 14.5px; font-weight: 500; color: #212529;
            line-height: 1.5; margin-bottom: 3px;
            display: -webkit-box; -webkit-line-clamp: 2; line-clamp: 2;
            -webkit-box-orient: vertical; overflow: hidden;
            transition: color 0.15s ease;
        }
        .tintuc-home-wrap .news-group-item-meta {
            display: flex; gap: 14px; font-size: 12.5px; color: #8a94a8;
        }
        .tintuc-home-wrap .news-group-item-meta i { margin-right: 4px; color: #94a3b8; }
        .tintuc-home-wrap .news-group-empty {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            padding: 26px 0; color: #a5adbf; font-size: 13.5px; font-style: italic;
        }
        .tintuc-home-wrap .news-group-empty i { font-size: 22px; color: #cbd3e0; }
    </style>

    <script>
    (function () {
        var _dtTinTuc = [];

        function toAlias(s) {
            s = (s || '').toString().toLowerCase();
            return (window.edu && edu.system && typeof edu.system.change_alias === 'function')
                ? edu.system.change_alias(s) : s;
        }
        function classify(item) {
            // Uu tien 1: CHUYENMUC (ghep ca MA + TEN de bat ca ma tat va ten day du)
            var cmRaw = ((item.CHUYENMUC_MA || '') + ' ' + (item.CHUYENMUC_TEN || '')).trim();
            if (cmRaw) {
                var cm = toAlias(cmRaw);
                if (/hdsv|hoat dong sinh vien|hoat dong sv/.test(cm)) return 'hoatdongsv';
                if (/tdt|tin dao tao|dao tao|khao thi/.test(cm)) return 'daotao';
                if (/ttnt|nha truong|thong bao chung/.test(cm)) return 'nhatruong';
                return 'nhatruong';
            }
            // Fallback: doan theo ten don vi dang tin (tin chua gan chuyen muc)
            var dv = toAlias(item.DAOTAO_COCAUTOCHUC_TEN);
            if (/cthssv|cong tac (hoc sinh )?sinh vien|doan thanh nien|hoi sinh vien|sinh vien/.test(dv)) return 'hoatdongsv';
            if (/dao tao|khao thi/.test(dv)) return 'daotao';
            return 'nhatruong';
        }

        function esc(s) {
            return (s == null ? '' : ('' + s))
                .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        }

        function renderGroup(ten, items, preview) {
            var shown = items.slice(0, preview);
            var html = '<div class="news-group"><div class="news-group-header">';
            html += '<span class="news-group-title">' + ten + '</span>';
            if (items.length > 0) html += '<a href="#" class="news-group-more">Xem tất cả</a>';
            html += '</div><div class="news-group-body">';
            if (!shown.length) {
                html += '<div class="news-group-empty"><i class="fal fa-inbox"></i><span>Chưa có tin nào</span></div>';
            } else {
                shown.forEach(function (e) {
                    var strNgay = (e.NGAYBATDAU || e.NGAYTAO_DD_MM_YYYY || '').toString().trim();
                    html += '<div class="news-group-item bantin-home" data-id="' + esc(e.ID) + '">';
                    html += '<div class="news-group-item-icon"><i class="fas fa-thumbtack"></i></div>';
                    html += '<div class="news-group-item-content">';
                    html += '<div class="news-group-item-title">' + esc(e.TIEUDE) + '</div>';
                    if (strNgay) html += '<div class="news-group-item-meta"><span><i class="fal fa-calendar-alt"></i>' + esc(strNgay) + '</span></div>';
                    html += '</div></div>';
                });
            }
            html += '</div></div>';
            return html;
        }

        function renderBoxes(data) {
            var $host = $('#zoneTinTucHome');
            if (!$host.length) return;
            var groups = { nhatruong: [], daotao: [], hoatdongsv: [] };
            (data || []).forEach(function (e) { groups[classify(e)].push(e); });
            var PREVIEW_MAIN = 10;
            var PREVIEW_SIDE = 5;
            var html = '<div class="tintuc-home-grid">';
            html += '<div class="tintuc-home-main">';
            html += renderGroup('Tin đào tạo', groups.daotao, PREVIEW_MAIN);
            html += '</div>';
            html += '<div class="tintuc-home-side">';
            html += renderGroup('Tin nhà trường', groups.nhatruong, PREVIEW_SIDE);
            html += renderGroup('Hoạt động sinh viên', groups.hoatdongsv, PREVIEW_SIDE);
            html += '</div>';
            html += '</div>';
            $host.html(html);
        }

        function fetchTinTuc() {
            if (!window.edu || !edu.system || !edu.system.makeRequest) return;
            var payload = {
                action: 'TS_TinTuc_MH/DSA4BRIVKC8VNCIeAyAvJhUoLx4PJjQuKAU0LyYP',
                func: 'pkg_tintuc.LayDSTinTuc_BangTin_NguoiDung',
                iM: edu.system.iM,
                strTuKhoa: '', strTuNgay: '', strDenNgay: '',
                strNguoiThucHien_Id: edu.system.userId,
                strChuyenMuc_Id: '',
                strChung_UngDung_Id: edu.system.appId,
                dTinQuanTrong: -1,
                strDaoTao_CoCauToChuc_Id: '',
                dHieuLuc: 1,
                pageIndex: 1, pageSize: 50
            };
            edu.system.makeRequest({
                success: function (data) {
                    if (data && data.Success) {
                        _dtTinTuc = data.Data || [];
                        renderBoxes(_dtTinTuc);
                    }
                },
                error: function () {},
                type: 'POST',
                action: payload.action,
                contentType: true,
                data: payload,
                fakedb: []
            }, false, false, false, null);
        }

        function isFilledVal(v) {
            if (v == null) return false;
            var s = v.toString().trim();
            if (s === '') return false;
            if (s.indexOf('unsave_') !== -1) return false;
            return true;
        }

        function checkHoSoCompletion() {
            var tries = 0;
            var poll = setInterval(function () {
                tries++;
                if (edu.system.dtChucNang && edu.system.dtChucNang.length) {
                    clearInterval(poll);
                    doCheck();
                } else if (tries > 150) {
                    clearInterval(poll);
                }
            }, 100);

            function doCheck() {
                var chucNangTNHS = edu.system.dtChucNang.find(function (e) {
                    var dd = (e.DUONGDANHIENTHI || '').toLowerCase();
                    var ma = (e.MA || '').toUpperCase();
                    return dd === '#tunhaphoso' || ma === 'CSV.TNHS';
                });
                if (!chucNangTNHS) return;
                var strChucNangId = chucNangTNHS.ID;

                var payloadKH = {
                    action: 'SV_KeHoach_MH/DSA4BRIKJAkuICIpDykgMQkuEi4P',
                    func: 'pkg_hososinhvien_kehoach.LayDSKeHoachNhapHoSo',
                    iM: edu.system.iM,
                    strChucNang_Id: strChucNangId,
                    strQLSV_NguoiHoc_Id: edu.system.userId
                };
                edu.system.makeRequest({
                    success: function (data) {
                        if (!data || !data.Success || !data.Data || !data.Data.length) return;
                        fetchTruongThongTin(strChucNangId, data.Data[0].ID);
                    },
                    error: function () {},
                    type: 'POST',
                    action: payloadKH.action,
                    contentType: true,
                    data: payloadKH,
                    fakedb: []
                }, false, false, false, null);
            }
        }

        function fetchTruongThongTin(strChucNangId, strKeHoachId) {
            var payload = {
                action: 'SV_KeHoach_MH/DSA4BRIJLhIuAikuESkkMRIXDykgMQPP',
                func: 'pkg_hososinhvien_kehoach.LayDSHoSoChoPhepSVNhap',
                iM: edu.system.iM,
                strChucNang_Id: strChucNangId,
                strQLSV_KeHoach_NguoiHoc_Id: strKeHoachId,
                strQLSV_NguoiHoc_Id: edu.system.userId,
                strNguoiThucHien_Id: edu.system.userId,
                strHanhDong_Id: ''
            };
            edu.system.makeRequest({
                success: function (data) {
                    if (!data || !data.Success || !data.Data) return;
                    var missing = data.Data.filter(function (e) {
                        if (e.BATBUOC != 1) return false;
                        return !isFilledVal(e.TRUONGTHONGTIN_GIATRI) && !isFilledVal(e.THONGTINXACMINH);
                    });
                    if (missing.length > 0) renderHoSoWarning();
                },
                error: function () {},
                type: 'POST',
                action: payload.action,
                contentType: true,
                data: payload,
                fakedb: []
            }, false, false, false, null);
        }

        function renderHoSoWarning() {
            var el = document.getElementById('dbHoSoWarnModal');
            if (!el || typeof bootstrap === 'undefined' || !bootstrap.Modal) return;
            bootstrap.Modal.getOrCreateInstance(el).show();
        }

        function waitAndInit() {
            renderBoxes([]);
            var tries = 0;
            var timer = setInterval(function () {
                tries++;
                if (window.edu && edu.system && edu.system.userId && edu.system.iM) {
                    clearInterval(timer);
                    fetchTinTuc();
                    checkHoSoCompletion();
                } else if (tries > 100) {
                    clearInterval(timer);
                }
            }, 100);
        }

        // Click tin -> mo chi tiet trong module tin tuc (load chi tiet qua API)
        $(document).on('click', '#zoneTinTucHome .bantin-home', function () {
            var id = $(this).data('id');
            if (!id) return;
            if (!window.main_doc) window.main_doc = {};
            main_doc.DashBoard = { objTinTuc: { ID: id } };
            if (edu && edu.system && edu.system.triggerChucNang_MaHienThi) {
                edu.system.triggerChucNang_MaHienThi('#tintuc');
            }
        });

        $(document).on('click', '#zoneTinTucHome .news-group-more', function (e) {
            e.preventDefault();
            if (edu && edu.system && edu.system.triggerChucNang_MaHienThi) {
                edu.system.triggerChucNang_MaHienThi('#tintuc');
            }
        });

        // Quick access -> navigate to chuc nang
        $(document).on('click', '.db-quick-card, .db-hoso-btn-go', function (e) {
            e.preventDefault();
            var strMa = $(this).data('goto');
            if (strMa && edu && edu.system && edu.system.triggerChucNang_MaHienThi) {
                edu.system.triggerChucNang_MaHienThi(strMa);
            }
        });

        $(document).ready(waitAndInit);
    })();
    </script>
</html>
