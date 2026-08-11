function KiemTraChuyenNganh() { };

KiemTraChuyenNganh.prototype = {
    dtChuongTrinh: [],
    strSelectedKey: '',

    init: function () {
        var me = this;
        edu.system.appCode = "NH";
        edu.system.iM = "AAAAA";
        // Cần đảm bảo apiUrlTemp là chuỗi rỗng (systemroot ghép p = apiUrlTemp + objApi[g] + "/" + action).
        // Nếu chưa init sẽ ra URL kiểu "null/sinhvienapi/api/..." -> 404.
        if (edu.system.apiUrlTemp == null || edu.system.apiUrlTemp === undefined) edu.system.apiUrlTemp = "";
        // Lấy token JWT trước (giống thanhtoan.js) -- backend có thể require Bearer, và getList_Token còn set apiUrlTemp/objApi.
        me.getList_Token();

        $("#btnKiemTra").click(function () {
            me.doKiemTra();
        });

        $("#txtCCCD, #txtHoTen, #txtNgaySinh").keypress(function (e) {
            if (e.which === 13) {
                e.preventDefault();
                me.doKiemTra();
            }
        });

        // Auto format ngày sinh dd/mm/yyyy khi gõ
        $("#txtNgaySinh").on("input", function () {
            var v = this.value.replace(/[^\d/]/g, '');
            // Tự chèn dấu / sau 2 và 5 ký tự số
            var digits = v.replace(/\//g, '');
            var out = '';
            for (var i = 0; i < digits.length && i < 8; i++) {
                if (i === 2 || i === 4) out += '/';
                out += digits[i];
            }
            this.value = out;
        });

        // Chọn 1 dòng trong bảng
        $("#tblChuongTrinh").on("change", ".rdoChon", function () {
            me.strSelectedKey = this.value;
            $("#tblChuongTrinh tbody tr").removeClass('is-selected');
            $(this).closest('tr').addClass('is-selected');
        });

        // Click cả dòng cũng chọn
        $("#tblChuongTrinh").on("click", "tbody tr", function (e) {
            if ($(e.target).is('input, label, span')) return;
            var $rdo = $(this).find('.rdoChon');
            if ($rdo.length) {
                $rdo.prop('checked', true).trigger('change');
            }
        });

        $("#btnDongY").click(function () {
            if (!me.strSelectedKey) {
                edu.system.alert("Vui lòng chọn một chương trình học trước khi bấm Đồng ý.", "w");
                return;
            }
            var row = me.findRowByKey(me.strSelectedKey);
            if (!row) {
                edu.system.alert("Không tìm thấy dữ liệu chương trình đã chọn. Vui lòng thử lại.", "w");
                return;
            }
            edu.system.confirm("Bạn có chắc chắn xác nhận chương trình này? Sau khi xác nhận, hệ thống sẽ cập nhật chương trình đào tạo nhập học cho thí sinh.");
            $("#btnYes").off("click.ktcn").on("click.ktcn", function () {
                me.xacNhan_ChuongTrinh(row);
            });
        });
    },

    getList_Token: function () {
        var me = this;
        var obj_list = {
            'action': 'CMS_Token/LayChiTiet',
            'type': 'GET',
            'strUser': 'guest',
            'strPass': '4f4205e969bf26e69af8f9ebe6f8a87f'
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    edu.system.tokenJWT = data.Data;
                }
            },
            error: function (er) {
                if (window.console) console.warn('[KiemTraChuyenNganh] Token fail:', er);
            },
            type: 'GET',
            action: obj_list.action,
            contentType: true,
            data: obj_list,
            fakedb: []
        }, false, false, false, null);
    },

    doKiemTra: function () {
        var me = this;
        var cccd = (edu.util.getValById("txtCCCD") || '').trim();
        var hoten = (edu.util.getValById("txtHoTen") || '').trim();
        var ngaysinh = (edu.util.getValById("txtNgaySinh") || '').trim();

        if (!cccd) { edu.system.alert("Vui lòng nhập CCCD.", "w"); return; }
        if (!hoten) { edu.system.alert("Vui lòng nhập Họ và tên.", "w"); return; }
        if (!ngaysinh) { edu.system.alert("Vui lòng nhập Ngày sinh (dd/mm/yyyy).", "w"); return; }
        if (!/^\d{2}\/\d{2}\/\d{4}$/.test(ngaysinh)) {
            edu.system.alert("Ngày sinh phải theo định dạng dd/mm/yyyy.", "w");
            return;
        }
        me.getList_ChuongTrinh(cccd, hoten, ngaysinh);
    },

    getList_ChuongTrinh: function (cccd, hoten, ngaysinh) {
        var me = this;
        var obj_save = {
            'action': 'SV_Core_TS_HoSo_MH/DSA4BRICKTQuLyYVMygvKR4VKSgSKC8pAikuLwPP',
            'func': 'PKG_CORE_TS_HOSO.LayDSChuongTrinh_ThiSinhChon',
            'iM': edu.system.iM,
            'strCCCD': cccd,
            'strHoTen': hoten,
            'strNgaySinh': ngaysinh,
            'strNguoiThucHien_Id': '',
            'strVaiTroDangNhap_Id': '',
            'strChucNangHeThong_Id': '',
            'strHanhDong_Code': '',
        };

        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                edu.system.endLoading();
                if (data.Success) {
                    me.dtChuongTrinh = data.Data || [];
                    me.strSelectedKey = '';
                    me.genTable_ChuongTrinh(me.dtChuongTrinh);
                    $("#zoneResult").show();
                    if (me.dtChuongTrinh.length === 0) {
                        edu.system.alert("Không tìm thấy chương trình nào phù hợp với thông tin đã nhập. Vui lòng kiểm tra lại CCCD, Họ tên và Ngày sinh.", "w");
                    }
                } else {
                    edu.system.alert("Lỗi: " + (data.Message || 'Không xác định'), "w");
                }
            },
            error: function (er) {
                edu.system.endLoading();
                edu.system.alert("Lỗi kết nối: " + JSON.stringify(er), "w");
            },
            type: "POST",
            action: obj_save.action,
            contentType: true,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },

    // Lấy giá trị field bất kể casing (Oracle thường trả UPPERCASE, C# đôi khi wrap camelCase)
    pick: function (obj, keys) {
        if (!obj) return '';
        for (var i = 0; i < keys.length; i++) {
            var k = keys[i];
            if (obj[k] !== undefined && obj[k] !== null) return obj[k];
            var kUp = k.toUpperCase();
            if (obj[kUp] !== undefined && obj[kUp] !== null) return obj[kUp];
            var kLow = k.toLowerCase();
            if (obj[kLow] !== undefined && obj[kLow] !== null) return obj[kLow];
        }
        return '';
    },

    buildRowKey: function (d) {
        var intakeId = this.pick(d, ['CORE_PERSON_INTAKE_ID', 'Core_Person_Intake_Id']);
        var ctId = this.pick(d, ['DAOTAO_TOCHUCCHUONGTRINH_ID', 'DaoTao_ToChucChuongTrinh_Id']);
        return String(intakeId) + '||' + String(ctId);
    },

    findRowByKey: function (key) {
        for (var i = 0; i < this.dtChuongTrinh.length; i++) {
            if (this.buildRowKey(this.dtChuongTrinh[i]) === key) return this.dtChuongTrinh[i];
        }
        return null;
    },

    genTable_ChuongTrinh: function (data) {
        var me = this;
        var $tbody = $("#tblChuongTrinh tbody").html('');

        // Chỉ hiện nút "Đồng ý" khi có nhiều hơn 1 chương trình để lựa chọn.
        // 0 hoặc 1 bản ghi thì không cần thí sinh xác nhận thủ công.
        if (data && data.length > 1) $("#btnDongY").show();
        else $("#btnDongY").hide();

        if (!data || data.length === 0) {
            $tbody.html('<tr><td colspan="6" class="aps-ktcn-empty">Không có dữ liệu chương trình.</td></tr>');
            return;
        }

        // Log first row cho dev dễ debug tên field thực tế trả về
        if (window.console) console.log('[KiemTraChuyenNganh] Sample row:', data[0]);

        var rows = '';
        for (var i = 0; i < data.length; i++) {
            var d = data[i];
            var key = me.buildRowKey(d);

            var nganhMa = me.pick(d, ['NGANHTS_MA', 'NganhTS_Ma']);
            var nganhTen = me.pick(d, ['NGANHTS_TEN', 'NganhTS_Ten']);
            var ctMa = me.pick(d, ['CHUONGTRINH_MA', 'ChuongTrinh_Ma']);
            var ctTen = me.pick(d, ['CHUONGTRINH_TEN', 'ChuongTrinh_Ten']);
            var laHT = me.pick(d, ['LACHUONGTRINHHIENTAI', 'LaChuongTrinhHienTai']);

            var nganhLabel = nganhMa
                ? (nganhMa + (nganhTen ? ' (' + nganhTen + ')' : ''))
                : (nganhTen || '');

            var hienTaiCell = (String(laHT) === '1')
                ? '<span class="aps-ktcn-badge-cur"><i class="fal fa-check"></i> Đang chọn</span>'
                : '';

            rows += '<tr>';
            rows += '<td class="text-center">' + (i + 1) + '</td>';
            rows += '<td>' + edu.util.returnEmpty(nganhLabel) + '</td>';
            rows += '<td class="text-center">' + edu.util.returnEmpty(ctMa) + '</td>';
            rows += '<td>' + edu.util.returnEmpty(ctTen) + '</td>';
            rows += '<td class="text-center">' + hienTaiCell + '</td>';
            rows += '<td class="text-center">'
                + '<label class="aps-ktcn-rdo">'
                + '<input type="radio" name="rdoChuongTrinh" class="rdoChon" value="' + key + '" />'
                + '<span>chọn</span>'
                + '</label>'
                + '</td>';
            rows += '</tr>';
        }
        $tbody.html(rows);
    },

    xacNhan_ChuongTrinh: function (row) {
        var me = this;
        var personId = me.pick(row, ['PERSON_ID', 'Person_Id']);
        var ctId = me.pick(row, ['DAOTAO_TOCHUCCHUONGTRINH_ID', 'DaoTao_ToChucChuongTrinh_Id']);
        var intakeId = me.pick(row, ['CORE_PERSON_INTAKE_ID', 'Core_Person_Intake_Id']);

        if (!personId || !ctId || !intakeId) {
            edu.system.alert("Thiếu thông tin định danh (Person_Id / ChuongTrinh_Id / Intake_Id). Vui lòng liên hệ hỗ trợ.", "w");
            return;
        }

        var obj_save = {
            'action': 'SV_Core_TS_HoSo_MH/GSAiDykgLwIpLi8CKTQuLyYVMygvKQkuIgPP',
            'func': 'PKG_CORE_TS_HOSO.XacNhanChonChuongTrinhHoc',
            'iM': edu.system.iM,
            'strPerson_Id': personId,
            'strDaoTao_ChuongTrinh_Id': ctId,
            'strINTAKE_Id': intakeId,
            'strNguoiThucHien_Id': '',
        };

        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                edu.system.endLoading();
                if (data.Success) {
                    edu.system.alert('<span style="color: #0e9347; font-weight: 600;"><i class="fal fa-check-circle"></i> Xác nhận chương trình học thành công!</span>');
                    // Reload lại danh sách để cập nhật cột "Hiện tại"
                    var cccd = (edu.util.getValById("txtCCCD") || '').trim();
                    var hoten = (edu.util.getValById("txtHoTen") || '').trim();
                    var ngaysinh = (edu.util.getValById("txtNgaySinh") || '').trim();
                    if (cccd && hoten && ngaysinh) me.getList_ChuongTrinh(cccd, hoten, ngaysinh);
                } else {
                    edu.system.alert("Lỗi: " + (data.Message || 'Không xác định'), "w");
                }
            },
            error: function (er) {
                edu.system.endLoading();
                edu.system.alert("Lỗi kết nối: " + JSON.stringify(er), "w");
            },
            type: "POST",
            action: obj_save.action,
            contentType: true,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    }
};
