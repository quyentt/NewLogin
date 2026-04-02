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
            if (this.checked) {
                me.save_KetQua(this.id, "", $(this).attr("name"));
            } else {
                me.delete_KetQua(this.id)
            }
        });
        $("#tblNoiDung").delegate('.form-control', 'blur', function (e) {
            me.save_KetQua("", $(this).val(), $(this).attr("name"));
        });
        $(".btnLuuKetQua").click(function () {
            var iCount = 0;
            var dtBatBuoc = me.dtCauHoi.filter(e => e.CAUHOIBATBUOCTRALOI == 1);
            dtBatBuoc.forEach(e => {
                if (e.KS_LOAICAUHOI_ID == 2) {
                
                    if (!$("#" + e.KS_KETQUAKHAOSAT_ID).val()) iCount++;
                } else {
                    if (!$("#answer" + e.ID + " :checked").length) iCount++;
                }
            })
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
                    me.dtNhom.push({ ID: null });
                    me.genTable_CauHoi();
                    me.dtCauHoi.forEach(e => me.genTable_DapAn(e))
                    me.genTable_KetQua();
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
            if (iNhom) html += '<div class="line-1 bg-e1 mb-3"></div>';
            html += '<div>';
            if (oNhom.TEN) {
                html += '<div class="title">';
                html += oNhom.TEN;
                html += '</div>';
            }

            html += '<div class="question-group">';
            var dtCauHoiTheoNhom = me.dtCauHoi.filter(e => e.KS_NHOMCAUHOI_ID == oNhom.ID)
            dtCauHoiTheoNhom.forEach((oCauHoi, iCauHoi) => {
                html += '<div class="question">';
                html += '<b>Câu ' + (iCauHoi + 1) + ':</b> ' + oCauHoi.TENCAUHOI;
                html += oCauHoi.CAUHOIBATBUOCTRALOI ? '<span class="color-red">*</span>' : '';
                html += '</div>';
                html += '<div class="student-choose" id="answer' + oCauHoi.ID + '">';
                html += '</div>';
                
            })
            html += '</div>';
            html += '</div>';
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
            html += '<input type="text" id="' + objCauHoi.KS_KETQUAKHAOSAT_ID +'" name="' + objCauHoi.KS_KETQUAKHAOSAT_ID +'" class="form-control ps-3" />';
            html += '</div>';
            $("#answer" + objCauHoi.ID).html(html)
            return;
        }
        dtResult.forEach(e => {
            var strStyle = objCauHoi.CACHHIENTHICAUHOI ? 'width: 100%' : '';
            var typean = objCauHoi.KS_LOAICAUHOI_ID == "3" ? "radio": "checkbox";
            html += '<div class="form-check mb-2" style="' + strStyle + '">';
            html += '<input class="form-check-input" type="' + typean + '" name="' + objCauHoi.KS_KETQUAKHAOSAT_ID + '" id="' + e.ID + '">';
            html += '<label class="form-check-label" for="' + e.ID + '">';
            html += e.TENDAPAN;
            html += '</label>';
            html += '</div>';
        })
        $("#answer" + objCauHoi.ID).html(html)
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