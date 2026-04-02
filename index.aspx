<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Apis.NewLogin.Index" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="assets/css/styles.css?v=<%= Guid.NewGuid().ToString() %>">
    <link href="assets/select2/css/select2.min.css" rel="stylesheet" />
    <link href="assets/pagination/simplePagination.min.css" rel="stylesheet" />
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.ico" />
</head>

<body>
<div class="wrapper">
    <div id="overlay" style="position:fixed; z-index:2051; width: 100%; height: 100%; display:none">
        <i style="color:#00a65a; margin-top:150px; margin-left:50%; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
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
                <img src="logo.png" alt="">
            </div>
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
            <p class="hello-user">Xin chào!</p>
            <!-- dashboad -->
            <div class="dashboad" id="zonedashbroad">

            </div>
            <!-- end dashboad -->
                <!-- end dashboad -->
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
</html>
