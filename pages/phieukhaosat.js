/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function KhaoSat() { };
KhaoSat.prototype = {
    strPhieu_Id: '',
    strKeHoach_Id: '',
    dtNhom: [],
    dtCauHoi: [],
    dtKetQua: [],
    dtDapAn: [],
    strPhieuMau_Id: '',
    objNhomAnTheoDapAn: {}, // cache: đáp án id → [nhóm bị ẩn]
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "KS";
        const urlParams = new URLSearchParams(window.location.search);
        me.strPhieu_Id = urlParams.get('strPhieu_Id');
        me.strKeHoach_Id = urlParams.get('strKeHoach_Id');
        edu.system.userId = urlParams.get('strNguoiThucHien_Id');
        me.getList_Phieu();
        // Bước nhảy theo đáp án: chọn / bỏ chọn đáp án → ẩn các nhóm cấu hình cho đáp án đó
        $("#tblNoiDung").delegate('.form-check-input', 'change', function () {
            me.update_TienDo();
            me.getList_NhomAn();
        });
        $("#tblNoiDung").delegate('.form-control', 'input', function () {
            me.update_TienDo();
        });
        //$("#zoneKhuVuc").delegate('.btnSelectInList', 'click', function (e) {
        //    var strId = this.id;
        //    var point = this; e.preventDefault();
        //    var x = $("#zoneKhuVuc .btnSelectInList");
        //    for (var i = 0; i < x.length; i++) {
        //        x[i].classList.remove("btn-primary");
        //    }
        //    point.classList.add("btn-primary");
        //    me.strKhuVuc_Id = strId;
        //    localStorage.setItem("strKhuVuc_Id", strId);
        //    me.ilandau = 1;
        //    me.showDay();
        //});
        //if (edu.system.userId) {
        //    me.showDay();
        //} else {
        //    //console.log(111111);
        //    //$("#btnDangNhapGiangDuong").trigger("click");
        //    $("#modal-sv-registration").modal("show")
        //}
    },

    getList_Phieu: function (strNgayHoc) {
        var me = this;
        var obj_list = {
            'action': 'KS_TaoPhieu/LayTTHienThiPhieuMau',
            'type': 'GET',
            'strKS_KeHoachKhaoSat_Id': edu.util.getValById('dropAAAA'),
            'strKS_PhieuKhaoSat_Mau_Id': me.strPhieu_Id,
            'strNguoiThamGiaKhaoSat_Id': edu.util.getValById('dropAAAA'),
            'strNguoiThucHien_Id': edu.system.userId,
        };
        if (me.strKeHoach_Id) {
            obj_list = {
                'action': 'KS_TaoPhieu/LayTTHienThiPhieuTheoKeHoach',
                'type': 'GET',
                'strKS_KeHoachKhaoSat_Id': me.strKeHoach_Id,
                'strKS_PhieuKhaoSat_Id': me.strPhieu_Id,
                'strNguoiThamGiaKhaoSat_Id': edu.util.getValById('dropAAAA'),
                'strNguoiThucHien_Id': edu.system.userId,
            }
        }
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;

                    var data = dtReRult.rsThongTinPhieu[0];

                    me.dtNhom = dtReRult.rsNhomCauHoi
                    me.dtCauHoi = dtReRult.rsCauHoi
                    me.dtDapAn = dtReRult.rsDapAn
                    me.dtKetQua = dtReRult.rsKetQuaKhaoSat
                    // cấu hình ẩn nhóm lưu theo ID phiếu mẫu; mở theo kế hoạch thì strPhieu_Id là phiếu thực tế
                    me.strPhieuMau_Id = edu.util.returnEmpty(data.KS_PHIEUKHAOSAT_MAU_ID) || (me.strKeHoach_Id ? '' : me.strPhieu_Id);
                    me.objNhomAnTheoDapAn = {};

                    $("#lblTieuDe").html(data.TENPHIEU)
                    $("#lblMoTaPhieu").html('<strong>' + edu.util.returnEmpty(data.LOAIPHIEU_TEN) + ':</strong> <span>' + edu.util.returnEmpty(data.MOTA) + '</span>');
                    me.dtNhom.push({ ID: null });
                    me.genTable_CauHoi();
                    me.dtCauHoi.forEach(e => me.genTable_DapAn(e))
                    $("#lblSoNhom").html(me.dtNhom.filter(n => n.ID && me.dtCauHoi.some(c => c.KS_NHOMCAUHOI_ID == n.ID)).length);
                    $("#lblSoCau").html(me.dtCauHoi.length);
                    $("#lblSoBatBuoc").html(me.dtCauHoi.filter(c => c.CAUHOIBATBUOCTRALOI == 1).length);
                    me.update_TienDo();
                }
                else {
                    edu.system.alert(data.Message, "s");
                }

            },
            error: function (er) {

                edu.system.alert(JSON.stringify(er), "w");
            },
            type: 'GET',
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },

    genTable_CauHoi: function () {
        var me = this;
        var html = "";
        me.dtNhom.forEach((oNhom) => {
            var dtCauHoiTheoNhom = me.dtCauHoi.filter(e => e.KS_NHOMCAUHOI_ID == oNhom.ID);
            if (!dtCauHoiTheoNhom.length) return;
            // .ks-nhom có data-nhom-id để ẩn/hiện theo bước nhảy đáp án
            html += '<div class="ks-nhom" data-nhom-id="' + (oNhom.ID || '') + '">';
            html += '<div class="ks-group">';
            if (oNhom.TEN) {
                html += '<div class="ks-group-head">';
                html += '<h3 class="ks-group-title">' + oNhom.TEN + '</h3>';
                html += '<span class="ks-group-count">' + dtCauHoiTheoNhom.length + ' câu</span>';
                html += '</div>';
            }
            dtCauHoiTheoNhom.forEach((oCauHoi, iCauHoi) => {
                html += '<div class="ks-q" data-cauhoi-id="' + oCauHoi.ID + '" data-batbuoc="' + (oCauHoi.CAUHOIBATBUOCTRALOI == 1 ? 1 : 0) + '">';
                html += '<div class="ks-q-head">';
                html += '<span class="ks-q-no">Câu ' + (iCauHoi + 1) + '</span>';
                html += '<div class="ks-q-text">' + oCauHoi.TENCAUHOI + (oCauHoi.CAUHOIBATBUOCTRALOI == 1 ? '<span class="ks-req" title="Bắt buộc trả lời">*</span>' : '') + '</div>';
                html += '</div>';
                html += '<div class="student-choose" id="answer' + oCauHoi.ID + '"></div>';
                html += '</div>';
            });
            html += '</div>';
            html += '</div>';
        });
        $("#tblNoiDung").html(html);
    },

    genTable_DapAn: function (objCauHoi) {
        var me = this;
        var html = "";
        var dtResult = me.dtDapAn.filter(e => e.KS_CAUHOI_ID == objCauHoi.ID);
        if (objCauHoi.KS_LOAICAUHOI_ID == 2) {
            html += '<div class="ks-text-answer">';
            html += '<textarea id="' + objCauHoi.ID + '" name="' + objCauHoi.ID + '" class="form-control" rows="3" placeholder="Nhập câu trả lời của bạn..."></textarea>';
            html += '</div>';
            $("#answer" + objCauHoi.ID).html(html);
            return;
        }
        var bRadio = objCauHoi.KS_LOAICAUHOI_ID == "3";
        html += '<div class="ks-opts' + (objCauHoi.CACHHIENTHICAUHOI ? ' ks-opts-col' : '') + '">';
        dtResult.forEach(e => {
            html += '<label class="ks-opt" for="' + e.ID + '">';
            html += '<input class="form-check-input" type="' + (bRadio ? 'radio' : 'checkbox') + '" name="' + objCauHoi.ID + '" id="' + e.ID + '">';
            html += '<span class="ks-opt-mark ' + (bRadio ? 'is-radio' : 'is-check') + '"></span>';
            html += '<span class="ks-opt-text">' + e.TENDAPAN + '</span>';
            html += '</label>';
        });
        html += '</div>';
        $("#answer" + objCauHoi.ID).html(html);
    },

    /*------------------------------------------
    --Discription: Bước nhảy theo đáp án — KHAOSAT_TAOPHIEU.LayDS_KS_DapAn_An_Nhom
    --  Trang xem phiếu không lưu đáp án → lấy nhóm ẩn theo từng đáp án đang chọn rồi ẩn các nhóm đó.
    -------------------------------------------*/
    getList_NhomAn: function () {
        var me = this;
        if (!me.strPhieuMau_Id) return;
        var arrChon = $("#tblNoiDung .form-check-input:checked").map(function () { return this.id; }).get();
        var arrChuaCo = arrChon.filter(id => !me.objNhomAnTheoDapAn[id]);
        if (!arrChuaCo.length) { me.apply_NhomAn(); return; }
        var iCon = arrChuaCo.length;
        arrChuaCo.forEach(function (strDapAn_Id) {
            var obj_list = {
                'action': 'SV_KHAOSAT_TAOPHIEU_MH/DSA4BRIeChIeBSAxAC8eAC8eDykuLAPP',
                'func': 'KHAOSAT_TAOPHIEU.LayDS_KS_DapAn_An_Nhom',
                'iM': edu.system.iM,
                'strKS_CauHoi_DapAn_Id': strDapAn_Id,
                'strKS_PhieuKhaoSat_Mau_Id': me.strPhieuMau_Id,
                'strNguoiThucHien_Id': edu.system.userId,
            };
            var fnXong = function () { if (--iCon === 0) me.apply_NhomAn(); };
            edu.system.makeRequest({
                success: function (data) {
                    if (data.Success) {
                        me.objNhomAnTheoDapAn[strDapAn_Id] = (data.Data || []).map(e => e.AN_KS_NHOMCAUHOI_ID).filter(e => e);
                    } else {
                        console.warn("[LayDS_KS_DapAn_An_Nhom]", data.Message);
                    }
                    fnXong();
                },
                error: function (er) {
                    console.warn("[LayDS_KS_DapAn_An_Nhom] error:", er);
                    fnXong();
                },
                type: 'POST',
                contentType: true,
                action: obj_list.action,
                data: obj_list,
                fakedb: []
            }, false, false, false, null);
        });
    },
    apply_NhomAn: function () {
        var me = this;
        // đáp án nằm trong nhóm đã bị ẩn thì không tính → lặp đến khi danh sách nhóm ẩn ổn định
        var arrAn = [];
        for (var iLap = 0; iLap < 20; iLap++) {
            var arrMoi = [];
            $("#tblNoiDung .form-check-input:checked").each(function () {
                var strNhom = $(this).closest(".ks-nhom").attr("data-nhom-id");
                if (strNhom && arrAn.includes(strNhom)) return;
                (me.objNhomAnTheoDapAn[this.id] || []).forEach(x => { if (!arrMoi.includes(x)) arrMoi.push(x); });
            });
            var bGiong = arrMoi.length === arrAn.length && arrMoi.every(x => arrAn.includes(x));
            arrAn = arrMoi;
            if (bGiong) break;
        }
        $("#tblNoiDung .ks-nhom").each(function () {
            var strNhom_Id = $(this).attr("data-nhom-id");
            if (strNhom_Id && arrAn.includes(strNhom_Id)) $(this).hide();
            else $(this).show();
        });
        me.update_TienDo();
    },
    /*------------------------------------------
    --Discription: Tiến độ trả lời — đánh dấu câu đã trả lời, đếm số câu (bỏ nhóm đang ẩn)
    -------------------------------------------*/
    update_TienDo: function () {
        var iTong = 0, iXong = 0, iThieu = 0;
        $("#tblNoiDung .ks-opt").each(function () {
            $(this).toggleClass("is-checked", $(this).find(".form-check-input").prop("checked"));
        });
        $("#tblNoiDung .ks-q").each(function () {
            var point = $(this);
            var bDaTraLoi = point.find(".form-check-input:checked").length > 0
                || point.find("textarea.form-control").filter(function () { return $.trim(this.value) !== ""; }).length > 0;
            point.toggleClass("is-done", bDaTraLoi);
            if (bDaTraLoi) point.removeClass("is-missing");
            if (point.closest(".ks-nhom").css("display") === "none") return;
            iTong++;
            if (bDaTraLoi) iXong++;
            else if (point.attr("data-batbuoc") == "1") iThieu++;
        });
        $("#lblDaTraLoi").html(iXong + "/" + iTong);
        $("#barDaTraLoi").css("width", (iTong ? Math.round(iXong * 100 / iTong) : 0) + "%");
        $("#lblFootNote").html(iThieu
            ? 'Còn <span class="color-red">' + iThieu + '</span> câu bắt buộc chưa trả lời'
            : (iTong ? '<i class="fal fa-check-circle" style="color:#16a34a"></i> Đã trả lời đủ các câu bắt buộc' : ''));
    },
}