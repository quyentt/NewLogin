/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function TheoDoiQuayNhapHoc() { };
TheoDoiQuayNhapHoc.prototype = {
    ilandau: 1,
    arrTimeCallDb: [0],
    swiper: null,
    arrHeadDiem_Id: [],
    dtCauTruc: [],
    dt_HS: [],
    strLoad_Id: 1,
    strKeHoach_Id: '',
    strCaNhapHoc_Id: '',
    strQuayNhapHoc_Id: '',
    iCount: 0,
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "NH";
        me.showDay();
        me.getList_KeHoach();
        //getCauTruc();
        //function getCauTruc() {
        //    me.getList_HSSV();
        //    setTimeout(function () {
        //        getCauTruc();
        //    }, 10000)
        //}
        $('#dropKeHoachNhapHoc').on('change', function () {
            if (edu.util.getValById('dropKeHoachNhapHoc')) me.strKeHoach_Id = edu.util.getValById('dropKeHoachNhapHoc');
            me.getList_CaNhapHoc();
        });

        $('#dropCaNhapHoc').on('change', function () {
            if (edu.util.getValById('dropCaNhapHoc')) me.strCaNhapHoc_Id = edu.util.getValById('dropCaNhapHoc');
            me.getList_QuayNhapHoc();
            //me.getList_HSSV();
        });
        $('#dropQuayNhapHoc').on('change', function () {
            if (edu.util.getValById('dropQuayNhapHoc')) me.strQuayNhapHoc_Id = edu.util.getValById('dropQuayNhapHoc');
            me.getList_HSSV();
            localStorage.setItem("strQuayNhapHoc_Id", me.strQuayNhapHoc_Id);
            
        });
        $("#btnDSHoanThanh").click(function () {
            me.getList_HoanThanh();
        });
        me.checkDevTool();
    },

    showDay: function () {
        var me = this;
        var date = new Date(Date.now());
        //console.log(date)
        var year = date.getFullYear();
        $("#lblNamNhapHoc").html(year);
        var month = edu.util.addZeroToDate(date.getMonth() + 1);
        var day = edu.util.addZeroToDate(date.getDate());
        var hour = edu.util.addZeroToDate(date.getHours());
        var minute = edu.util.addZeroToDate(date.getMinutes());
        var strDay = day + "/" + month + "/" + year;
        //var iThu = date.getDay();
        //iThu = iThu ? "Thứ " + (iThu + 1) : "Chủ nhật";
        $("#lblcurent_time").html(hour + ":" + minute + " " + strDay)
        //if (me.ilandau) {
        //    me.ilandau = 0;
        //    me.getList_LichGiang(strDay)
        //} else { 
        //    //location.reload(); 
        //    //if (date.getMinutes() == 0 && me.arrTimeCallDb.indexOf(date.getHours())) {
        //    //    location.reload(); 
        //    //}

        //}
        setTimeout(function () {
            me.showDay();
        }, 60000);
    },
    
    getList_HSSV: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'NH_QuayNhapHoc/LayDSTienTrinhNhapHocTaiQuay',
            'type': 'GET',
            'strTC_KeHoachNhapHoc_Id': edu.util.getValById('dropKeHoachNhapHoc'),
            'strCaNhapHoc_Id': edu.util.getValById('dropCaNhapHoc'),
            'strQuayNhaphoc_Id': edu.util.getValById('dropQuayNhapHoc'),
            'strNguoiThucHien_Id': edu.system.userId,
        };
        var strLoad = obj_list.strTC_KeHoachNhapHoc_Id + obj_list.strCaNhapHoc_Id

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.dt_HS = data.Data;
                    me.genTable_HSSV(data.Data, data.Pager);
                    setTimeout(function () {
                        me.iCount++;
                        if (me.iCount > 10) location.reload(); 
                        me.getList_KeHoach();
                    }, 30000)
                    
                }
                else {
                    console.log(data.Message);
                }

            },
            error: function (er) { },
            type: "GET",
            action: obj_list.action,

            contentType: true,

            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    genTable_HSSV: function (data, iPager) {
        var me = this;
        var uuid = edu.util.uuid();
        var html = '';
        html +='<div class="theader">';
        html += '<div class="led-table-cell">';
        html += 'STT';
        html += '</div>';
        html += '<div class="led-table-cell">';
        html += 'Họ và tên';
        html += '</div>';
        html += '<div class="led-table-cell">';
        html += 'Tỉnh/Thành phố';
        html += '</div>';
        html += '<div class="led-table-cell">';
        html += 'Số điện thoại';
        html += '</div>';
        html += '<div class="led-table-cell">';
        html += 'Ngày sinh';
        html += '</div>';
        html += '<div class="led-table-cell">';
        html += ' Ngành';
        html += '</div>';
        html += '<div class="led-table-cell">';
        html += 'Bước tiếp theo';
        html += '</div>';
        html += '</div>';
        html += '<div class="swiper mySwiper ' + uuid +'">';
        html += '<div class="swiper-wrapper">';
        data.forEach(aData => {
            html += '<div class="swiper-slide">';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.STT);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.HOVATEN);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.TINH_THANH);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.SODIENTHOAICANHAN);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.NGAYSINH);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.NGANH);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.BUOCTIEPTHEO);
            html += '</div>';
            html += '</div>';
        })
        html += '</div>';
        html += '</div>';
        $("#tblTheoDoiQuayNhapHoc").html(html);
        if (data.length > 15) {
            var swiper = new Swiper(".mySwiper", {
                direction: "vertical",
                pagination: {
                    el: ".swiper-pagination",
                    clickable: true,
                },
                slidesPerView: "auto",
                loop: true,
                speed: 2000,
                autoplay: {
                    delay: 0,
                },
            });
        }
        
        //var jsonForm = {
        //    strTable_Id: "tblTheoDoiQuayNhapHoc",
        //    aaData: data,
        //    colPos: {
        //        center: [0, 1]
        //    },
        //    bHiddenOrder: true,
        //    aoColumns: [
        //        {
        //            "mDataProp": "STT"
        //        },
        //        {
        //            "mDataProp": "HOVATEN"
        //        },
        //        {
        //            "mDataProp": "TINH_THANH",
        //        },
        //        {
        //            "mDataProp": "CCCD_CMT",
        //        },
        //        {
        //            "mDataProp": "NGAYSINH",
        //        },
        //        {
        //            "mDataProp": "NGANH",
        //        },
        //        {
        //            "mDataProp": "BUOCTIEPTHEO",
        //        }
        //    ]
        //};
        //edu.system.loadToTable_data(jsonForm);
        //$("#tblTheoDoiQuayNhapHoc tbody").scrollTop(200);
        //edu.system.insertSumAfterTable(jsonForm.strTable_Id, arrSum)
        /*III. Callback*/
    },


    getList_KeHoach: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'NH_QuayNhapHoc/LayDSKeHoachNhapHocQuay',
            'type': 'GET',
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var json = data.Data;
                    me.cbGenCombo_KeHoach(json);
                } else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert("Lỗi: " + JSON.stringify(er));
            },
            type: "GET",
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    cbGenCombo_KeHoach: function (data) {
        var me = this;
        if (!me.strKeHoach_Id && data.length > 0) {
            me.strKeHoach_Id = data[0].ID;
            //me.getList_KetQuaHocTap();
            //me.getList_TichLuyTheoKhoi();
        }
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "TEN",
                code: "",
                avatar: "",
                default_val: me.strKeHoach_Id
            },
            renderPlace: ["dropKeHoachNhapHoc"],
            type: "",
            title: "Chọn kế hoạch",
        }
        edu.system.loadToCombo_data(obj);
    },
    getList_CaNhapHoc: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'NH_QuayNhapHoc/LayDSCaDangNhapHoc',
            'type': 'GET',
            'strTC_KeHoachNhapHoc_Id': edu.util.getValById('dropKeHoachNhapHoc'),
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var json = data.Data;
                    me.cbGenCombo_CaNhapHoc(json);
                } else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert("Lỗi: " + JSON.stringify(er));
            },
            type: "GET",
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    cbGenCombo_CaNhapHoc: function (data) {
        var me = this;
        if (!me.strCaNhapHoc_Id && data.length > 0) {
            me.strCaNhapHoc_Id=  data[0].ID;
            //me.getList_KetQuaHocTap();
            //me.getList_TichLuyTheoKhoi();
        }
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "TEN",
                code: "",
                avatar: "",
                default_val: me.strCaNhapHoc_Id
            },
            renderPlace: ["dropCaNhapHoc"],
            type: "",
            title: "Chọn ca nhập học",
        }
        edu.system.loadToCombo_data(obj);
        
    },
    getList_QuayNhapHoc: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'NH_QuayNhapHoc/LayDSQuayNhapHoc',
            'type': 'GET',
            'strTC_KeHoachNhapHoc_Id': edu.util.getValById('dropKeHoachNhapHoc'),
            'strCaNhapHoc_Id': edu.util.getValById('dropCaNhapHoc'),
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var json = data.Data;
                    me.cbGenCombo_QuayNhapHoc(json);
                } else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert("Lỗi: " + JSON.stringify(er));
            },
            type: "GET",
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    cbGenCombo_QuayNhapHoc: function (data) {
        var me = this;
        var strQuayNhapHoc_Id = localStorage.getItem("strQuayNhapHoc_Id");
        //if (!me.strQuayNhapHoc_Id && data.length > 0) {
        //    me.strQuayNhapHoc_Id = data[0].ID;
        //    //me.getList_KetQuaHocTap();
        //    //me.getList_TichLuyTheoKhoi();
        //}
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "TEN",
                code: "",
                avatar: "",
                default_val: strQuayNhapHoc_Id
            },
            renderPlace: ["dropQuayNhapHoc"],
            type: "",
            title: "Chọn quầy nhập học",
        }
        edu.system.loadToCombo_data(obj);
        me.getList_HSSV();
    },

    getList_HoanThanh: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'NH_QuayNhapHoc/LayDSThiSinhDaHoanThanhCacQuay',
            'type': 'GET',
            'strTC_KeHoachNhapHoc_Id': edu.util.getValById('dropKeHoachNhapHoc'),
            'strCaNhapHoc_Id': edu.util.getValById('dropCaNhapHoc'),
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.dt_HS = data.Data;
                    me.genTable_HoanThanh(data.Data, data.Pager);
                }
                else {
                    console.log(data.Message);
                }

            },
            error: function (er) { },
            type: "GET",
            action: obj_list.action,

            contentType: true,

            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    genTable_HoanThanh: function (data, iPager) {
        var me = this;

        var jsonForm = {
            strTable_Id: "tblHoanThanh",
            aaData: data,
            colPos: {
                center: [0, 1]
            },
            bHiddenOrder: true,
            aoColumns: [
                {
                    "mDataProp": "STT"
                },
                {
                    "mDataProp": "HOVATEN"
                },
                {
                    "mDataProp": "TINH_THANH",
                },
                {
                    "mDataProp": "SODIENTHOAICANHAN",
                },
                {
                    "mDataProp": "NGAYSINH",
                },
                {
                    "mDataProp": "NGANH",
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<span class="quay-number quay-7">Đã hoàn thành</span>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
        //$("#tblTheoDoiQuayNhapHoc tbody").scrollTop(200);
        //edu.system.insertSumAfterTable(jsonForm.strTable_Id, arrSum)
        /*III. Callback*/
    },

    checkDevTool: function () {
        console.log($("#lockazz").length == 0)
        if ($("#lockazz").length == 0 || localStorage.getItem("iShk") != null) return;
        console.log(111111);
        (function () {
            "use strict";

            var LOGIN_URL = "/congthongtin/login.aspx";              // đổi thành URL trang đăng nhập thực tế
            var CHECK_INTERVAL = 500;                    // ms, tần suất kiểm tra
            var SIZE_THRESHOLD = 160;                    // px, chênh lệch kích thước cửa sổ khi DevTools mở
            var DEV_MODE_KEY = "app_devtools_bypass";    // tên key trong localStorage
            var DEV_MODE_SECRET = "let-me-in-2026";      // giá trị bí mật phải khớp để bật dev mode
            var devtoolsOpen = false;
            var redirecting = false;
            var intervalId = null;

            // Kiểm tra chế độ developer: chỉ bật khi giá trị trong localStorage
            // khớp CHÍNH XÁC với DEV_MODE_SECRET (không chỉ cần tồn tại key)
            function isDevMode() {
                try {
                    return window.localStorage.getItem(DEV_MODE_KEY) === DEV_MODE_SECRET;
                } catch (e) {
                    // một số trình duyệt/chế độ (vd: Safari Private Browsing) có thể
                    // ném lỗi khi truy cập localStorage
                    return false;
                }
            }

            function goToLogin(reason) {
                if (redirecting) return;
                if (isDevMode()) return; // dev mode: bỏ qua, không alert, không redirect
                redirecting = true;

                // "báo ngay" - báo ngay lập tức cho người dùng biết
                alert("Phát hiện DevTools đang mở! Bạn sẽ được chuyển về trang đăng nhập.");

                // "lặp lại quay về trang đăng nhập" - liên tục ép về login
                // dùng replace để người dùng không back lại được trang cũ
                window.location.replace(LOGIN_URL);

                // phòng trường hợp trình duyệt chặn điều hướng (vd: đang debug),
                // cứ vài giây thử điều hướng lại cho đến khi rời khỏi trang
                var forceInterval = setInterval(function () {
                    if (window.location.href.indexOf(LOGIN_URL) === -1) {
                        window.location.replace(LOGIN_URL);
                    } else {
                        clearInterval(forceInterval);
                    }
                }, 1000);
            }

            // Cách 1: so sánh kích thước outer/inner của cửa sổ
            // (bắt được khi DevTools "docked" - dính liền cửa sổ trình duyệt)
            function checkBySize() {
                var widthDiff = window.outerWidth - window.innerWidth;
                var heightDiff = window.outerHeight - window.innerHeight;

                if (widthDiff > SIZE_THRESHOLD || heightDiff > SIZE_THRESHOLD) {
                    if (!devtoolsOpen) {
                        devtoolsOpen = true;
                        goToLogin("size");
                    }
                } else {
                    devtoolsOpen = false;
                }
            }

            // Cách 2: dùng "debugger" statement để đo độ trễ
            // (bắt được cả khi DevTools mở dạng cửa sổ tách rời - "undocked")
            function checkByDebugger() {
                var start = performance.now();
                // eslint-disable-next-line no-debugger
                debugger;
                var end = performance.now();

                if (end - start > 100) {
                    goToLogin("debugger");
                }
            }

            function runChecks() {
                if (isDevMode()) return; // dev mode đang bật -> không kiểm tra gì cả
                checkBySize();
                checkByDebugger();
            }

            function start() {
                if (isDevMode()) {
                    // Thông báo rõ cho dev biết script đang ở chế độ bypass,
                    // tránh nhầm tưởng tính năng bị lỗi/không chạy.
                    console.info(
                        "[devtools-detect] Dev mode đang BẬT (localStorage." +
                        DEV_MODE_KEY +
                        ") - tạm tắt kiểm tra DevTools."
                    );
                }

                // Chạy lặp lại liên tục
                intervalId = setInterval(runChecks, CHECK_INTERVAL);

                // Kiểm tra thêm khi resize cửa sổ (đóng/mở DevTools kiểu docked)
                window.addEventListener("resize", function () {
                    if (!isDevMode()) checkBySize();
                });

                // Theo dõi để log khi dev bật/tắt dev mode ở tab khác (localStorage event)
                window.addEventListener("storage", function (e) {
                    if (e.key === DEV_MODE_KEY) {
                        console.info(
                            "[devtools-detect] Dev mode vừa " +
                            (isDevMode() ? "BẬT" : "TẮT") +
                            " (đổi từ tab khác)."
                        );
                    }
                });
            }

            start();
        })();
    }
}