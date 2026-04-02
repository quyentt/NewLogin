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
            me.getList_ChungChi();
        });
        $("#btnSearch_KetQua").click(function () {
            me.getList_KetQua();
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