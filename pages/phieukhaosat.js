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
            me.getList_NhomAn();
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

        me.dtNhom.forEach((oNhom, iNhom) => {
            html += '<div class="ks-nhom" data-nhom-id="' + (oNhom.ID || '') + '">';
            if (oNhom.TEN) {
                html += '<div class="cmc-suvery-group">';
                html += '<div class="title btnEditNhom btnEdit" id="' + oNhom.ID + '">';
                html += oNhom.TEN + ' <span class="color-red">*</span>';
                html += '</div>';
            }

            var dtCauHoiTheoNhom = me.dtCauHoi.filter(e => e.KS_NHOMCAUHOI_ID == oNhom.ID)

            dtCauHoiTheoNhom.forEach((oCauHoi, iCauHoi) => {
                html += '<div class="cmc-suvery-item">';
                html += '<div class="cmc-suvery-question pointer btnEdit btnEditCauHoi" id="' + oCauHoi.ID + '">';
                html += '<span class="fw-bold">Câu ' + (iCauHoi + 1) + ':</span>';
                html += oCauHoi.CAUHOIBATBUOCTRALOI ? '<span class="color-red">*</span>' : '';
                html += ' <span class="question-text">' + oCauHoi.TENCAUHOI + '</span>';
                html += '</div>';
                html += '<div class="cmc-suvery-answer">';
                html += '<div class="answer-l" id="answer' + oCauHoi.ID + '">';
                html += '</div>';
                html += '</div>';
                html += '</div>';
            })
            if (oNhom.TEN) html += '</div>'; // đóng cmc-suvery-group
            html += '</div>'; // đóng ks-nhom
        })
        $("#tblNoiDung").html(html);
    },

    genTable_DapAn: function (objCauHoi) {
        var me = this;
        var html = "";
        var dtResult = me.dtDapAn.filter(e => e.KS_CAUHOI_ID == objCauHoi.ID)
        if (objCauHoi.KS_LOAICAUHOI_ID == 2) {
            var html = "";
            html += '<div class="input-group">';
            html += '<input type="text" id="' + objCauHoi.ID + '" class="form-control ps-3" />';
            html += '</div>';
            $("#answer" + objCauHoi.ID).html(html)
            return;
        }
        dtResult.forEach(e => {
            var strStyle = objCauHoi.CACHHIENTHICAUHOI ? 'width: 100%' : '';
            var typean = objCauHoi.KS_LOAICAUHOI_ID == "3" ? "radio": "checkbox";
            html += '<div class="form-check mb-2" style="' + strStyle + '">';
            html += '<input class="form-check-input" type="' + typean + '" name="' + objCauHoi.ID + '" id="' + e.ID + '">';
            html += '<label class="form-check-label" for="' + e.ID + '">';
            html += e.TENDAPAN;
            html += '</label>';
            html += '</div>';
        })
        $("#answer" + objCauHoi.ID).html(html)
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
    },
}