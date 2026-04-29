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
    <style>
        /* ===== Notification dropdown - inline to guarantee load ===== */
        #fcm-noti-button{position:relative;background:transparent;border:0;padding:0;width:38px;height:38px;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;color:#5b6b8c;transition:background-color .2s ease,color .2s ease}
        #fcm-noti-button:hover,#fcm-noti-button[aria-expanded="true"]{background:rgba(31,95,178,.1);color:#1f5fb2}
        #fcm-noti-button .fa-bell{font-size:18px;line-height:1}
        #fcm-noti-button[aria-expanded="true"] .fa-bell{animation:fcm-bell-shake .5s ease;transform-origin:top center}
        @keyframes fcm-bell-shake{0%,100%{transform:rotate(0)}20%{transform:rotate(-14deg)}40%{transform:rotate(12deg)}60%{transform:rotate(-8deg)}80%{transform:rotate(5deg)}}
        #fcm-noti-badge{font-size:10px!important;height:18px!important;min-width:18px!important;padding:0 5px!important;display:inline-flex;align-items:center;justify-content:center;font-weight:600;border:2px solid #fff;line-height:1;top:4px!important;left:auto!important;right:4px!important;transform:none!important}
        #fcm-noti-badge[style*="display: none"],#fcm-noti-badge[style*="display:none"]{display:none!important}

        .navbar #fcm-noti-menu.dropdown-menu,
        #fcm-noti-menu.dropdown-menu{
            width:380px!important;min-width:380px!important;max-width:92vw!important;
            padding:0!important;margin-top:12px!important;margin:12px 0 0 0!important;
            border:0!important;border-radius:14px!important;background:#fff!important;
            box-shadow:0 18px 48px rgba(15,30,70,.18),0 4px 12px rgba(15,30,70,.08)!important;
            overflow:hidden!important;list-style:none!important;
            top:100%!important;right:0!important;left:auto!important
        }
        #fcm-noti-menu.dropdown-menu.show{animation:fcm-noti-pop .18s ease-out}
        @keyframes fcm-noti-pop{from{opacity:0;transform:translateY(-8px) scale(.98)}to{opacity:1;transform:translateY(0) scale(1)}}
        #fcm-noti-menu.dropdown-menu::before{content:'';position:absolute;top:-6px;right:16px;width:12px;height:12px;background:#1f5fb2;transform:rotate(45deg);border-radius:2px;z-index:1}

        #fcm-noti-menu .fcm-noti-header{display:flex!important;align-items:center!important;justify-content:space-between!important;gap:10px!important;padding:14px 18px!important;background:linear-gradient(135deg,#1f5fb2 0%,#2b7bd9 100%)!important;color:#fff!important;list-style:none!important;margin:0!important;border-radius:14px 14px 0 0}
        #fcm-noti-menu .fcm-noti-header h6{font-size:15px!important;font-weight:600!important;margin:0!important;color:#fff!important;display:inline-flex!important;align-items:center!important;gap:8px!important}
        #fcm-noti-menu .fcm-noti-header h6 i{font-size:16px;color:#fff!important}
        #fcm-noti-menu .fcm-noti-header h6 .fcm-noti-count{background:rgba(255,255,255,.22);color:#fff!important;font-size:11px;font-weight:600;padding:1px 8px;border-radius:999px;min-width:22px;text-align:center}
        #fcm-noti-menu .fcm-noti-mark-read{font-size:12px!important;color:rgba(255,255,255,.95)!important;cursor:pointer;background:rgba(255,255,255,.15)!important;border:0!important;padding:5px 10px!important;border-radius:6px!important;transition:background-color .15s ease;white-space:nowrap;line-height:1}
        #fcm-noti-menu .fcm-noti-mark-read:hover{background:rgba(255,255,255,.28)!important;color:#fff!important}
        #fcm-noti-menu .fcm-noti-mark-read i{margin-right:4px;font-size:11px;color:#fff!important}

        #fcm-noti-menu .fcm-noti-list-wrap{list-style:none!important;margin:0!important;padding:0!important;background:#fff}
        #fcm-noti-menu .fcm-noti-list{list-style:none!important;margin:0!important;padding:0!important;max-height:60vh;overflow-y:auto}
        #fcm-noti-menu .fcm-noti-list::-webkit-scrollbar{width:6px}
        #fcm-noti-menu .fcm-noti-list::-webkit-scrollbar-thumb{background:#d6dce9;border-radius:3px}
        #fcm-noti-menu .fcm-noti-list::-webkit-scrollbar-thumb:hover{background:#a9b3cb}

        #fcm-noti-menu .fcm-noti-item{display:flex!important;gap:12px!important;padding:12px 16px!important;cursor:pointer;border-bottom:1px solid #f0f2f7;transition:background-color .15s ease;list-style:none!important;margin:0!important}
        #fcm-noti-menu .fcm-noti-item:last-child{border-bottom:0}
        #fcm-noti-menu .fcm-noti-item:hover{background:#f4f8ff}
        #fcm-noti-menu .fcm-noti-icon{flex:0 0 38px!important;width:38px!important;height:38px!important;border-radius:50%!important;background:linear-gradient(135deg,#e7efff 0%,#cfe1ff 100%)!important;color:#1f5fb2!important;display:flex!important;align-items:center!important;justify-content:center!important;font-size:16px!important}
        #fcm-noti-menu .fcm-noti-icon i{color:#1f5fb2!important}
        #fcm-noti-menu .fcm-noti-content{flex:1!important;min-width:0!important}
        #fcm-noti-menu .fcm-noti-title{font-size:14px!important;font-weight:600!important;color:#1f2a44!important;margin:0 0 2px!important;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;line-height:1.3!important}
        #fcm-noti-menu .fcm-noti-text{font-size:13px!important;color:#5b6b8c!important;margin:0 0 4px!important;line-height:1.4!important;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;word-break:break-word}
        #fcm-noti-menu .fcm-noti-time{font-size:11px!important;color:#8a96b3!important;display:inline-flex!important;align-items:center;gap:4px}
        #fcm-noti-menu .fcm-noti-time i{font-size:10px;color:#8a96b3!important}

        #fcm-noti-menu .fcm-noti-empty{list-style:none!important;display:flex!important;flex-direction:column!important;align-items:center!important;justify-content:center!important;padding:44px 20px!important;color:#8a96b3!important;text-align:center!important;margin:0!important}
        #fcm-noti-menu .fcm-noti-empty .fcm-noti-empty-icon{width:64px!important;height:64px!important;border-radius:50%!important;background:#f3f5fb!important;color:#b8c2d9!important;display:flex!important;align-items:center!important;justify-content:center!important;font-size:26px!important;margin-bottom:12px!important}
        #fcm-noti-menu .fcm-noti-empty .fcm-noti-empty-icon i{color:#b8c2d9!important}
        #fcm-noti-menu .fcm-noti-empty p{font-size:13px!important;margin:0!important;color:#6b7693!important;font-weight:500}
        #fcm-noti-menu .fcm-noti-empty span{font-size:12px!important;color:#a3acc4!important;margin-top:4px!important}

        @media (max-width:576px){
            .navbar #fcm-noti-menu.dropdown-menu,
            #fcm-noti-menu.dropdown-menu{position:fixed!important;top:60px!important;left:8px!important;right:8px!important;bottom:auto!important;width:auto!important;min-width:0!important;max-width:none!important;margin:0!important;transform:none!important;inset:60px 8px auto 8px!important}
            #fcm-noti-menu.dropdown-menu::before{right:56px}
            #fcm-noti-menu .fcm-noti-list{max-height:70vh}
            #fcm-noti-menu .fcm-noti-header{padding:12px 14px!important}
            #fcm-noti-menu .fcm-noti-item{padding:12px 14px!important}
        }

        /* ===== Search-as-navigation suggest dropdown ===== */
        .search-group{ position: relative; }
        .search-suggest{
            position: absolute;
            top: calc(100% + 6px);
            left: 0; right: 0;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 18px 48px rgba(15,30,70,.18), 0 4px 12px rgba(15,30,70,.08);
            max-height: 60vh;
            overflow-y: auto;
            z-index: 10000;
            padding: 6px 0;
            display: none;
        }
        .search-suggest.show{ display: block; animation: search-pop .15s ease-out; }
        @keyframes search-pop{ from{opacity:0;transform:translateY(-6px)} to{opacity:1;transform:translateY(0)} }
        .search-suggest-empty{ padding: 22px 16px; text-align: center; color: #8a96b3; font-size: 13px; }
        .search-suggest-item{
            display: flex; align-items: center; gap: 12px;
            padding: 10px 14px; cursor: pointer;
            color: #1f2a44; font-size: 13px;
            transition: background-color .12s ease, transform .12s ease;
            position: relative;
        }
        .search-suggest-item::before{
            content: ''; position: absolute; left: 0; top: 8px; bottom: 8px;
            width: 3px; border-radius: 0 3px 3px 0;
            background: var(--ss-accent, #1f5fb2); opacity: 0;
            transition: opacity .15s ease;
        }
        .search-suggest-item:hover,
        .search-suggest-item.active{ background: #f4f8ff; }
        .search-suggest-item.active::before{ opacity: 1; }
        .search-suggest-item.active .ss-icon{
            box-shadow: 0 6px 14px rgba(15,30,70,.18), 0 0 0 3px rgba(255,255,255,.95) inset;
            transform: scale(1.04);
        }
        .search-suggest-item .ss-icon{
            flex: 0 0 36px; width: 36px; height: 36px;
            border-radius: 11px;
            background: var(--ss-grad, linear-gradient(135deg,#1f5fb2 0%,#4f8be0 100%));
            color: #fff;
            display: inline-flex;
            align-items: center; justify-content: center;
            font-size: 15px; line-height: 1;
            box-shadow: 0 4px 10px rgba(15,30,70,.14), inset 0 1px 0 rgba(255,255,255,.25);
            transition: transform .15s ease, box-shadow .15s ease;
            position: relative;
            overflow: hidden;
        }
        .search-suggest-item .ss-icon::after{
            content: ''; position: absolute; inset: 0;
            background: linear-gradient(180deg, rgba(255,255,255,.18) 0%, rgba(255,255,255,0) 55%);
            pointer-events: none;
        }
        .search-suggest-item .ss-icon i,
        .search-suggest-item .ss-icon i.item-icon{
            position: relative; z-index: 1;
            width: auto!important;
            margin: 0!important;
            padding: 0!important;
            font-size: 16px!important;
            line-height: 1!important;
            text-align: center!important;
            display: inline-block;
            color: #fff!important;
            filter: drop-shadow(0 1px 1px rgba(0,0,0,.18));
        }
        .search-suggest-item .ss-icon i.item-icon::before,
        .search-suggest-item .ss-icon i::before{
            color: #fff!important;
        }
        .search-suggest-item:hover .ss-icon{ transform: scale(1.04); }
        .search-suggest-item .ss-text{
            flex: 1; min-width: 0;
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
            font-weight: 500;
        }
        .search-suggest-item .ss-parent{
            font-size: 11px; color: #8a96b3; margin-left: 6px;
            font-weight: 400;
        }
        .search-suggest-item .ss-arrow{
            flex: 0 0 auto; color: #c2cae0; font-size: 12px;
            opacity: 0; transform: translateX(-4px);
            transition: opacity .15s ease, transform .15s ease;
        }
        .search-suggest-item.active .ss-arrow,
        .search-suggest-item:hover .ss-arrow{
            opacity: 1; transform: translateX(0); color: var(--ss-accent, #1f5fb2);
        }
        .search-suggest-item mark{
            background: #fff3a8; color: inherit; padding: 0 1px; border-radius: 2px;
        }

        /* Color palette — rotate per parent menu group */
        .ss-c0{ --ss-accent:#1f5fb2; --ss-grad: linear-gradient(135deg,#1f5fb2 0%,#4f8be0 100%); }
        .ss-c1{ --ss-accent:#0e9f6e; --ss-grad: linear-gradient(135deg,#0e9f6e 0%,#34d399 100%); }
        .ss-c2{ --ss-accent:#e85d04; --ss-grad: linear-gradient(135deg,#e85d04 0%,#fb923c 100%); }
        .ss-c3{ --ss-accent:#9333ea; --ss-grad: linear-gradient(135deg,#9333ea 0%,#c084fc 100%); }
        .ss-c4{ --ss-accent:#db2777; --ss-grad: linear-gradient(135deg,#db2777 0%,#f472b6 100%); }
        .ss-c5{ --ss-accent:#0891b2; --ss-grad: linear-gradient(135deg,#0891b2 0%,#22d3ee 100%); }
        .ss-c6{ --ss-accent:#ca8a04; --ss-grad: linear-gradient(135deg,#ca8a04 0%,#fbbf24 100%); }
        .ss-c7{ --ss-accent:#475569; --ss-grad: linear-gradient(135deg,#475569 0%,#94a3b8 100%); }
        .search-suggest::-webkit-scrollbar{ width: 6px; }
        .search-suggest::-webkit-scrollbar-thumb{ background: #d6dce9; border-radius: 3px; }
        @media (max-width: 768px){
            .search-suggest{
                position: fixed!important;
                top: 96px; left: 8px; right: 8px;
                max-height: calc(100vh - 110px);
            }
        }

        /* ===== Mobile header (top bar) responsive fix ===== */
        @media (max-width: 768px){
            /* Promote navbar to a real fixed top bar */
            .content-page > .navbar{
                position: fixed!important;
                top: 0; left: 0; right: 0;
                width: 100%!important;
                height: 56px!important;
                background-color: #061b5b;
                z-index: 9990;
                display: flex!important;
                align-items: center!important;
                padding: 0 10px 0 52px;
                box-shadow: 0 2px 8px rgba(0,0,0,.15);
            }

            /* Cancel the old "bottom toolbar" rule and let children flow inline */
            .navbar .in-mobi-group{
                position: static!important;
                display: flex!important;
                align-items: center!important;
                width: auto!important;
                height: auto!important;
                bottom: auto!important;
                left: auto!important;
                right: auto!important;
                margin: 0!important;
                padding: 0!important;
                background: transparent!important;
                box-shadow: none!important;
                gap: 4px;
            }
            .navbar .search-group-in-mobi{
                position: static!important;
                display: flex!important;
                align-items: center!important;
                width: auto!important;
                padding: 0!important;
                margin-left: auto!important;
                margin-right: 4px!important;
            }

            /* Hamburger pinned to the left of the navbar */
            .menu-icon-mobi{
                position: fixed!important;
                top: 14px!important;
                left: 14px!important;
                margin: 0!important;
                z-index: 9991;
                font-size: 22px;
                color: #fff;
                line-height: 1;
            }
            .menu-icon-mobi i{ color:#fff; }

            /* Compact logo: only the round emblem, no wide university text */
            .left-sidebar .logo-single{
                position: fixed;
                top: 0; left: 46px;
                height: 56px;
                z-index: 9991;
                display: flex;
                align-items: center;
            }
            .left-sidebar .logo-single img,
            .small-sidebar .logo-single img{
                position: static!important;
                top: auto!important;
                left: auto!important;
                bottom: auto!important;
                height: 38px!important;
                width: 38px!important;
                max-width: 38px!important;
                object-fit: cover;
                object-position: left center;
                border-radius: 50%;
                background: #fff;
            }

            /* Search: icon-only by default, expands when toggled .show */
            .navbar .mobi-search-icon{
                display: inline-flex!important;
                align-items: center;
                justify-content: center;
                width: 36px; height: 36px;
                margin: 0!important;
                padding: 0!important;
                font-size: 18px!important;
                line-height: 1!important;
                color: #fff!important;
                cursor: pointer;
                border-radius: 50%;
                vertical-align: middle;
            }
            .navbar .mobi-search-icon:hover{ background: rgba(255,255,255,.12); }
            .navbar .search-group{
                display: none!important;
            }
            .navbar .search-group.show{
                display: flex!important;
                position: fixed!important;
                top: 56px; left: 0; right: 0;
                width: 100%!important;
                margin: 0!important;
                padding: 8px 12px;
                background: #061b5b;
                z-index: 9989;
                visibility: visible!important;
                box-shadow: 0 2px 6px rgba(0,0,0,.15);
            }
            .navbar .search-group.show .search-form{
                width: 100%;
                height: 38px;
                background-color: rgba(255,255,255,.12);
                color: #fff;
                padding-left: 16px;
                padding-right: 42px;
                line-height: 38px;
            }
            .navbar .search-group.show button{
                position: absolute!important;
                top: 50%!important;
                right: 16px!important;
                transform: translateY(-50%)!important;
                margin: 0!important;
                padding: 0!important;
                width: 28px; height: 28px;
                display: inline-flex!important;
                align-items: center!important;
                justify-content: center!important;
                font-size: 15px!important;
                line-height: 1!important;
                color: #cdd7f0!important;
                background: transparent!important;
                border: 0!important;
            }
            .navbar .search-group.show button i{
                line-height: 1; display: block;
            }

            /* Bell button — keep visual, force white icon on dark bar */
            .navbar #fcm-noti-button{
                width: 36px!important; height: 36px!important;
                margin: 0!important; padding: 0!important;
                color: #fff!important;
                display: inline-flex!important;
                align-items: center!important;
                justify-content: center!important;
                vertical-align: middle;
            }
            .navbar #fcm-noti-button:hover,
            .navbar #fcm-noti-button[aria-expanded="true"]{
                background: rgba(255,255,255,.12)!important;
                color: #fff!important;
            }
            .navbar #fcm-noti-button .fa-bell{ font-size: 18px; line-height:1; color:#fff; }
            #fcm-noti-badge{ border-color:#061b5b!important; top: 2px!important; right: 2px!important; }

            /* User dropdown — avatar only, hide name + chevron */
            .navbar .nav-account{
                margin: 0!important;
                display: inline-flex!important;
                align-items: center!important;
            }
            .navbar .nav-account .dropdown{
                display: inline-flex!important;
                align-items: center!important;
            }
            .navbar .nav-account button{
                width: 36px!important; height: 36px!important;
                margin: 0!important; padding: 0!important;
                display: inline-flex!important;
                align-items: center!important;
                justify-content: center!important;
                color: #fff!important;
                background: transparent!important;
                border: 0!important;
                line-height: 1!important;
                vertical-align: middle;
            }
            .navbar .nav-account button > span,
            .navbar .nav-account .user-arrow{
                display: none!important;
            }
            .navbar .nav-account .user-image{
                width: 32px!important; height: 32px!important;
                margin: 0!important;
                padding: 0!important;
                border-radius: 50%;
                background: #fff;
                box-shadow: 0 0 0 2px rgba(255,255,255,.85), 0 1px 3px rgba(0,0,0,.25);
                overflow: hidden;
                display: inline-flex!important;
                align-items: center!important;
                justify-content: center!important;
            }
            .navbar .nav-account .user-image img,
            .navbar .nav-account .user-image #imgavatar{
                width: 100%!important;
                height: 100%!important;
                object-fit: cover;
                border-radius: 50%;
                display: block;
            }

            /* Push page content below the fixed navbar */
            .content-page .content{
                margin-top: 56px;
                height: calc(100vh - 56px)!important;
            }
        }

        /* Extra-small phones: tighten spacing further */
        @media (max-width: 380px){
            .content-page > .navbar{ padding: 0 6px 0 46px; }
            .left-sidebar .logo-single{ left: 42px; }
            .menu-icon-mobi{ left: 10px!important; }
            .navbar #fcm-noti-button,
            .navbar .mobi-search-icon{ width: 32px!important; height: 32px!important; }
            .navbar .nav-account .user-image{ width: 30px!important; height: 30px!important; }
        }
    </style>
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
                <form class="search-group" id="globalSearchForm" autocomplete="off" onsubmit="return false;">
                    <input type="text" id="globalSearchInput" class="search-form" placeholder="Tìm kiếm chức năng..." autocomplete="off">
                    <button type="button"><i class="fal fa-search"></i></button>
                    <div class="search-suggest" id="globalSearchSuggest" role="listbox"></div>
                </form>
            </div>
            <div class="in-mobi-group">
                <div class="nav-account">
                    <div class="dropdown">
                        <button id="fcm-noti-button" type="button" data-bs-toggle="dropdown" aria-expanded="false" class="position-relative">
                            <i class="fal fa-bell"></i>
                            <span id="fcm-noti-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="display:none">0</span>
                        </button>

                        <ul id="fcm-noti-menu" class="dropdown-menu dropdown-menu-end">
                        </ul>
                    </div>
                </div>
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
            <p class="hello-user" id="helloUser">Xin chào!</p>
            <script>
                (function () {
                    var strTen = "<%=fullname %>";
                    var iGio = parseInt(new Date().toLocaleString('en-US', { timeZone: 'Asia/Ho_Chi_Minh', hour: '2-digit', hour12: false }), 10);
                    var strChao = (iGio >= 5 && iGio < 11) ? 'Chào buổi sáng'
                                : (iGio >= 11 && iGio < 13) ? 'Chào buổi trưa'
                                : (iGio >= 13 && iGio < 18) ? 'Chào buổi chiều'
                                : (iGio >= 18 && iGio < 22) ? 'Chào buổi tối'
                                : 'Chào buổi đêm';
                    var el = document.getElementById('helloUser');
                    if (el) el.textContent = strTen ? (strChao + ', ' + strTen + '!') : (strChao + '!');
                })();
            </script>
            <!-- dashboad -->
            <div class="dashboad" id="zonedashbroad">

            </div>
            <!-- end dashboad -->
            <!-- lich hom nay -->
            <div id="zoneLichHomNay" style="background:#fff;border-radius:14px;padding:16px 20px;margin:0 16px 20px;box-shadow:0 4px 14px rgba(15,30,70,.06);"></div>
            <!-- end lich hom nay -->
            <script>
                (function () {
                    var iAttempt = 0;
                    var iv = setInterval(function () {
                        iAttempt++;
                        if (window.edu && edu.system && edu.system.userId && edu.system.iM != null && typeof edu.system.makeRequest === 'function') {
                            clearInterval(iv);
                            fetchLichHomNay();
                        } else if (iAttempt > 60) {
                            clearInterval(iv);
                        }
                    }, 250);

                    function fetchLichHomNay() {
                        var oNow = new Date();
                        var pad = function (n) { n = '' + n; return n.length === 1 ? '0' + n : n; };
                        var strNgay = pad(oNow.getDate()) + '/' + pad(oNow.getMonth() + 1) + '/' + oNow.getFullYear();
                        var arrThu = ['Chủ nhật','Thứ Hai','Thứ Ba','Thứ Tư','Thứ Năm','Thứ Sáu','Thứ Bảy'];
                        var strThu = arrThu[oNow.getDay()];
                        var dtHoc = null, dtThi = null;
                        var tryRender = function () { if (dtHoc !== null && dtThi !== null) renderLichHomNay(dtHoc, dtThi, strThu, strNgay); };

                        var oH = { action:'SV_ThongTin_MH/DSA4BRINKCIpAiAPKSAv', func:'pkg_congthongtin_hssv_thongtin.LayDSLichCaNhan', iM: edu.system.iM, strQLSV_NguoiHoc_Id: edu.system.userId, strNgayBatDau: strNgay, strNgayKetThuc: strNgay };
                        edu.system.makeRequest({
                            success: function (d) { dtHoc = (d && d.Success && d.Data) ? d.Data : []; tryRender(); },
                            error:   function ()  { dtHoc = []; tryRender(); },
                            type: 'POST', action: oH.action, contentType: true, data: oH, fakedb: []
                        }, false, false, false, null);

                        var oT = { action:'SV_ThongTin_MH/DSA4FRUNKCIpFSko', func:'pkg_congthongtin_hssv_thongtin.LayTTLichThi', iM: edu.system.iM, strQLSV_NguoiHoc_Id: edu.system.userId, strNgayDangChon: strNgay };
                        edu.system.makeRequest({
                            success: function (d) { dtThi = (d && d.Success && d.Data) ? d.Data : []; tryRender(); },
                            error:   function ()  { dtThi = []; tryRender(); },
                            type: 'POST', action: oT.action, contentType: true, data: oT, fakedb: []
                        }, false, false, false, null);
                    }

                    function renderLichHomNay(dtHoc, dtThi, strThu, strNgay) {
                        var pad = function (n) { n = '' + (n || 0); return n.length === 1 ? '0' + n : n; };
                        var safe = function (s) { return $('<div/>').text(s == null ? '' : s).html(); };
                        var html = '';
                        html += '<div style="display:flex;align-items:center;gap:10px;margin-bottom:12px;">';
                        html += '<i class="fal fa-calendar-day" style="color:#1f5fb2;font-size:18px;"></i>';
                        html += '<span style="font-weight:600;font-size:15px;color:#1f2a44;">Hôm nay — ' + safe(strThu) + ', ' + safe(strNgay) + '</span>';
                        html += '</div>';

                        var bH = dtHoc && dtHoc.length, bT = dtThi && dtThi.length;
                        if (!bH && !bT) {
                            html += '<div style="padding:14px 16px;line-height:1.7;color:#4a5568;background:linear-gradient(135deg,#f0f7ff 0%,#fff5f0 100%);border-radius:10px;font-size:14px;">';
                            html += '<i class="fal fa-mug-hot" style="color:#e85d04;margin-right:6px;"></i>';
                            html += '<span style="font-style:italic;">Hôm nay là một ngày bình yên — không có lịch học, cũng chẳng có lịch thi. ';
                            html += 'Bạn hãy tận hưởng quãng nghỉ này thật trọn vẹn: ôn lại bài cũ, đọc thêm một chương sách yêu thích, ';
                            html += 'hay đơn giản là hít thở thật sâu và mỉm cười với chính mình. ';
                            html += 'Mỗi ngày dành ra một chút cho việc học — dù chỉ là một trang sách — đều là bước chân vững chãi đưa bạn ';
                            html += 'đến gần hơn với phiên bản tốt nhất của mình. Cố lên nhé!</span>';
                            html += '</div>';
                        } else {
                            if (bH) {
                                html += '<div style="font-weight:600;color:#1f5fb2;margin:6px 0 8px;font-size:14px;"><i class="fal fa-book-open" style="margin-right:6px;"></i>Lịch học (' + dtHoc.length + ')</div>';
                                dtHoc.forEach(function (e) {
                                    var strGio = pad(e.GIOBATDAU) + ':' + pad(e.PHUTBATDAU) + ' - ' + pad(e.GIOKETTHUC) + ':' + pad(e.PHUTKETTHUC);
                                    var strTiet = (e.TIETBATDAU && e.TIETKETTHUC) ? ' · Tiết ' + e.TIETBATDAU + '–' + e.TIETKETTHUC : '';
                                    html += '<div style="padding:10px 14px;margin:6px 0;background:#eef4ff;border-left:3px solid #1f5fb2;border-radius:6px;">';
                                    html += '<div style="font-weight:600;color:#1f2a44;font-size:14px;">' + safe(e.TENHOCPHAN) + '</div>';
                                    html += '<div style="color:#5b6b8c;font-size:13px;margin-top:2px;">' + safe(strGio + strTiet);
                                    if (e.PHONGHOC_TEN) html += ' · Phòng ' + safe(e.PHONGHOC_TEN);
                                    html += '</div></div>';
                                });
                            }
                            if (bT) {
                                html += '<div style="font-weight:600;color:#e85d04;margin:' + (bH ? '14' : '6') + 'px 0 8px;font-size:14px;"><i class="fal fa-pen-alt" style="margin-right:6px;"></i>Lịch thi (' + dtThi.length + ')</div>';
                                dtThi.forEach(function (e) {
                                    var strGio = pad(e.GIOBATDAU) + ':' + pad(e.PHUTBATDAU) + ' - ' + pad(e.GIOKETTHUC) + ':' + pad(e.PHUTKETTHUC);
                                    html += '<div style="padding:10px 14px;margin:6px 0;background:#fff3e6;border-left:3px solid #e85d04;border-radius:6px;">';
                                    html += '<div style="font-weight:600;color:#1f2a44;font-size:14px;">' + safe(e.DANGKY_LOPHOCPHAN_TEN) + '</div>';
                                    html += '<div style="color:#5b6b8c;font-size:13px;margin-top:2px;">' + safe(strGio);
                                    if (e.PHONGTHI) html += ' · Phòng ' + safe(e.PHONGTHI);
                                    html += '</div></div>';
                                });
                            }
                        }
                        $('#zoneLichHomNay').html(html);
                    }
                })();
            </script>
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
    <script src='<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>/Core/uploadfile.js?v=1.0.0.12'></script><!--CORE JS-->
    <script src='<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>/Core/uploadavatar.js?v=1.0.0.12'></script><!--CORE JS-->
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
            
        window.edu = window.edu || {};
        var edu = window.edu;
        edu['system']   = new systemroot();
        edu['extend']   = new systemextend();
        edu['constant'] = new constant();
        edu['util']     = new util();
        $(document).ready(function () {
            edu.system.startApp();
            edu.extend.init();
            edu.constant.init();

            try {
                if (edu.fcm && typeof edu.fcm.init === 'function') {
                    edu.fcm.init();
                }
            } catch (eFcmInit) {
            }

            try { initGlobalSearch(); } catch (eGs) { console.warn('initGlobalSearch failed', eGs); }
        });

        /* ===== Global feature search (command-palette style) ===== */
        function initGlobalSearch(){
            var $input  = $('#globalSearchInput');
            var $box    = $('#globalSearchSuggest');
            var $form   = $('#globalSearchForm');
            if (!$input.length || !$box.length) return;

            function stripDiacritics(s){
                return (s || '').toString()
                    .normalize('NFD').replace(/[̀-ͯ]/g, '')
                    .replace(/đ/g, 'd').replace(/Đ/g, 'D')
                    .toLowerCase().trim();
            }

            // Build (or rebuild) the index from the rendered sidebar.
            function buildIndex(){
                var items = [];
                var colorIdx = 0;
                $('#sidebar-menu .sidebar-menu-item').each(function(){
                    var $parent = $(this);
                    var $head   = $parent.children('.sidebar-menu-header').first();
                    if (!$head.length) return;

                    var pTitle = $.trim($head.find('> span').first().text() || $head.text());
                    var pIconRaw = $head.find('> i.item-icon').attr('class') || 'fal fa-circle';
                    var pIcon  = pIconRaw.replace(/\bitem-icon\b/g, '').replace(/\s+/g, ' ').trim() || 'fal fa-circle';
                    var color  = 'ss-c' + (colorIdx++ % 8);

                    if (pTitle) {
                        items.push({
                            title: pTitle, parent: '', icon: pIcon, color: color,
                            $el: $head, key: stripDiacritics(pTitle)
                        });
                    }

                    $parent.find('.sidebar-menu-sub > a').each(function(){
                        var $a = $(this);
                        var t = $.trim($a.text());
                        if (!t) return;
                        items.push({
                            title: t, parent: pTitle, icon: pIcon, color: color,
                            $el: $a, key: stripDiacritics(t + ' ' + pTitle)
                        });
                    });
                });
                return items;
            }

            var index = [];
            function refreshIndex(){ index = buildIndex(); }

            // The sidebar renders async; rebuild on focus + a few timed retries.
            refreshIndex();
            [400, 1200, 2500, 5000].forEach(function(ms){ setTimeout(refreshIndex, ms); });

            function highlight(text, q){
                if (!q) return $('<span/>').text(text).html();
                var keyText = stripDiacritics(text);
                var i = keyText.indexOf(q);
                if (i < 0) return $('<span/>').text(text).html();
                var safe = function(s){ return $('<span/>').text(s).html(); };
                return safe(text.substr(0, i)) + '<mark>' + safe(text.substr(i, q.length)) + '</mark>' + safe(text.substr(i + q.length));
            }

            var activeIdx = -1;
            var lastResults = [];

            function render(q){
                if (!index.length) refreshIndex();
                var key = stripDiacritics(q);
                if (!key){
                    $box.removeClass('show').empty();
                    activeIdx = -1; lastResults = [];
                    return;
                }
                var matches = index.filter(function(it){ return it.key.indexOf(key) >= 0; }).slice(0, 12);
                lastResults = matches;
                activeIdx = matches.length ? 0 : -1;

                if (!matches.length){
                    $box.html('<div class="search-suggest-empty">Không tìm thấy chức năng phù hợp</div>').addClass('show');
                    return;
                }
                var html = matches.map(function(it, i){
                    return '<div class="search-suggest-item' + (i === 0 ? ' active' : '') + '" data-i="' + i + '">'
                        +     '<span class="ss-icon"><i class="' + it.icon + '"></i></span>'
                        +     '<span class="ss-text">' + highlight(it.title, key)
                        +         (it.parent ? '<span class="ss-parent">— ' + $('<span/>').text(it.parent).html() + '</span>' : '')
                        +     '</span>'
                        + '</div>';
                }).join('');
                $box.html(html).addClass('show');
            }

            function go(i){
                var it = lastResults[i];
                if (!it || !it.$el || !it.$el.length) return;
                $box.removeClass('show').empty();
                $input.val('').blur();
                $('.search-group').removeClass('show'); // close mobile expanded search
                // Trigger the same handler the sidebar uses (initMain via inline onclick).
                it.$el[0].click();
            }

            $input.on('input focus', function(){ render($(this).val()); });
            $input.on('keydown', function(e){
                if (!$box.hasClass('show')) return;
                var max = lastResults.length;
                if (e.key === 'ArrowDown'){ e.preventDefault(); if (max){ activeIdx = (activeIdx + 1) % max; updateActive(); } }
                else if (e.key === 'ArrowUp'){ e.preventDefault(); if (max){ activeIdx = (activeIdx - 1 + max) % max; updateActive(); } }
                else if (e.key === 'Enter'){ e.preventDefault(); if (activeIdx >= 0) go(activeIdx); }
                else if (e.key === 'Escape'){ $box.removeClass('show'); }
            });
            function updateActive(){
                $box.find('.search-suggest-item').removeClass('active')
                    .filter('[data-i="' + activeIdx + '"]').addClass('active')[0]
                    && $box.find('[data-i="' + activeIdx + '"]')[0].scrollIntoView({block:'nearest'});
            }
            $box.on('mousedown', '.search-suggest-item', function(e){
                e.preventDefault(); // keep input focus until we navigate
                go(parseInt($(this).attr('data-i'), 10));
            });

            $(document).on('click', function(e){
                if (!$(e.target).closest('#globalSearchForm').length) $box.removeClass('show');
            });

            $form.on('submit', function(e){ e.preventDefault(); if (activeIdx >= 0) go(activeIdx); });
        }
    </script>

    <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging-compat.js"></script>
    <script type="text/javascript">
        // Firebase Console -> Project Settings -> Cloud Messaging -> Web Push certificates -> Public key
        // If this is empty, fcm-notify.js will warn and skip token generation.
        window.FCM_VAPID_KEY = 'BAaMGqYzL8EbC8cBXgEPwzgTwtF-4fTJ2x7XyusAxZuEyrCGKpIuij6VanSwjLQWRetpgpM32y98zlUZo-ZVuEE';
    </script>
    <script src="assets/js/fcm-notify.js?v=<%= Guid.NewGuid().ToString() %>"></script>
</html>
