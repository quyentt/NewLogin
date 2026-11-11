/*----------------------------------------------
--Tra cứu & xác thực văn bằng (không hiển thị ảnh văn bằng)
--  xacthucvanbang.aspx          : form tra cứu, bấm Chi tiết để xem thông tin
--  xacthucvanbang.aspx?m=<mã>   : quét QR trên bằng, hiển thị thẳng thông tin
----------------------------------------------*/
function xacthucvanbang() { };

xacthucvanbang.prototype = {
    strMa: '',
    dtKetQuaTimKiem: [],
    arrCotAn: [],

    init: function () {
        var me = this;
        // Dựng khối thông tin từ mẫu cho 2 vị trí: chế độ QR và modal chi tiết
        var tpl = document.getElementById("tplThongTin");
        $("#xtQRInfo, #xtModalInfo").each(function () {
            this.appendChild(document.importNode(tpl.content, true));
        });

        var urlParams = new URLSearchParams(window.location.search);
        me.strMa = $.trim(urlParams.get('m') || "");
        if (me.strMa != "") {
            $("#xtQR").show();
            me.get_ThongTinVanBangQR();
        }
        else {
            $("#xtSearch").show();
            me.init_TraCuu();
        }
    },

    /*==================== CHẾ ĐỘ QUÉT QR ====================*/
    get_ThongTinVanBangQR: function () {
        var me = this;
        me.call_API({ 'strTN_KetQua_CongNhan_VB_Id': me.strMa },
            function (data) {
                var arr = data || [];
                // Chỉ chấp nhận khi xác định được đúng 1 văn bằng (ưu tiên bản ghi trùng mã)
                if (arr.length > 1) {
                    arr = arr.filter(function (x) { return edu.util.returnEmpty(x.ID).toUpperCase() == me.strMa.toUpperCase(); });
                }
                if (arr.length == 1) {
                    me.render_ThongTin($("#xtQRInfo"), arr[0]);
                    var d = new Date();
                    var p = function (n) { return ("0" + n).slice(-2); };
                    $("#xtThoiGian").text(p(d.getHours()) + ":" + p(d.getMinutes()) + " " + p(d.getDate()) + "/" + p(d.getMonth() + 1) + "/" + d.getFullYear());
                    $("#xtLoading, #xtEmpty").hide();
                    $("#xtQRResult").show();
                }
                else {
                    me.show_LoiQR("Không tìm thấy văn bằng", "Mã QR không hợp lệ hoặc văn bằng không tồn tại trên hệ thống.");
                }
            },
            function () {
                me.show_LoiQR("Không thể xác thực", "Không kết nối được tới hệ thống, vui lòng thử lại sau.");
            });
    },
    show_LoiQR: function (strTitle, strDesc) {
        $("#xtLoading, #xtQRResult").hide();
        $("#xtEmptyTitle").text(strTitle);
        $("#xtEmptyDesc").text(strDesc);
        $("#xtEmpty").show();
    },

    /*==================== CHẾ ĐỘ TRA CỨU ====================*/
    init_TraCuu: function () {
        var me = this;
        $(".select-opt").select2();
        me.getList_CauHinhHienThi("TRACUUVANBANG.FORM");
        me.getList_drpHeDaoTao();
        me.getList_drpLoaiVanBangChungChi();

        $("#drpHeDaoTao").on("select2:select", function () {
            me.getList_drpLoaiVanBangChungChi();
        });
        $("#btnSearch").click(function () {
            // Kiểm tra mã bảo vệ
            if (captcha.valid(edu.util.getValById("code")) == false) {
                edu.system.alert("Bạn nhập sai mã bảo vệ");
                captcha.refresh();
                return;
            }
            captcha.refresh();
            var strSoHieu = $.trim(edu.util.getValById("txtSoHieuChungChi"));
            if ($('#zoneHoTenNgaySinh').is(':hidden')) {
                if (strSoHieu == "") { edu.system.alert("Bạn chưa nhập thông tin tìm kiếm"); return; }
            }
            else if (strSoHieu == "" && $.trim(edu.util.getValById("txtHoTenDayDu")) == "" && $.trim(edu.util.getValById("txtNgaySinh")) == "") {
                edu.system.alert("Bạn chưa nhập thông tin tìm kiếm");
                return;
            }
            me.tim_KiemVanBang();
        });
        $("#txtSoHieuChungChi, #txtSoVaoSo, #txtHoTenDayDu, #txtNgaySinh, #code").on("keydown", function (e) {
            if (e.keyCode == 13) $("#btnSearch").click();
        });
        // Tự chèn dấu "/" khi nhập ngày sinh: 05092003 -> 05/09/2003
        $("#txtNgaySinh").on("input", function () {
            var v = this.value.replace(/\D/g, "").substring(0, 8);
            if (v.length > 4) v = v.substring(0, 2) + "/" + v.substring(2, 4) + "/" + v.substring(4);
            else if (v.length > 2) v = v.substring(0, 2) + "/" + v.substring(2);
            this.value = v;
        });
        $("#tblKetQuaTimKiem").delegate(".btnChiTietTimKiem", "click", function () {
            var dt = edu.util.objGetDataInData(this.id, me.dtKetQuaTimKiem, "ID");
            if (!dt || !dt.length) return;
            me.render_ThongTin($("#xtModalInfo"), dt[0]);
            $("#lblChiTietHoTen").text(edu.util.returnEmpty(dt[0].HOTEN));
            $("#zoneChiTietKetQuaTimKiem").modal("show");
        });
    },

    tim_KiemVanBang: function () {
        var me = this;
        me.call_API({
            'strTN_KetQua_CongNhan_VB_Id': '',
            'strVanBangChungChiId': edu.util.getValById("drpLoaiVanBangChungChi"),
            'strHoTen': edu.util.getValById("txtHoTenDayDu"),
            'strNgaySinh': edu.util.getValById("txtNgaySinh"),
            'strSoHieuVanBangChungChi': edu.util.getValById("txtSoHieuChungChi"),
            'strSoVaoSo': edu.util.getValById("txtSoVaoSo")
        }, function (data) {
            me.dtKetQuaTimKiem = data || [];
            me.gen_tblKetQuaTimKiem(me.dtKetQuaTimKiem);
        }, function (er) {
            edu.system.alert("Không kết nối được tới hệ thống, vui lòng thử lại sau.", "w");
        });
    },

    gen_tblKetQuaTimKiem: function (data) {
        var me = this;
        edu.system.loadToTable_data({
            strTable_Id: "tblKetQuaTimKiem",
            aaData: data,
            sort: true,
            colPos: { center: [0] },
            aoColumns: [
                { "mDataProp": "HOTEN" },
                { "mRender": function (nrow, aData) { return me.gioiTinh(aData.GENDER); } },
                { "mDataProp": "NGAYSINH" },
                { "mDataProp": "PLACEOFBIRTH" },
                {
                    "mRender": function (nrow, aData) {
                        return (aData.SECONDFIELD == "1" ? "Học ngành 2: " : "") + edu.util.returnEmpty(aData.NGANH);
                    }
                },
                {
                    "mRender": function (nrow, aData) {
                        return (aData.SECONDFIELD == "1" ? "Học chuyên ngành 2: " : "") + edu.util.returnEmpty(aData.CHUYENNGANH);
                    }
                },
                { "mDataProp": "SOHIEUBANG" },
                { "mDataProp": "SOVAOSOCAPVBCC" },
                { "mDataProp": "NGAYQUYETDINH" },
                { "mDataProp": "DANHHIEUVANBANG" },
                {
                    "mRender": function (nrow, aData) {
                        return '<a class="btnChiTietTimKiem" id="' + aData.ID + '" title="Xem chi tiết"><i class="fal fa-eye"></i></a>';
                    }
                }
            ]
        });

        var iSoLuong = data ? data.length : 0;
        $("#wrapKetQuaTimKiem").toggle(iSoLuong > 0);
        $("#cntKetQuaTimKiem").text(iSoLuong > 0 ? iSoLuong + " kết quả" : "");
        if (iSoLuong == 0) {
            $("#emptyKetQuaTimKiem").show()
                .find("h3").text("Không tìm thấy kết quả").end()
                .find("p").text("Vui lòng kiểm tra lại thông tin đã nhập.");
        }
        else {
            $("#emptyKetQuaTimKiem").hide();
        }

        // Nhãn cột cho từng ô (hiển thị dạng thẻ trên điện thoại)
        var arrLabel = $("#tblKetQuaTimKiem thead th").map(function () { return $(this).text(); }).get();
        $("#tblKetQuaTimKiem tbody tr").each(function () {
            $(this).children("td").each(function (i) { $(this).attr("data-label", arrLabel[i] || ""); });
        });
        me.an_CotTheoCauHinh();
    },

    /*---------- Cấu hình hiển thị từ CMS (dùng chung cấu hình với trang tra cứu cũ) ----------*/
    getList_CauHinhHienThi: function (strLoaiCauHinh) {
        var me = this;
        var obj_list = {
            'action': 'CMS_DanhMucDuLieu/LayDanhSach',
            'type': 'GET',
            'strChung_TenDanhMuc_Cha_Id': '',
            'strTuKhoa': '',
            'strCHUNG_TENDANHMUC_Id': strLoaiCauHinh,
            'strTieuChiSapXep': '',
            'pageIndex': 1,
            'pageSize': 1000000,
            'dTrangThai': 1
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) me.ap_DungCauHinh(data.Data || []);
            },
            error: function (er) { },
            type: 'GET',
            action: obj_list.action,
            contentType: true,
            data: obj_list,
            fakedb: []
        }, false, false, false, null);
    },
    ap_DungCauHinh: function (data) {
        var me = this;
        var arrTieuDe = $("#tblKetQuaTimKiem thead th").map(function () { return $(this).text().toUpperCase(); }).get();
        me.arrCotAn = [];
        data.forEach(function (x) {
            var strLoai = edu.util.returnEmpty(x.THONGTIN2).toUpperCase();
            if (strLoai == 'TBLKETQUATIMKIEM' && x.THONGTIN1 == "0") {
                var i = arrTieuDe.indexOf(edu.util.returnEmpty(x.TEN).toUpperCase());
                if (i >= 0 && me.arrCotAn.indexOf(i) < 0) me.arrCotAn.push(i);
            }
            else if (strLoai == 'ZONESHOWHIDE' && x.THONGTIN1 == '0') {
                $("#" + x.MA).hide();
            }
            else if (strLoai == 'PLACEHOLDER') {
                $("#" + x.MA).attr("placeholder", x.MOTA);
            }
        });
        me.an_CotTheoCauHinh();
    },
    an_CotTheoCauHinh: function () {
        var me = this;
        var dtr = $('#tblKetQuaTimKiem')[0].rows;
        for (var ir = 0; ir < dtr.length; ir++) {
            for (var ic = 0; ic < dtr[ir].cells.length; ic++) {
                dtr[ir].cells[ic].style.display = me.arrCotAn.indexOf(ic) >= 0 ? "none" : "";
            }
        }
    },

    getList_drpHeDaoTao: function () {
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    edu.system.loadToCombo_data({
                        data: data.Data,
                        renderInfor: { id: "ID", parentId: "", name: "NAME", code: "CODE", avatar: "" },
                        renderPlace: ["drpHeDaoTao"],
                        type: "",
                        title: "Chọn hệ đào tạo"
                    });
                }
            },
            error: function (er) { },
            type: "GET",
            contentType: true,
            action: 'TS_TraCuuVanBang/GetList_HeDaoTao',
            data: { 'action': 'TS_TraCuuVanBang/GetList_HeDaoTao', 'versionAPI': 'v1.0' },
        }, false, false, false, null);
    },
    getList_drpLoaiVanBangChungChi: function () {
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    edu.system.loadToCombo_data({
                        data: data.Data,
                        renderInfor: { id: "ID", parentId: "", name: "NAME", code: "CODE", avatar: "" },
                        renderPlace: ["drpLoaiVanBangChungChi"],
                        type: "",
                        title: "Chọn loại văn bằng chứng chỉ"
                    });
                }
            },
            error: function (er) { },
            type: "GET",
            contentType: true,
            action: 'TS_TraCuuVanBang/GetList_VanBangChungChi',
            data: {
                'action': 'TS_TraCuuVanBang/GetList_VanBangChungChi',
                'versionAPI': 'v1.0',
                'strHeDaoTaoId': edu.util.getValById("drpHeDaoTao")
            },
        }, false, false, false, null);
    },

    /*==================== DÙNG CHUNG ====================*/
    call_API: function (oThamSo, fSuccess, fError) {
        var obj_list = $.extend({
            'action': 'TS_TraCuuVanBang/GetList_ThongTinVanBangSV',
            'versionAPI': 'v1.0',
            'strTN_KetQua_CongNhan_VB_Id': '',
            'strVanBangChungChiId': '',
            'strHoTen': '',
            'strNgaySinh': '',
            'strSoHieuVanBangChungChi': '',
            'strSoVaoSo': ''
        }, oThamSo);

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) fSuccess(data.Data);
                else fError(data.Message);
            },
            error: function (er) { fError(er); },
            type: "GET",
            action: obj_list.action,
            versionAPI: obj_list.versionAPI,
            contentType: true,
            authen: true,
            data: obj_list,
            fakedb: []
        }, false, false, false, null);
    },

    gioiTinh: function (v) {
        // API có thể trả "1"/"0" hoặc "Nam"/"Nữ"
        var s = $.trim(edu.util.returnEmpty(v).normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase());
        if (s == "1" || s == "nam" || s == "male" || s == "m") return "Nam";
        if (s == "0" || s == "2" || s == "nu" || s == "female" || s == "f") return "Nữ";
        return edu.util.returnEmpty(v);
    },

    render_ThongTin: function ($root, dt) {
        var me = this;
        var e = edu.util.returnEmpty;
        var f = function (k, v) { $root.find('[data-f="' + k + '"]').text(e(v)); };

        // Thông tin quản lý văn bằng
        f("TrinhDo", dt.TRINHDODAOTAO);
        // Thông tin người được cấp bằng
        f("HoTen", dt.HOTEN);
        f("NgaySinh", dt.NGAYSINH);
        f("GioiTinh", me.gioiTinh(dt.GENDER));
        f("Nganh", dt.NGANH);
        f("HangTN", dt.XEPLOAI);
        f("NamTN", dt.NAMTN);
        // Thông tin văn bằng
        f("TenVB", dt.DANHHIEUVANBANG);
        f("SoHieu", dt.SOHIEUBANG);
        f("SoVaoSo", dt.SOVAOSOCAPVBCC);
        f("NgayKy", dt.NGAYQUYETDINH);
        // Chữ cái đầu của tên (VD: Bùi Văn Đạt -> Đ) cho ô avatar
        var arrTen = $.trim(e(dt.HOTEN)).split(/\s+/);
        f("KyTu", (arrTen[arrTen.length - 1] || "").charAt(0).toUpperCase());

        // Thông tin khác: chỉ có giá trị khi văn bằng bị cấp lại / chỉnh sửa / thu hồi / hủy bỏ
        var strTinhTrang = $.trim(e(dt.TINHTRANGVANBANG || dt.TINHTRANG));
        f("TinhTrang", strTinhTrang);
        var $st = $root.find(".xt-status");
        if (strTinhTrang != "") {
            $st.addClass("is-warn");
            $st.find(".xt-status-icon").attr("class", "fas fa-exclamation-circle xt-status-icon");
            $st.find(".xt-status-title").text(strTinhTrang);
            $st.find(".xt-status-desc").text("Vui lòng liên hệ Nhà trường để được xác nhận");
        }
        else {
            $st.removeClass("is-warn");
            $st.find(".xt-status-icon").attr("class", "fas fa-check-circle xt-status-icon");
            $st.find(".xt-status-title").text("Văn bằng hợp lệ");
            $st.find(".xt-status-desc").text("Khớp với dữ liệu gốc của Nhà trường");
        }
    },
}
