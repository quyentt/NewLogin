/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function TraCuuChungChi() { };
TraCuuChungChi.prototype = {
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "NH";
        $("#btnSearch_ChungChi").click(function () {
            if ($.trim(edu.util.getValById('txtSearch_SoChungChi')) == "") {
                edu.system.alert("Vui lòng nhập số hiệu chứng chỉ");
                $("#txtSearch_SoChungChi").focus();
                return;
            }
            me.getList_ChungChi();
        });
        $("#btnSearch_KetQua").click(function () {
            if ($.trim(edu.util.getValById('txtSearch_SoBaoDanh')) == "") {
                edu.system.alert("Vui lòng nhập số báo danh");
                $("#txtSearch_SoBaoDanh").focus();
                return;
            }
            var strNgaySinh = $.trim(edu.util.getValById('txtSearch_NgaySinh'));
            if (!/^\d{2}\/\d{2}\/\d{4}$/.test(strNgaySinh)) {
                edu.system.alert("Vui lòng nhập ngày sinh theo định dạng dd/mm/yyyy");
                $("#txtSearch_NgaySinh").focus();
                return;
            }
            me.getList_KetQua();
        });
        // Nhấn Enter để tra cứu
        $("#txtSearch_SoBaoDanh, #txtSearch_NgaySinh").on("keydown", function (e) {
            if (e.keyCode == 13) $("#btnSearch_KetQua").click();
        });
        $("#txtSearch_SoChungChi").on("keydown", function (e) {
            if (e.keyCode == 13) $("#btnSearch_ChungChi").click();
        });
        // Tự chèn dấu "/" khi nhập ngày sinh: 05092003 -> 05/09/2003
        $("#txtSearch_NgaySinh").on("input", function () {
            var v = this.value.replace(/\D/g, "").substring(0, 8);
            if (v.length > 4) v = v.substring(0, 2) + "/" + v.substring(2, 4) + "/" + v.substring(4);
            else if (v.length > 2) v = v.substring(0, 2) + "/" + v.substring(2);
            this.value = v;
        });
    },
    getList_ChungChi: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'SV_VanBang_ChungChi_TraCuu/CC_TraCuuThongTin_02',
            'type': 'GET',
            'strSoHieu': edu.util.getValById('txtSearch_SoChungChi'),
            'strPhanLoai_Id': "CC",
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genTable_KetQua(data.Data, "tblChungChi");
                }
                else {
                    edu.system.alert(data.Message)
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
    getList_KetQua: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'SV_VanBang_ChungChi_TraCuu/CC_TraCuuThongTin_01',
            'type': 'GET',
            'strSoBaoDanh': edu.util.getValById('txtSearch_SoBaoDanh'),
            'strNgaySinh': edu.util.getValById('txtSearch_NgaySinh'),
            'strPhanLoai_Id': "DIEM",
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genTable_KetQua(data.Data, "tblKetQua");
                }
                else {
                    edu.system.alert(data.Message)
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
    genTable_KetQua: function (data, strTable_Id) {
        var me = this;
        var row = '';
        var strSuffix = strTable_Id.replace("tbl", "");
        var iSoLuong = (data && data.rsThongTinThiSinh) ? data.rsThongTinThiSinh.length : 0;
        if (iSoLuong == 0) {
            $("#" + strTable_Id + " thead tr:eq(0)").html('');
            $("#" + strTable_Id + " tbody").html('');
            $("#cnt" + strSuffix).text('');
            $("#empty" + strSuffix).show()
                .find("h3").text("Không tìm thấy kết quả").end()
                .find("p").text("Vui lòng kiểm tra lại thông tin đã nhập.");
            return;
        }
        $("#empty" + strSuffix).hide();
        $("#cnt" + strSuffix).text(iSoLuong + " kết quả");
        data.rsThongTinCotHienThi.forEach(aData => {
            row += '<th scope="col" class="text-center">' + edu.util.returnEmpty(aData.THANHPHAN_TEN) + '</th>';
        })
        $("#" + strTable_Id + " thead tr:eq(0)").html(row);
        row = '';
        data.rsThongTinThiSinh.forEach(aDataSV => {
            row += '<tr>';
            data.rsThongTinCotHienThi.forEach(aDataTP => {
                row += '<td class="mobi-flex text-center"><em class="show-in-mobi">' + edu.util.returnEmpty(aDataTP.THANHPHAN_TEN) + ':</em> <span id="lbl' + aDataSV.QLSV_NGUOIHOC_ID + '_' + aDataTP.THANHPHAN_ID +'"></span></td>';
            })
            row +='</tr>';
        })
        $("#" + strTable_Id + " tbody").html(row);
        data.rsThongTinThiSinh.forEach(aDataSV => {
            data.rsThongTinCotHienThi.forEach(aDataTP => {
                me.getList_GiaTri(aDataSV.QLSV_NGUOIHOC_ID, aDataTP.THANHPHAN_ID, strTable_Id)
            })
        })
    },
    getList_GiaTri: function (strQLSV_NguoiHoc_Id, strThanhPhan_Id, strTable_Id) {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'SV_VanBang_ChungChi_TraCuu/LayGiaTri',
            'type': 'GET',
            'strThanhPhan_Id': strThanhPhan_Id,
            'strQLSV_NguoiHoc_Id': strQLSV_NguoiHoc_Id,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    data.Data.forEach(aData => {

                        $("#" + strTable_Id + " #lbl" + strQLSV_NguoiHoc_Id + "_" + strThanhPhan_Id).html(edu.util.returnEmpty(aData.THANHPHAN_GIATRI));
                    })
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
}