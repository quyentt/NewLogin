/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function TheoDoiNhapHoc() { };
TheoDoiNhapHoc.prototype = {
    ilandau: 1,
    arrTimeCallDb: [0],
    swiper: null,
    arrHeadDiem_Id: [],
    dtCauTruc: [],
    dt_HS: [],
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "NH";
        me["isActive"] = true;
        window.onfocus = function () {
            me["isActive"] = true;
        };

        window.onblur = function () {
            me["isActive"] = false;
        };
        me.showDay();
        //me.showDay();
        getCauTruc();
        //if (edu.system.userId) {
        //    getCauTruc();
            
        //} else {
        //    //console.log(111111);
        //    //$("#btnDangNhapGiangDuong").trigger("click");
        //    $("#modal-sv-registration").modal("show")
        //}
        function getCauTruc() {
            console.log(me.isActive)
            if (me.isActive) me.getList_CauTruc();
            setTimeout(function () {
                getCauTruc();
                //console.log(me.dt_HS);
                //console.log(me.arrHeadDiem_Id);
                //me.dt_HS.forEach(e => me.arrHeadDiem_Id.forEach(ele => me.getList_Data(e.PHAMVIAPDUNG_ID, ele)));
            }, 20000)
        }
    },

    showDay: function () {
        var me = this;
        var date = new Date(Date.now());
        //console.log(date)
        var year = date.getFullYear();
        var month = edu.util.addZeroToDate(date.getMonth() + 1);
        var day = edu.util.addZeroToDate(date.getDate());
        var hour = edu.util.addZeroToDate(date.getHours());
        var minute = edu.util.addZeroToDate(date.getMinutes());
        var strDay = day + "/" + month + "/" + year;
        var iThu = date.getDay();
        iThu = iThu ? "Thứ " + (iThu + 1) : "Chủ nhật";
        $("#lblcurent_time").html(hour + ":" + minute + " " + iThu + " ngày " + strDay)
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
        }, 300000);
    },

    getList_CauTruc: function (strDanhSach_Id) {
        var me = this;
        if (me.dt_HS.length) {
            edu.system.genHTML_Progress("zoneprocessTheoDoi", (me.dt_HS.length * me.arrHeadDiem_Id.length));
            me.dt_HS.forEach(e => me.arrHeadDiem_Id.forEach(ele => me.getList_Data(e.PHAMVIAPDUNG_ID, ele)));
            return;
        }
        //--Edit
        var obj_list = {
            'action': 'NH_ThongKe/LayDSNhapHoc_CauTrucHienThi',
            'type': 'GET',
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.loadHead(dtReRult);
                    me.dtCauTruc = dtReRult;
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

    getList_HSSV: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'NH_ThongKe/LayDSDuLieuCauTrucHienThi',
            'type': 'GET',
            'strNguoiThucHien_Id': edu.system.userId,
        };


        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.dt_HS = data.Data;
                    me.genTable_HSSV(data.Data, data.Pager);
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
        var jsonForm = {
            strTable_Id: "tblTheoDoiNhapHoc",
            aaData: data,
            colPos: {
                center: [0]
            },
            bHiddenOrder: true,
            aoColumns: [{
                "mDataProp": "DOITUONG"
            },
            {
                "mDataProp": "PHAMVIAPDUNG_TEN",
            }
            ]
        };
        var arrSum = [];
        edu.system.arrId = [];
        for (var i = 0; i < me.arrHeadDiem_Id.length; i++) {
            if (me.arrHeadDiem_Id[i] != undefined && me.arrHeadDiem_Id[i] != "") {
                edu.system.arrId.push(me.arrHeadDiem_Id[i]);
                jsonForm.aoColumns.splice(2, 0, {
                    "mRender": function (nRow, aData) {
                        var istt = edu.system.icolumn++;
                        return '<span id="' + aData.PHAMVIAPDUNG_ID + "_" + edu.system.arrId[istt] + '"></span>';
                    }
                });
                //arrSum.push(i + 2);
            }
        }
        edu.system.loadToTable_data(jsonForm);
        edu.system.genHTML_Progress("zoneprocessTheoDoi", (data.length * me.arrHeadDiem_Id.length));
        data.forEach(e => me.arrHeadDiem_Id.forEach(ele => me.getList_Data(e.PHAMVIAPDUNG_ID, ele)));

        //edu.system.insertSumAfterTable(jsonForm.strTable_Id, arrSum)
        /*III. Callback*/
    },
    insertHeaderTable: function (strTable_Id, obj, strQuanHeCha) {
        //Khởi tạo table
        $("#" + strTable_Id).html('<thead style="font-weight: bold"><tr><td>Đối tượng</td><td>Ngành học</td></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr><tr></tr></thead><tbody></tbody><tfoot></tfoot>');

        var arrHeaderId = [];
        //Lấy toàn bộ phần tử gốc đầu tiền xong gọi đệ quy load header table theo công thức điểm
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].THANHPHAN_CHA_ID == strQuanHeCha) {
                recuseHeader(obj, obj[i], 0);
            }
        }
        //Add rowspan cho các thành phần không có phần từ con
        //rowspan = rowTheadOfTable - colspan
        var x = document.getElementById(strTable_Id).getElementsByTagName("thead")[0].rows;
        for (var i = 0; i < x.length; i++) {
            for (var j = 0; j < x[i].cells.length; j++) {
                var z = x[i].cells[j].colSpan;
                if (z == 1) {
                    var irowspan = (x.length - i);
                    if (irowspan > 1) x[i].cells[j].rowSpan = (x.length - i);
                }
            }
        }
        //Hàm đề quy insert các phần tử con ra thead (datatable của công thức, phần từ cha cần đệ quy, số thứ tự dòng của phần tử cha trong thead)
        //Nguyên tắc: rowspan phần tử cha = sum(rowspan phần tử con) -1;
        function recuseHeader(objAll, objRecuse, iBac) {
            var x = spliceData(objAll, objRecuse.THANHPHAN_ID);
            var iTong = x.length;
            for (var j = 0; j < x.length; j++) {
                var iSoLuong = spliceData(objAll, x[j].THANHPHAN_ID);
                if (iSoLuong.length > 0) {
                    var iDem = recuseHeader(objAll, x[j], iBac + 1);
                    iTong += iDem - 1;
                }
                else {
                    insertHeader(strTable_Id, x[j], iBac + 1, iSoLuong.length);
                }
            }
            insertHeader(strTable_Id, objRecuse, iBac, iTong);
            return iTong;
        }

        function insertHeader(strTable_Id, objHead, iThuTu, colspan) {
            //Kiểm tra số dòng nếu nhỏ hơn số thứ tự dòng iThuTu thì thêm 1 dòng
            //var lHeader = document.getElementById(strTable_Id).getElementsByTagName("thead")[0].rows;
            //if (lHeader.length <= iThuTu) {
            //    $("#" + strTable_Id + " thead").append("<tr></tr>");
            //    setTimeout(function () {
            //        $("#" + strTable_Id + " thead tr:eq(" + iThuTu + ")").append("<th class='td-center' id='" + objHead.ID + "' colspan='" + colspan + "'>" + objHead.HOCPHAN + "</th>");
            //    }, 1);
            //} else {
            //    $("#" + strTable_Id + " thead tr:eq(" + iThuTu + ")").append("<th class='td-center' id='" + objHead.ID + "' colspan='" + colspan + "'>" + objHead.HOCPHAN + "</th>");
            //}
            $("#" + strTable_Id + " thead tr:eq(" + iThuTu + ")").append("<th class='td-center' id='" + objHead.THANHPHAN_ID + "' colspan='" + colspan + "'>" + objHead.THANHPHAN_TEN + "</th>");
            if (colspan == 0) {
                arrHeaderId.push(objHead.THANHPHAN_ID);
                //$("#" + strTable_Id + "_Data thead tr:eq(0)").append("<th style='width: 60px'>" + objHead.HOCPHAN + "</th>");
            }
        }
        //Lấy số con của thằng cha trong datatable công thức
        function spliceData(objData, strQuanHeCha_Id) {
            var arr = [];
            var iLength = objData.length;
            for (var i = 0; i < iLength; i++) {
                if (objData[i].THANHPHAN_CHA_ID == strQuanHeCha_Id) {
                    arr.push(objData[i]);
                }
            }
            return arr;
        }
        return arrHeaderId;
    },
    loadHead: function (data) {
        var me = this;
        me.arrHeadDiem_Id = me.insertHeaderTable("tblTheoDoiNhapHoc", data, null);
        me.getList_HSSV();
    },
    getList_Data: function (strPhamViApDung_Id, strThanhPhan_Id) {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'NH_ThongKe/LayDSDuLieuHienThiKetQua',
            'type': 'GET',
            'strPhamViApDung_Id': strPhamViApDung_Id,
            'strThanhPhan_Id': strThanhPhan_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    for (var i = 0; i < dtReRult.length; i++) {
                        var aData = dtReRult[i];
                        $("#" + strPhamViApDung_Id + "_" + strThanhPhan_Id).html(edu.util.formatCurrency(aData.THANHPHAN_GIATRI));
                        $("#" + strPhamViApDung_Id + "_" + strThanhPhan_Id).parent().css({ "text-align": "right" });
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
            complete: function () {
                edu.system.start_Progress("zoneprocessTheoDoi", function () {
                    var arrSum = [];
                    var i = 3;
                    me.arrHeadDiem_Id.forEach((e, index) => {
                        if (e) arrSum.push(i++);
                    })
                    console.log(arrSum);
                    edu.system.insertSumAfterTable("tblTheoDoiNhapHoc", arrSum);
                    $("#tblTheoDoiNhapHoc tfoot td:eq(1)").remove();
                    $("#tblTheoDoiNhapHoc tfoot").css({ "text-align": "right" });
                    //$("#tblTheoDoiNhapHoc tfoot td:eq(" + (arrSum.length + 1) + ")").hide();
                });
            },
            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
}