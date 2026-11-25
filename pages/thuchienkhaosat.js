/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function ThucHienKhaoSat() { };
ThucHienKhaoSat.prototype = {
    strPhieu_Id: '',
    strKS_PhieuKhaoSat_Id: '',
    dtDoiTuong: [],
    dtNhom: [],
    dtCauHoi: [],
    dtKetQua: [],
    dtDapAn: [],
    arrNhomAn_Id: [],
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "KS";
        const urlParams = new URLSearchParams(window.location.search);
        me.strPhieu_Id = urlParams.get('strPhieu_Id');
        edu.system.userId = urlParams.get('strNguoiThucHien_Id');
        me.getList_DoiTuong();
        $("#tblDoiTuong").delegate('.btnEdit', 'click', function (e) {
            var strId = this.id;
            me.strPhieu_Id = strId;
            var aData = me.dtDoiTuong.find(e => e.ID == strId);
            $("#lblDoiTuong").html(aData.DOITUONG_TEN)
            me.strKS_PhieuKhaoSat_Id = aData.KS_PHIEUKHAOSAT_ID;
            $(".btnEdit").removeClass("active");
            $(this).addClass("active");
            me.getList_Phieu();
        });
        //$("#btnLuuKetQua").click(function () {
        //    var aData = me.dtDoiTuong.find(e => e.ID == me.strPhieu_Id);
        //    var arrThemKhac = [];
        //    var arrThem = [];
        //    var arrXoa = [];
        //    $('#tblNoiDung input').each(function () {
        //        var point = $(this);
        //        if (point.hasClass('form-control')) {
        //            if (point.val() != point.attr("name")) arrThemKhac.push(point.attr("id"));
        //        } else {
        //            if (point.is(':checked')) {
        //                if (!point.attr('name')) arrThem.push(point.attr("id"))
        //            } else {
        //                if (point.attr('name')) arrXoa.push(point.attr("id"))
        //            }
        //        }
        //    })
        //    if (!(arrThem.length + arrThemKhac.length + arrXoa.length)) {
        //        edu.system.alert("Không có thay đổi");
        //    }
        //    edu.system.confirm("Bạn có chắc chắn thêm " + (arrThem.length + arrThemKhac.length) + " và xóa " + arrXoa.length + "?");
        //    $("#btnYes").click(function (e) {
        //        //$('#myModalAlert').modal('hide');
        //        //for (var i = 0; i < arrChecked_Id.length; i++) {
        //        //    me.delete_KeHoach(arrChecked_Id[i]);
        //        //}
        //    });
        //});
        //
        $("#tblNoiDung").delegate('.form-check-input', 'change', function (e) {
            me.update_TienDo();
            if (this.checked) {
                me.save_KetQua(this.id, "", $(this).attr("name"));
            } else {
                me.delete_KetQua(this.id)
            }
        });
        $("#tblNoiDung").delegate('.form-control', 'input', function () {
            me.update_TienDo();
        });
        $("#tblNoiDung").delegate('.form-control', 'blur', function (e) {
            me.save_KetQua("", $(this).val(), $(this).attr("name"));
        });
        $(".btnLuuKetQua").click(function () {
            var iCount = 0;
            $("#tblNoiDung .ks-q").removeClass("is-missing");
            // Câu bắt buộc thuộc nhóm đang bị ẩn (bước nhảy theo đáp án) thì không bắt trả lời
            var dtBatBuoc = me.dtCauHoi.filter(e => e.CAUHOIBATBUOCTRALOI == 1 && !me.arrNhomAn_Id.includes(e.KS_NHOMCAUHOI_ID));
            dtBatBuoc.forEach(e => {
                if (e.KS_LOAICAUHOI_ID == 2) {
                
                    if (!$("#" + e.KS_KETQUAKHAOSAT_ID).val()) { iCount++; $('#tblNoiDung .ks-q[data-cauhoi-id="' + e.ID + '"]').addClass("is-missing"); }
                } else {
                    if (!$("#answer" + e.ID + " :checked").length) { iCount++; $('#tblNoiDung .ks-q[data-cauhoi-id="' + e.ID + '"]').addClass("is-missing"); }
                }
            })
            var pThieu = $("#tblNoiDung .ks-q.is-missing").first();
            if (pThieu.length) pThieu[0].scrollIntoView({ behavior: "smooth", block: "center" });
            if (iCount > 0) edu.system.alert('Bạn còn <span style="color: red">' + iCount + '</span> câu hỏi chưa hoàn thành');
            edu.system.confirm("Bạn có chắc chắn hoàn thành phiếu khảo sát?");
            $("#btnYes").click(function (e) {
                $("#btnYes").hide();
                $("#alert_content").html("");
                me.save_HoanThanh();
            });
        });
    },

    getList_DoiTuong: function (strNgayHoc) {
        var me = this;
        var obj_list = {
            'action': 'KS_ThucHien/LayDSDoiTuongDuocKhaoSat',
            'type': 'GET',
            'strNguoiThucHien_Id': edu.system.userId,
            'strKS_DoiTuongTGKS_Id': edu.system.userId,
            'strKS_PhieuKhaoSat_Id': edu.util.getValById('dropAAAA'),
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.dtDoiTuong = dtReRult;
                    me.genTable_DoiTuong(dtReRult);
                    if (dtReRult.length) {
                        $("#lblDoiTuong").html(dtReRult[0].DOITUONG_TEN)
                    }
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

    genTable_DoiTuong: function (data) {
        var me = this;
        var html = "";
        var iSoLuong = me.dtDoiTuong.filter(e => e.TINHTRANG > 0).length;
        $("#lblTinhTrang").html('' + iSoLuong + '/' + data.length);
        $("#barTinhTrang").css("width", (data.length ? Math.round(iSoLuong * 100 / data.length) : 0) + "%");
        if (iSoLuong == data.length) {
            edu.system.confirm("Bạn có muốn quay về trang chủ không?");
            $("#btnYes").click(function (e) {
                location.href = "../index.aspx"
            });
        }
        data.forEach((aData, index) => {
            html += '<li class="cmc-question-item pointer btnEdit" id="' + aData.ID + '">';
            html += '<a href="#question_group" data-bs-toggle="modal">';
            html += '<div class="num">' + (index + 1) + '</div>';
            html += '<p>';
            html += edu.util.returnEmpty(aData.KS_PHIEUKHAOSAT_TEN);
            html += '</p>';
            html += aData.TINHTRANG ? '<span class="status complate">Hoàn thành</span>' : '<span class="status not-complate">Chưa hoàn thành</span>';
            html += '</a>';
            html += '</li>';
            if (!aData.TINHTRANG) me.strPhieu_Id = aData.ID;
        });
        $("#tblDoiTuong").html(html);
        if (me.strPhieu_Id) {
            var aData = data.find(e => e.ID == me.strPhieu_Id);
            if (aData)
            $("#tblDoiTuong li[id=" + aData.ID + "]").trigger("click");
        }
    },

    getList_Phieu: function (strNgayHoc) {
        var me = this;
        var aData = me.dtDoiTuong.find(e => e.ID == me.strPhieu_Id);
        var obj_list = {
            'action': 'KS_TaoPhieu/LayTTHienThiPhieuTheoCaNhan',
            'type': 'GET',
            'strKS_KeHoachKhaoSat_Id': aData.KS_KEHOACHKHAOSAT_ID,
            'strKS_PhieuKhaoSat_Id': me.strKS_PhieuKhaoSat_Id,
            'strNguoiThamGiaKhaoSat_Id': aData.KS_DOITUONGTHAMGIAKHAOSAT_ID,
            'strNguoiThucHien_Id': edu.system.userId,
        };
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

                    $("#lblTieuDe").html(data.TENPHIEU)
                    $("#lblMoTaPhieu").html('<strong>' + edu.util.returnEmpty(data.LOAIPHIEU_TEN) + ':</strong> <span>' + edu.util.returnEmpty(data.MOTA) + '</span>');
                    $("body").addClass("ks-has-phieu");
                    me.dtNhom.push({ ID: null });
                    me.genTable_CauHoi();
                    me.dtCauHoi.forEach(e => me.genTable_DapAn(e))
                    me.genTable_KetQua();
                    me.getList_NhomAn(); // load phiếu xong → ẩn các nhóm theo đáp án đã chọn
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
            html += '<textarea id="' + objCauHoi.KS_KETQUAKHAOSAT_ID + '" name="' + objCauHoi.KS_KETQUAKHAOSAT_ID + '" class="form-control" rows="3" placeholder="Nhập câu trả lời của bạn..."></textarea>';
            html += '</div>';
            $("#answer" + objCauHoi.ID).html(html);
            return;
        }
        var bRadio = objCauHoi.KS_LOAICAUHOI_ID == "3";
        html += '<div class="ks-opts' + (objCauHoi.CACHHIENTHICAUHOI ? ' ks-opts-col' : '') + '">';
        dtResult.forEach(e => {
            html += '<label class="ks-opt" for="' + e.ID + '">';
            html += '<input class="form-check-input" type="' + (bRadio ? 'radio' : 'checkbox') + '" name="' + objCauHoi.KS_KETQUAKHAOSAT_ID + '" id="' + e.ID + '">';
            html += '<span class="ks-opt-mark ' + (bRadio ? 'is-radio' : 'is-check') + '"></span>';
            html += '<span class="ks-opt-text">' + e.TENDAPAN + '</span>';
            html += '</label>';
        });
        html += '</div>';
        $("#answer" + objCauHoi.ID).html(html);
    },

    genTable_KetQua: function (data) {
        var me = this;
        me.dtKetQua.forEach(e => {
            var strId = e.KS_CAUHOI_DAPAN_ID ? e.KS_CAUHOI_DAPAN_ID : e.KS_KETQUAKHAOSAT_ID;
            var point = $("#" + strId);
            point.attr('checked', true);
            point.prop('checked', true);
            point.val(e.DAPANKHAC)
        })
        me.update_TienDo();
    },
    
    save_KetQua: function (strKS_CauHoi_DapAn_Id, strDapAnKhac, strKS_KetQuaKhaoSat_Id) {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'KS_ThucHien/Them_KS_KetQuaTraLoi',
            'type': 'POST',
            'strKS_CauHoi_DapAn_Id': strKS_CauHoi_DapAn_Id,
            'strKS_KetQuaKhaoSat_Id': strKS_KetQuaKhaoSat_Id,
            'strKS_PhieuKhaoSat_Id': me.strKS_PhieuKhaoSat_Id,
            'strDapAnKhac': strDapAnKhac,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var strKeHoach_Id = "";
                    //if (!obj_save.strId) {
                    //    edu.system.alert("Thực hiện thành công!");
                    //}
                    //else {
                    //    edu.system.alert("Cập nhật thành công!");
                    //    strKeHoach_Id = obj_save.strId
                    //}
                    if (strKS_CauHoi_DapAn_Id) me.getList_NhomAn(); // lưu đáp án xong → cập nhật nhóm ẩn
                }
                else {
                    edu.system.alert(data.Message);
                }

            },
            error: function (er) {
                edu.system.alert(" (er): " + JSON.stringify(er), "w");

            },
            type: 'POST',

            contentType: true,

            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    delete_KetQua: function (strKS_CauHoi_DapAn_Id) {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'KS_ThucHien/Xoa_KS_KetQuaTraLoi_DapAn',
            'type': 'POST',
            'strKS_CauHoi_DapAn_Id': strKS_CauHoi_DapAn_Id,
            'strKS_PhieuKhaoSat_Id': me.strKS_PhieuKhaoSat_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        var obj_delete = obj_save; // code bên dưới dùng obj_delete (trước đây chưa khai báo → ReferenceError, bỏ tích không xóa được)
        var obj = {};
        //default

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    //obj = {
                    //    content: "Xóa thành công!",
                    //    code: ""
                    //};
                    //edu.system.alert("Xóa thành công!");
                    me.getList_NhomAn(); // bỏ chọn đáp án → cập nhật nhóm ẩn
                }
                else {
                    obj = {
                        content: obj_delete.action + ": " + data.Message,
                        code: ""
                    };
                    edu.system.afterComfirm(obj);
                }

            },
            error: function (er) {
                var obj = {
                    content: obj_delete.action + ": " + JSON.stringify(er),
                    code: "w"
                };
                edu.system.afterComfirm(obj);

            },
            type: 'POST',
            action: obj_delete.action,
            //complete: function () {
            //    edu.system.start_Progress("zoneprocessXXXX", function () {
            //        me.getList_DoiTuong();
            //    });
            //},
            contentType: true,

            data: obj_delete,
            fakedb: [
            ]
        }, false, false, false, null);
    },

    /*------------------------------------------
    --Discription: Bước nhảy theo đáp án — KHAOSAT_TAOPHIEU.LayDS_KS_NhomCauHoi_BiAn
    --  Trả về AN_KS_NHOMCAUHOI_ID các nhóm bị ẩn theo đáp án SV đã chọn → ẩn hẳn nhóm đó, còn lại hiện.
    -------------------------------------------*/
    getList_NhomAn: function () {
        var me = this;
        if (!me.strKS_PhieuKhaoSat_Id) return;
        var iLuot = me.iLuotNhomAn = (me.iLuotNhomAn || 0) + 1; // chỉ áp dụng kết quả của lần gọi mới nhất
        var obj_list = {
            'action': 'SV_KHAOSAT_TAOPHIEU_MH/DSA4BRIeChIeDykuLAIgNAkuKB4DKAAv',
            'func': 'KHAOSAT_TAOPHIEU.LayDS_KS_NhomCauHoi_BiAn',
            'iM': edu.system.iM,
            'strKS_PhieuKhaoSat_Id': me.strKS_PhieuKhaoSat_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (iLuot !== me.iLuotNhomAn) return;
                if (data.Success) {
                    me.arrNhomAn_Id = (data.Data || []).map(e => e.AN_KS_NHOMCAUHOI_ID).filter(e => e);
                    me.apply_NhomAn();
                }
                else {
                    console.warn("[LayDS_KS_NhomCauHoi_BiAn]", data.Message);
                }
            },
            error: function (er) {
                console.warn("[LayDS_KS_NhomCauHoi_BiAn] error:", er);
            },
            type: 'POST',
            contentType: true,
            action: obj_list.action,
            data: obj_list,
            fakedb: []
        }, false, false, false, null);
    },
    apply_NhomAn: function () {
        var me = this;
        $("#tblNoiDung .ks-nhom").each(function () {
            var strNhom_Id = $(this).attr("data-nhom-id");
            if (strNhom_Id && me.arrNhomAn_Id.includes(strNhom_Id)) $(this).hide();
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

    save_HoanThanh: function () {
        var me = this;
        
        var aData = me.dtDoiTuong.find(e => e.ID == me.strPhieu_Id);
        //--Edit
        var obj_save = {
            'action': 'KS_ThucHien/CapNhat_KS_DT_TGia_Duoc_KS',
            'type': 'POST',
            'strKS_DTTGKS_Id': aData.KS_DOITUONGTHAMGIAKHAOSAT_ID,
            'strKS_DTDKS_Id': aData.KS_DOITUONGDUOCKHAOSAT_ID,
            'strKS_PhieuKhaoSat_Id': aData.KS_PHIEUKHAOSAT_ID,
            'strKS_CSDL_HocPhan_Id': aData.KS_CSDL_HOCPHAN_ID,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var strKeHoach_Id = "";
                    //if (!obj_save.strId) {
                    //    edu.system.alert("Thực hiện thành công!");
                    //}
                    //else {
                    //    edu.system.alert("Cập nhật thành công!");
                    //    strKeHoach_Id = obj_save.strId
                    //}
                    
                }
                else {
                    edu.system.alert(data.Message);
                }

                me.getList_DoiTuong();
            },
            error: function (er) {
                edu.system.alert(" (er): " + JSON.stringify(er), "w");

            },
            type: 'POST',

            contentType: true,

            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
}