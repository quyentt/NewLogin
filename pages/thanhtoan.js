/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function ThanhToan() { };
ThanhToan.prototype = {
    strMa: '',
    strKhongChoPhepSuaSoTien: '',
    strMaGiaoDich: '',
    strHSSV_Id: '',
    strChuongTrinh_Id: '',
    dtTinhTrangTaiChinh: [],
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "KS";
        const urlParams = new URLSearchParams(window.location.search);
        me.strMa = urlParams.get('strMa');
        me.getList_Token();
        //me.getList_KeHoachCT();
        me.getList_drpNganHang();
        if (edu.system.strhost.indexOf('spmph') != -1) {
            edu.system.loadToCombo_DanhMucDuLieu("TAICHINH.NUTHDDT", "", "", data => {
                me["dtNutHDDT"] = data;
                var row = '';
                for (var i = 0; i < data.length; i++) {
                    row += '<div class="btn btn-dask-blue btnXuat_HDDT" id="' + data[i].ID + '" title="' + data[i].MA + '" name="' + data[i].THONGTIN2 + '" style="margin-right: 5px"><i class="fal fa-paper-plane me-2"></i>' + data[i].TEN + '</div>'
                }
                $("#lblNutHDDT").html(row)
            });
        }

        $("#btnSearch").click(function () {
            if (edu.util.getValById("txtSearch") == "") {
                edu.system.alert("Bạn chưa nhập mã");
                return;
            }
            me.getList_tblThanhToan();
        });
        $("#txtSearch").keypress(function (e) {
            if (e.which === 13) {
                e.preventDefault();
                if (edu.util.getValById("txtSearch") == "") {
                    edu.system.alert("Bạn chưa nhập mã");
                    return;
                }
                me.getList_tblThanhToan();
            }
        });
        me.eventTongTien("tblThanhToan");
        $("#tblThanhToan").delegate(".inputsotien", "keyup", function (e) {
            var check = edu.system.checkSoTienInput(this, false);
            if (!check) return;
            me.show_TongTien("tblThanhToan");
        });
        $("[id$=chkSelectAll_ThanhToan]").on("click", function () {
            edu.util.checkedAll_BgRow(this, { table_id: "tblThanhToan" });
        });
        $("#btnThucHienThanhToan").click(function () {

            if (edu.util.getValById("drpNganHang") == "" || edu.util.getValById("drpNganHang") == undefined) {
                edu.system.alert("Vui lòng chọn ngân hàng để thanh toán");
                return;
            }

            var arrChecked_Id = edu.util.getArrCheckedIds("tblThanhToan", "checkX");
            if (arrChecked_Id.length == 0) {
                edu.system.alert("Vui lòng chọn khoản cần thanh toán");
                return;
            }
            var strNganHang = edu.util.getValById("drpNganHang");
            if (strNganHang.indexOf("_") != -1) strNganHang = strNganHang.split('_')[0];
            if ("#BIDV#SHB#VTB#VIB#VTB2#VCB".indexOf(strNganHang) != -1) {
                me.save_ThanhToanDonHang(arrChecked_Id.toString());
                return;
            }

            edu.system.confirm("Bạn có chắc chắn thanh toán?");
            function getSoTien(dSoTien, dRecovery) {
                //var dSoTien = $("#lbThanhTien" + strId).html();
                dSoTien = dSoTien.replace(/ /g, "").replace(/,/g, "");
                dSoTien = parseFloat(dSoTien);
                return (typeof (dSoTien) == 'number') ? dSoTien : dRecovery;
            }
            $("#btnYes").click(function (e) {
                me.strErr = "";
                var DonHangChiTietIds = "";
                var SoTiens = "";
                var NoiDungs = me.strMaSinhVien + "_" + edu.util.getValById("drpNganHang") + "_";
                var strclientIP = "";
                for (var i = 0; i < arrChecked_Id.length; i++) {
                    var dt = edu.util.objGetDataInData(arrChecked_Id[i], me.dtThanhToan, "ID");
                    DonHangChiTietIds += arrChecked_Id[i] + "|";
                    // NoiDungs += dt[0].NOIDUNG + "^";  
                    SoTiens += getSoTien(edu.util.getValById("txtSoTien" + arrChecked_Id[i]), 0) + "|";

                }

                if (arrChecked_Id.length > 0) {
                    DonHangChiTietIds = DonHangChiTietIds.substr(0, DonHangChiTietIds.length - 1);
                    SoTiens = SoTiens.substr(0, SoTiens.length - 1);
                    NoiDungs += DonHangChiTietIds + "^";
                    NoiDungs = NoiDungs.substr(0, NoiDungs.length - 1);
                }

                me.ThucHienThanhToan(DonHangChiTietIds, SoTiens, NoiDungs);
            });
        });


        $("#tblThanhToan").delegate(".checkchange", "click", function (e) {
            var sum = edu.system.countFloat("tblThanhToan", 3, 5);
            var strTongThu = "Tổng tiền đã chọn: <span id='lblTongTienDaChon'>" + edu.util.formatCurrency(sum) + "</span>";
            $("#lbSoTienDaChon").html(strTongThu);
        });

        $(".btnDetail_KhoanPhaiNop").click(function () {
            $("#lblLoaiKhoanThu").html(" khoản phải nộp");
            $("#finance_detail").modal("show");
            me.getList_KhoanPhaiNop();
        });
        $(".btnDetail_KhoanDuocMien").click(function () {
            $("#lblLoaiKhoanThu").html(" khoản được miễn");
            $("#finance_detail").modal("show");
            me.getList_KhoanDuocMien();
        });
        $(".btnDetail_KhoanDaNop").click(function () {
            $("#lblLoaiKhoanThu").html(" khoản đã nộp");
            $("#finance_detail").modal("show");
            me.getList_KhoanDaNop();
        });
        $(".btnDetail_KhoanDaRut").click(function () {
            $("#lblLoaiKhoanThu").html(" khoản đã rút");
            $("#finance_detail").modal("show");
            me.getList_KhoanDaRut();
        });

        $(".btnDetail_PhieuHoaDon").click(function () {
            $("#lblLoaiKhoanThu").html(" hóa đơn");
            $("#finance_detail").modal("show");
            me.getList_PhieuHoaDon();
        });
        $("#tblChiTietKhoan").delegate('.detail_PhieuHoaDon', 'click', function (e) {
            e.stopImmediatePropagation();
            var strPhieuThu_Id = this.id;
            edu.extend.getData_Phieu(strPhieuThu_Id, "HOADON", "MauInPhieuThu");
        });
        $(document).delegate(".btnXuat_HDDT", "click", function (e) {
            e.stopImmediatePropagation();
            var arrChecked_Id = edu.util.getArrCheckedIds("tbldata_HoaDon", "checkX");
            if (arrChecked_Id.length == 0) {
                edu.system.alert("Vui lòng chọn đối tượng?");
                return;
            }

            $("#lblNutHDDT").hide();
            var strId = this.id
            var xCheck = me.dtNutHDDT.find(e => e.ID === strId);
            if (xCheck && xCheck.THONGTIN4) edu.system.objApi["HDDT"] = xCheck.THONGTIN4;
            var strLinkAPI = edu.system.strhost + edu.system.objApi["HDDT"].replace(/api/g, ''); //$(this).attr("name");
            //edu.system.objApi["HDDT"].replace(/api/g, '') = strLinkAPI;
            var strPhuongThuc_Ma = $(this).attr("title");
            if (strPhuongThuc_Ma.indexOf("HDDTNHAP") == 0) {
                me.save_ChungTu("HDDTNHAP", strLinkAPI, strPhuongThuc_Ma);
            } else {
                me.save_ChungTu("HDDT", strLinkAPI, strPhuongThuc_Ma);
            }
        });
        $("#btnAdd_NopTruoc").click(function () {
            $("#modalKhoanNopTruoc").modal("show")
        });
        $("#btnSave_KhoanNopTruoc").click(function () {
            me.save_KhoanNopTruoc();
        });
        $("#btnDelete_NopTruoc").click(function () {
            var arrChecked_Id = edu.util.getArrCheckedIds("tblThanhToan", "checkX");
            if (arrChecked_Id.length == 0) {
                edu.system.alert("Vui lòng chọn đối tượng cần xóa?");
                return;
            }
            edu.system.confirm("Bạn có chắc chắn xóa dữ liệu không?");
            $("#btnYes").click(function (e) {
                edu.system.alert('<div id="zoneprocessXXXX"></div>');
                edu.system.genHTML_Progress("zoneprocessXXXX", arrChecked_Id.length);
                for (var i = 0; i < arrChecked_Id.length; i++) {
                    me.delete_KhoanNopTruoc(arrChecked_Id[i]);
                }
            });
        });

        $("#modalKhoanNopTruoc").delegate(".inputsotien", "keyup", function (e) {
            let temp = $(this).val();
            $(this).val(edu.util.formatCurrencyV2(temp));
        });
        me.getList_CauHinhTuKhoa("CONGTHANHTOAN");
    },
    pageLoad: function () {
        var me = this;
        if (me.strMa) {
            $("#txtSearch").val(me.strMa);
            $("#btnSearch").trigger("click");
            window.history.pushState("object or string", "Title", "/" + window.location.href.substring(window.location.href.indexOf('/') + 1).split("?")[0]);
        }
        me.getList_KhoanNopTruoc();
    },

    getList_Token: function (strNgayHoc) {
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
                    me.pageLoad();
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

    getList_KeHoachCT: function () {
        var me = this;
        var obj_list = {
            'action': 'TS_KeHoachTuyenSinhCongKhai/LayDanhSach',
            'type': 'GET',
        };


        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genCombo_KeHoachCT(data.Data);
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
    genCombo_KeHoachCT: function (data) {
        console.log(data)
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "TEN",
                selectOne: true,
            },
            renderPlace: ["dropSearch_KeHoach"],
            title: "Chọn kế hoạch"
        };
        edu.system.loadToCombo_data(obj);
    },

    getList_drpNganHang: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'CM_DanhMucDuLieu/LayDanhSach',
            'versionAPI': 'v1.0',
            'strMaBangDanhMuc': 'VNPAY.NGANHANG',
        }

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genList_drpNganHang(data.Data);
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) { },
            type: "GET",
            contentType: true,
            action: obj_list.action,
            data: obj_list,
        }, false, false, false, null);
    },
    genList_drpNganHang: function (data) {
        var obj = {
            data: data,
            renderInfor: {
                id: "MA",
                parentId: "",
                name: "THONGTIN1",
                code: "THONGTIN2",
                avatar: "",
                //selectFrist: true,
            },
            renderPlace: ["drpNganHang"],
            type: "",
            title: "Chọn ngân hàng"
        };
        edu.system.loadToCombo_data(obj);


        if (data.length > 0) {
            $("#drpNganHang").val(data[0].MA).trigger("change");
        }
    },

    getList_tblThanhToan: function () {
        var me = this;
        $("#tblThanhToan tfoot").html("");
        //--Edit 
        var obj_save = {
            'action': 'TC_ThanhToan_MH/DSA4FSkuLyYVKC8VICgCKSgvKQPP',
            'func': 'pkg_thanhtoan.LayThongTinTaiChinh',
            'iM': edu.system.iM,
            'strMaSinhVien': edu.util.getValById('txtSearch'),
            'strMaNganHang': "VNPAY",
        };


        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.dtThanhToan = data.Data.rsChiTiet;
                    edu.util.viewHTMLById("lblHoTen1", data.Data.rsSinhVien[0].HOVATEN);
                    edu.util.viewHTMLById("lblMaSinhVien", data.Data.rsSinhVien[0].MASINHVIEN);
                    edu.util.viewHTMLById("lblNgaySinh", data.Data.rsSinhVien[0].NGAYSINH);
                    edu.util.viewHTMLById("lblLopQuanLy", data.Data.rsSinhVien[0].LOP);
                    edu.util.viewHTMLById("lblNganh", data.Data.rsSinhVien[0].NGANH);
                    edu.util.viewHTMLById("lblKhoa", data.Data.rsSinhVien[0].KHOADAOTAO);
                    me.MaDonHang_Gui_NganHang = data.Data.rs[0].MADONHANG_GUI_NGANHANG;
                    me.strCreatedDate = data.Data.rs[0].NGAYTAODONHANG;
                    me.strMaSinhVien = data.Data.rsSinhVien[0].MASINHVIEN;
                    me.strChuongTrinh_Id = data.Data.rsSinhVien[0].DAOTAO_TOCHUCCHUONGTRINH_ID;
                    me.genTable_tblThanhToan(data.Data.rsChiTiet);

                    me["dtVanTin"] = data.Data;
                    if (data.Data.rsSinhVien && data.Data.rsSinhVien.length > 0) {
                        $("#zonekosv").slideUp();
                        $("#zonecosv").slideDown();
                        setTimeout(function () {
                            window.scroll({
                                top: 200,
                                behavior: "smooth",
                            });
                        }, 500)

                    } else {
                        $("#zonecosv").slideUp();
                        $("#zonekosv").slideDown();
                    }
                    me.strHSSV_Id = data.Data.rsSinhVien[0].ID;
                    me.getList_TinhTrangTaiChinh();
                }
                else {
                    me.dtThanhToan = null;
                    edu.util.viewHTMLById("lblHoTen1", "");
                    edu.util.viewHTMLById("lblMaSinhVien", "");
                    edu.util.viewHTMLById("lblNgaySinh", "");
                    edu.util.viewHTMLById("lblLopQuanLy", "");
                    edu.util.viewHTMLById("lblNganh", "");
                    edu.util.viewHTMLById("lblKhoa", "");
                    me.MaDonHang_Gui_NganHang = null;
                    me.strCreatedDate = "";
                    me.strMaSinhVien = "";
                    me.genTable_tblThanhToan(null);

                    me["dtVanTin"] = null;
                    edu.system.alert(data.Message, "w");

                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er), "w");

            },
            type: "POST",
            action: obj_save.action,
            contentType: true,
            authen: true,
            data: obj_save,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    genTable_tblThanhToan: function (data) {
        var me = this;
        var jsonForm = {
            strTable_Id: "tblThanhToan",
            aaData: data,
            sort: true,
            bHiddenOrder: true,
            colPos: {
                center: [0, 1, 2, 3, 5],
            },
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<span>' + (nRow + 1) + '</span>';
                    }
                },
                {
                    "mRender": function (nrow, aData) {
                        return '<span id="lblNoiDung' + aData.ID + '">' + edu.util.returnEmpty(aData.NOIDUNG) + '</span>';
                    }
                },
                {
                    "mRender": function (nrow, aData) {
                        var strHTML = "";
                        strHTML = '<input type="text" disabled id="txtSoTien' + aData.ID + '" name="' + edu.util.formatCurrency(aData.SOTIEN) + '" value="' + edu.util.formatCurrency(aData.SOTIEN) + '" class="inputsotien" style="width: 100px;text-align: right"  />';

                        if (me.strKhongChoPhepSuaSoTien == "0")
                            strHTML = '<input type="text"  id="txtSoTien' + aData.ID + '" name="' + edu.util.formatCurrency(aData.SOTIEN) + '" value="' + edu.util.formatCurrency(aData.SOTIEN) + '" class="inputsotien" style="width: 100px"  />';
                        return strHTML;
                    }
                },
                {
                    "mData": "GHICHU",
                    "mRender": function (nrow, aData) {
                        return '<span>' + edu.util.returnEmpty(aData.GHICHU) + '</span>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<input class="checkchange" type="checkbox"  name="' + aData.ID + '" checked="checked" id="checkX' + aData.ID + '"/>';
                    }
                }


            ]
        };
        edu.system.loadToTable_data(jsonForm);
        $("#tblThanhToan tfoot").html("");
        edu.system.insertSumAfterTable("tblThanhToan", [3]);


        $("#tblThanhToan" + " tfoot tr td:eq(3)").attr("style", "text-align: center; font-size: 20px; padding-right: 20px");
        $("#tblThanhToan" + " tfoot tr td:eq(0)").attr("style", "display: none");
        setTimeout(() => {
            if (Array.isArray(data)) {
                data.forEach(e => {
                    if (e.BATBUOC == 1) {
                        var x = $("#tblThanhToan #checkX" + e.ID);
                        if (x.length > 0) {
                            $(x).prop('checked', true);
                            $(x).prop('disabled', true);
                            $("#chkSelectAll_ThanhToan").hide();
                        }
                    }
                });
            }
        }, 100);
        setTimeout(function () {
            var sum = edu.system.countFloat("tblThanhToan", 3, 5);
            var strTongThu = "Tổng tiền đã chọn: <span id='lblTongTienDaChon'>" + edu.util.formatCurrency(sum) + "</span>";
            $("#lbSoTienDaChon").html(strTongThu);
        }, 300);


        /*III. Callback*/
    },
    show_TongTien: function (strTableId) {
        //Tìm tất cả checkbox đang check trong bảng loại bỏ phần dư thừa rồi cộng lại để hiện tổng trên cùng cạnh sinh viên
        setTimeout(function () {
            var sum = edu.system.countFloat(strTableId, 3);
            edu.system.insertSumAfterTable(strTableId, [3]);
        }, 100);
    },

    getList_CauHinhThanhToan: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'CM_DanhMucDuLieu/LayDanhSach',
            'versionAPI': 'v1.0',
            'strMaBangDanhMuc': 'VNPAY.CAUHINHTHANHTOAN',
        }

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.strKhongChoPhepSuaSoTien = "1";

                    if (data.Data.length > 0) {
                        var dt = edu.util.objGetDataInData("KHONGCHOPHEPSUASOTIEN", data.Data, "MA");
                        if (dt.length > 0)
                            me.strKhongChoPhepSuaSoTien = dt[0].THONGTIN1;
                    }
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) { },
            type: "GET",
            contentType: true,
            action: obj_list.action,
            data: obj_list,
        }, false, false, false, null);
    },
    save_ThanhToanDonHang: function (strThanhToan_DonHang_CT_Id) {
        var me = this;
        var obj_notify = {};
        //--Edit
        var obj_save = {
            'action': 'TC_TCThanhToan/XacNhanThanhToanDonHang',
            'type': 'POST',
            'strThanhToan_DonHang_CT_Id': strThanhToan_DonHang_CT_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    //obj_notify = {
                    //    type: "s",
                    //    content: "Thêm mới thành công!",
                    //}
                    //edu.system.alertOnModal(obj_notify);
                    me.strMaGiaoDich = data.Data;
                    me.getList_QRCode(data.Data);
                }
                else {
                    obj_notify = {
                        type: "w",
                        content: obj_save.action + " (er): " + data.Message,
                    }
                    edu.system.alertOnModal(obj_notify);
                }
            },
            error: function (er) {
                edu.system.alertOnModal(obj_notify);
            },
            type: "POST",
            action: obj_save.action,

            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    getList_QRCode: function (code) {
        var me = this;
        var strMaSinhVien = me.dtVanTin.rs[0].MASINHVIEN;
        var strHoTen = me.dtVanTin.rs[0].HOVATEN;
        var strTkAo = me.dtVanTin.rs[0].TKAO;
        var dSoTien = 0;
        var arrChecked_Id = edu.util.getArrCheckedIds("tblThanhToan", "checkX");
        arrChecked_Id.forEach(e => {
            dSoTien += parseFloat(me.dtThanhToan.find(ele => ele.ID == e).SOTIEN);
        })
        var serviceId = $("#drpNganHang option:selected").attr("name").replace(/null/g, '');
        var strName = $("#drpNganHang").val();
        if (strName.indexOf("_") != -1) strName = strName.split('_')[0];
        var obj_notify = {};
        var strVal = {};
        console.log(arrChecked_Id[0]);
        console.log(me.dtVanTin.rsChiTiet);

        var strNoiDung = me.dtVanTin.rsChiTiet.find(e => e.ID == arrChecked_Id[0]).NOIDUNG;
        strNoiDung = edu.system.change_alias(strNoiDung);
        var dateServer = edu.util.getServerTime();
        var date = new Date(dateServer);
        var year = date.getFullYear();
        var month = edu.util.addZeroToDate(date.getMonth() + 1);
        var day = edu.util.addZeroToDate(date.getDate());
        var hour = edu.util.addZeroToDate(date.getHours());
        var minute = edu.util.addZeroToDate(date.getMinutes());
        var second = edu.util.addZeroToDate(date.getSeconds());
        var strNoiDung2 = strMaSinhVien + " " + edu.system.change_alias(strHoTen)
        switch (strName) {
            case "BIDV": strVal = {
                "serviceId": serviceId,
                "code": code,
                "name": strMaSinhVien + " " + strHoTen,
                "amount": dSoTien.toString(),
                "description": strNoiDung.replace(/_/g, ' ')
            }; break;
            case "VTB": strVal = {
                "requestId": edu.util.uuid(),
                "providerId": "DHLAMNGHIEP",
                "merchantId": "0500465853",
                "clientDt": year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + ".632Z",
                "channel": "internal",
                "version": "0.0.1",
                "language": "en",
                "clientIP": "",
                "signature": "JcJg4S7qF8G3B9OlJQoZsGx8dtyPDmsYKNub6hCZFh51tnnRG+1Up/R0mtmGWoOxsqGTdIWSdGwiqxrOvsRPH62Elz9JAYDT1RHphlemrmxcy+4YWihPYOEGIhn8kfCq+LiMKatort3xPDT6G4DTsVmnY29MyIkA/vgDe8br39v7kN6n7URuMWJzsEiO4xjmPk8ZUmobkTJrkxPgLAX+K9MTZ9xCg2iQNj3QInG/fzEo/3J+VhlN4uGl3wdgaaUontRc40GfqGFtyuS+gPsH84kyeMF8L3FRKyQ1WnqyhLsuM4hY2dd1H3g7kWghzXOPhrkYLUxQEB0gS0m8Sh3FNA==",
                "data": {
                    "merchantName": "DHLAMNGHIEP",
                    "terminalId": "TDHLAMNGHIEP",
                    "productId": "",
                    "orderId": code,
                    "amount": dSoTien,
                    "payMethod": "QR",
                    "transactionDate": year + month + day + hour + minute + second,
                    "currencyCode": "VND",
                    "remark": strNoiDung,
                    "transTime": year + month + day + hour + minute + second,
                    "imageSize": "200"
                }
            }; break;

            case "VTB2": strVal = {
                "requestId": edu.util.uuid(),
                "providerId": "",
                "merchantId": "",
                "clientDt": year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second + ".632Z",
                "channel": "internal",
                "version": "0.0.1",
                "language": "en",
                "clientIP": "",
                "signature": "JcJg4S7qF8G3B9OlJQoZsGx8dtyPDmsYKNub6hCZFh51tnnRG+1Up/R0mtmGWoOxsqGTdIWSdGwiqxrOvsRPH62Elz9JAYDT1RHphlemrmxcy+4YWihPYOEGIhn8kfCq+LiMKatort3xPDT6G4DTsVmnY29MyIkA/vgDe8br39v7kN6n7URuMWJzsEiO4xjmPk8ZUmobkTJrkxPgLAX+K9MTZ9xCg2iQNj3QInG/fzEo/3J+VhlN4uGl3wdgaaUontRc40GfqGFtyuS+gPsH84kyeMF8L3FRKyQ1WnqyhLsuM4hY2dd1H3g7kWghzXOPhrkYLUxQEB0gS0m8Sh3FNA==",
                "data": {
                    "accountNumber": edu.util.returnEmpty(serviceId) + code,
                    "amount": "" + dSoTien,
                    "storeLabel": code,
                    "referenceLabel": code,
                    "customerLabel": code,
                    "msgId": code,
                    "purposeOfTrans": strNoiDung2.substring(0, 70),
                    "terminalLabel": "1"
                }
            }; break;
            default: strVal = {
                "strMaSinhVien": strMaSinhVien,
                "strHoVaTen": strHoTen,
                "strMaDonHang": code,
                "strNoiDung": strNoiDung,
                "strNoiDung2": strNoiDung2,
                "strTaiKhoanAo": strTkAo,
                "strSoTien": dSoTien.toString()
            }; break;
        }



        //--Edit
        var obj_save = {
            'action': 'CTT_' + strName + 'Payment/VanTinQRCode',
            'type': 'POST',
            'strKey': '',
            'strVal': JSON.stringify(strVal),
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //return;
        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    if (data.Success) {
                        me.getList_tblThanhToan();
                        var strQRData = "";
                        var iBase64 = true;
                        switch (strName) {
                            case "BIDV": {
                                var obj = JSON.parse(data.Data);
                                if (obj.errorCode) {
                                    if (obj.errorCode == "000") {
                                        strQRData = obj.vietQRImage;

                                    } else {
                                        edu.system.alert("Lỗi :" + obj.errorCode + " : " + obj.errorDesc);
                                        return;
                                    }
                                } else {
                                    if (obj.msg.header.errorCode == "000") {
                                        strQRData = obj.msg.body.vietQRImage;

                                    } else {
                                        edu.system.alert("Lỗi :" + obj.msg.header.errorCode + " : " + obj.msg.header.errorDesc);
                                        return;
                                    }
                                }

                            }; break;
                            case "VTB": {
                                //iBase64 = false;
                                var obj = JSON.parse(data.Data);

                                if (obj.status.statusCode == "00") {
                                    strQRData = obj.data.qrData;


                                } else {
                                    edu.system.alert("Lỗi :" + obj.status.statusCode + " : " + obj.status.statusDesc);
                                    return;
                                }
                            }; break;
                            case "VTB2": {
                                //iBase64 = false;
                                var obj = data.Data;
                                strQRData = obj;
                            }; break;
                            case "VIB": {
                                //iBase64 = false;
                                var obj = JSON.parse(data.Data);

                                if (obj.Result.STATUSCODE == "000000") {
                                    strQRData = obj.Result.DATA.qrImage;
                                } else {
                                    edu.system.alert("Lỗi :" + obj.status.STATUSCODE);
                                    return;
                                }
                            }; break;
                            default: strQRData = data.Data;
                        }
                        if (strQRData) {

                            edu.system.alert('<p class="italic" style="color: blue; margin-bottom: unset">' + code + " - " + edu.util.formatCurrency(dSoTien) + '</p><p class="italic" style="color: blue; margin-bottom: unset">' + strMaSinhVien + " - " + strHoTen + '</p><img src="data:image/png;base64, ' + strQRData + '" alt="Red dot" style="max-width: 365px;" />');
                            setTimeout(function () {
                                me.getList_CheckThanhToan(code);
                            }, 60000)
                        }
                        else edu.system.alert("Không lấy được mã QR");
                    } else {
                        edu.system.alert(data.Message);
                    }
                }
                else {
                    obj_notify = {
                        type: "w",
                        content: obj_save.action + " (er): " + data.Message,
                    }
                    edu.system.alertOnModal(obj_notify);
                }
            },
            error: function (er) {
                edu.system.alertOnModal(obj_notify);
            },
            type: "POST",
            action: obj_save.action,

            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    getList_CheckThanhToan: function (strMaDonHangTongHop) {
        var me = this;

        if (!main_doc.ThanhToan || strMaDonHangTongHop != me.strMaGiaoDich) return;
        //--Edit
        var obj_list = {
            'action': 'TC_TCThanhToan/KiemTraGachNoTheoDonHang',
            'type': 'GET',
            'strMaDonHangTongHop': strMaDonHangTongHop,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    if (dtReRult.length > 0) {
                        $("#alert_content").html("");
                        edu.system.alert('<span class="italic" style="color: green; font-size: 40px">Thanh toán thành công</span>');
                        me.strMaGiaoDich = "";
                        me.getList_tblThanhToan();

                    } else {
                        setTimeout(function () {
                            me.getList_CheckThanhToan(strMaDonHangTongHop);
                        }, 10000);
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
    eventTongTien: function (strTableId) {
        var me = this;
        // Hiển thị tổng tiền sau khi click mỗi checkbox trong table
        // Thêm màu nền khi chọn và bỏ chọn

        $("#Maininfo").delegate('#' + strTableId + ' input[type="checkbox"]', "click", function () {
            var checked_status = $(this).is(':checked');

            if (checked_status) {
                this.parentNode.parentNode.classList.add('tr-bg');
            }
            else {
                this.parentNode.parentNode.classList.remove('tr-bg');
            }

            var sum = edu.system.countFloat(strTableId, 3, 5);
            var strTongThu = "Tổng tiền đã chọn: <span id='lblTongTienDaChon'>" + edu.util.formatCurrency(sum) + "</span>";
            $("#lbSoTienDaChon").html(strTongThu);

            me.show_TongTien(strTableId);
        });
    },
    ThucHienThanhToan: function (DonHangChiTietIds, SoTiens, NoiDungs) {

        var me = this;
        //--Edit 
        var obj_list = {
            'action': 'CTT_ThongTinKetNoi/KetNoiVNPAY',
            'versionAPI': "v1.0",
            'DonHangChiTietIds': DonHangChiTietIds,
            'SoTiens': SoTiens,
            'NoiDungs': NoiDungs,
            'vnp_TmnCode': edu.util.getValById("drpNganHang"),
            'MaDonHang_Gui_NganHang': me.MaDonHang_Gui_NganHang,
            'CreatedDate': me.strCreatedDate,


        };


        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {

                    window.location.replace(data.Data);

                }
                else {
                    edu.system.alert(obj_list.action + " : " + data.Message, "w");
                }
            },
            error: function (er) {
                edu.system.alert(obj_list.action + " (er): " + JSON.stringify(er), "w");
            },
            type: "GET",
            action: obj_list.action,
            versionAPI: obj_list.versionAPI,
            contentType: true,
            authen: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },

    getList_TinhTrangTaiChinh: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TC_ThongTin_MH/DSA4BRIVKC8pFTMgLyYVICgCKSgvKQPP',
            'func': 'pkg_taichinh_thongtin.LayDSTinhTrangTaiChinh',
            'iM': edu.system.iM,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strNguoiThucHien_Id': edu.system.userId,
            'strNguonDuLieu_Id': ''
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genHTML_TongCacKhoanThu(data.Data.rsThongTin[0]);
                    me["dtXuatHD"] = data.Data.rsKhoanDaNopChuaXuatHoaDon;
                    me.genTable_TinhTrangTaiChinh_HoaDon(data.Data.rsKhoanDaNopChuaXuatHoaDon, "tbldata_HoaDon");
                }
                else {
                    edu.system.alert("Lỗi: " + data.Message, "w");
                }
            },
            error: function (er) {
                edu.system.alert("Lỗi (er): " + JSON.stringify(er), "w");
            },
            type: "POST",
            action: obj_save.action,
            contentType: true,
            data: obj_save,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    getList_KhoanPhaiNop: function () {
        var me = this;
        var obj_save = {
            'action': 'TC_ThongTin_MH/DSA4BRIKKS4gLxEpICgPLjEP',
            'func': 'pkg_taichinh_thongtin.LayDSKhoanPhaiNop',
            'iM': edu.system.iM,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        }
        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genDetail_KhoanPhaiNop(data.Data);
                }
                else {
                    console.log(data.Message);
                }
                edu.system.endLoading();
            },
            error: function (er) {
                edu.system.endLoading();
            },
            type: "POST",
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },
    getList_KhoanDuocMien: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TC_ThongTin_MH/DSA4BRIKKS4gLwwoJC8P',
            'func': 'pkg_taichinh_thongtin.LayDSKhoanMien',
            'iM': edu.system.iM,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        }

        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genDetail_KhoanDuocMien(data.Data);
                }
                else {
                    console.log(data.Message);
                }
                edu.system.endLoading();
            },
            error: function (er) {
                edu.system.endLoading();
            },
            type: "POST",
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },
    getList_KhoanDaNop: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TC_ThongTin_MH/DSA4BRIKKS4gLwUgDy4x',
            'func': 'pkg_taichinh_thongtin.LayDSKhoanDaNop',
            'iM': edu.system.iM,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genDetail_KhoanDaNop(data.Data);
                }
                else {
                    console.log(data.Message);
                }
                edu.system.endLoading();
            },
            error: function (er) {
                edu.system.endLoading();
            },
            type: "POST",
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },
    getList_KhoanDaRut: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TC_ThongTin_MH/DSA4BRIKKS4gLwUgEzQ1',
            'func': 'pkg_taichinh_thongtin.LayDSKhoanDaRut',
            'iM': edu.system.iM,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genDetail_KhoanDaRut(data.Data);
                }
                else {
                    console.log(data.Message);
                }

                edu.system.endLoading();
            },
            error: function (er) {
                edu.system.endLoading();
            },
            type: "POST",
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },
    getList_PhieuHoaDon: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TC_ThongTin_MH/DSA4BRIRKSgkNAkuIAUuLwPP',
            'func': 'pkg_taichinh_thongtin.LayDSPhieuHoaDon',
            'iM': edu.system.iM,
            'pageIndex': 1,
            'pageSize': 1000000000,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strNguoiThucHien_Id': edu.system.userId,
        }

        edu.system.beginLoading();
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genDetail_PhieuHoaDon(data.Data);
                }
                else {
                    console.log(data.Message);
                }

                edu.system.endLoading();
            },
            error: function (er) {
                edu.system.endLoading();
            },
            type: "POST",
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },

    genHTML_TongCacKhoanThu: function (data) {
        var me = this;
        var dNoCo = data.NOCO;
        var strHienThi = "Chưa xác định";
        if (edu.util.floatValid(dNoCo)) {
            if (dNoCo > 0) strHienThi = '<p class="finance-startus residual"> Tổng dư: ' + edu.util.formatCurrency(dNoCo) + ' đ</p>';
            if (dNoCo < 0) strHienThi = '<p class="finance-startus debt"> Tổng nợ: ' + edu.util.formatCurrency(dNoCo) + ' đ</p>';
            if (dNoCo == 0) strHienThi = '<p class="finance-startus complate"> Đã hoàn thành</p>';
        }
        //[A] Tinh trang chung
        $(".noco-phieuthu").html(strHienThi);

        //[B] Tong cac khoan
        //1. TongTien_KhoanPhaiNop
        if (edu.util.floatValid(data.TONGKHOANPHAINOP)) {
            $(".txtTongTien_KhoanPhaiNop").html(edu.util.formatCurrency(data.TONGKHOANPHAINOP));
        } else {
            $(".txtTongTien_KhoanPhaiNop").html(0);
        }
        //2. TongTien_KhoanDuocMien
        if (edu.util.floatValid(data.TONGKHOANDUOCMIEN)) {
            $(".txtTongTien_KhoanDuocMien").html(edu.util.formatCurrency(data.TONGKHOANDUOCMIEN));
        } else {
            $(".txtTongTien_KhoanDuocMien").html(0);
        }
        //3. TongTien_KhoanDaNop
        if (edu.util.floatValid(data.TONGKHOANDANOP)) {
            $(".txtTongTien_KhoanDaNop").html(edu.util.formatCurrency(data.TONGKHOANDANOP));
        } else {
            $(".txtTongTien_KhoanDaNop").html(0);
        }
        //4. TongTien_KhoanDaRut
        if (edu.util.floatValid(data.TONGKHOANDARUT)) {
            $(".txtTongTien_KhoanDaRut").html(edu.util.formatCurrency(data.TONGKHOANDARUT));
        } else {
            $(".txtTongTien_KhoanDaRut").html(0);
        }
        //5. TongTien_NoRiengTungKhoan
        if (edu.util.floatValid(data.TONGNORIENG)) {
            $(".txtTongTien_NoRiengTungKhoan").html(edu.util.formatCurrency(data.TONGNORIENG));
        } else {
            $(".txtTongTien_NoRiengTungKhoan").html(0);
        }
        //6. TongTien_NoChungCacKhoan
        if (edu.util.floatValid(data.TONGNOCHUNG)) {
            $(".txtTongTien_NoChungCacKhoan").html(edu.util.formatCurrency(data.TONGNOCHUNG));
        } else {
            $(".txtTongTien_NoChungCacKhoan").html(0);
        }
        //7. TongTien_DuRieng
        if (edu.util.floatValid(data.TONGDURIENG)) {
            $(".txtTongTien_DuRieng").html(edu.util.formatCurrency(data.TONGDURIENG));
        } else {
            $(".txtTongTien_DuRieng").html(0);
        }
        //8. TongTien_DuChung
        if (edu.util.floatValid(data.TONGDUCHUNG)) {
            $(".txtTongTien_DuChung").html(edu.util.formatCurrency(data.TONGDUCHUNG));
        } else {
            $(".txtTongTien_DuChung").html(edu.util.formatCurrency(data.TONGDUCHUNG));
        }
        //9. TongTien_PhieuDaThu
        if (edu.util.floatValid(data.TONGTIENPHIEUTHU)) {
            $(".txtTongTien_PhieuDaThu").html(edu.util.formatCurrency(data.TONGTIENPHIEUTHU));
        } else {
            $(".txtTongTien_PhieuDaThu").html(0);
        }
        //10. TongTien_PhieuDaRut
        if (edu.util.floatValid(data.TONGTIENPHIEURUT)) {
            $(".txtTongTien_PhieuDaRut").html(edu.util.formatCurrency(data.TONGTIENPHIEURUT));
        } else {
            $(".txtTongTien_PhieuDaRut").html(0);
        }
        //10. TongTien_PhieuHoaDon
        if (edu.util.floatValid(data.TONGTIENHOADON)) {
            $(".txtTongTien_PhieuHoaDon").html(edu.util.formatCurrency(data.TONGTIENHOADON));
        } else {
            $(".txtTongTien_PhieuHoaDon").html(0);
        }

    },
    genDetail_KhoanPhaiNop: function (data) {
        var me = this;
        var thead = '';
        var $table = "tblChiTietKhoan";
        //1. thead
        $("#" + $table + " thead").html('');
        $("#" + $table + " tbody").html('');
        $("#" + $table + " tfoot").html('');
        thead += '<tr>';
        thead += '<th class="td-center td-fixed">Stt</th>';
        thead += '<th class="td-center">Học kỳ</th>';
        thead += '<th class="td-center">Đợt</th>';
        thead += '<th class="td-left">Loại khoản</th>';
        thead += '<th class="td-left">Nội dung</th>';
        thead += '<th class="td-right">Số tiền</th>';
        thead += '<th class="td-center">Ngày tạo</th>';
        thead += '<th class="td-center">Người tạo</th>';
        thead += '</tr>';
        $("#" + $table + " thead").append(thead);
        //2. tbody
        var jsonForm = {
            strTable_Id: $table,
            "aaData": data,
            colPos: {
                left: [3, 4],
                right: [5],
            },
            "aoColumns": [
                {
                    "mData": "DAOTAO_THOIGIANDAOTAO",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Học kỳ:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO) + '</span>';
                    }
                }
                , {
                    "mData": "DAOTAO_THOIGIANDAOTAO_DOT",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Đợt:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO_DOT) + '</span>';
                    }
                }
                , {
                    "mData": "TAICHINH_CACKHOANTHU_TEN",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Loại khoản:</em> <span>' + edu.util.returnEmpty(aData.TAICHINH_CACKHOANTHU_TEN) + '</span>';
                    }
                }
                , {
                    "mData": "NOIDUNG",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Nội dung:</em> <span>' + edu.util.returnEmpty(aData.NOIDUNG) + '</span>';
                    }
                }
                , {
                    "mData": "SOTIEN",
                    "mRender": function (nRow, aData) {
                        return edu.util.formatCurrency(aData.SOTIEN);
                    }
                }
                , {
                    "mData": "NGAYTAO_DD_MM_YYYY",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Ngày tạo:</em> <span>' + edu.util.returnEmpty(aData.NGAYTAO_DD_MM_YYYY) + '</span>';
                    }
                }
                , {
                    "mData": "NGUOITAO_TENDAYDU",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Người tạo:</em> <span>' + edu.util.returnEmpty(aData.NGUOITAO_TENDAYDU) + '</span>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);

        if (data != null && data.length > 0) {
            edu.system.insertSumAfterTable($table, [5]);
            $('#' + $table + ' tfoot td:eq(5)').attr('style', 'text-align: right');
        }
    },
    genDetail_KhoanDuocMien: function (data) {
        var me = this;
        var thead = '';
        var $table = "tblChiTietKhoan";
        //1. thead
        $("#" + $table + " thead").html('');
        $("#" + $table + " tbody").html('');
        $("#" + $table + " tfoot").html('');
        thead += '<tr>';
        thead += '<th class="td-center td-fixed">Stt</th>';
        thead += '<th class="td-center">Học kỳ</th>';
        thead += '<th class="td-center">Đợt</th>';
        thead += '<th class="td-left">Loại khoản</th>';
        thead += '<th class="td-left">Nội dung</th>';
        thead += '<th class="td-right">Số tiền được miễn</th>';
        thead += '<th class="td-center">Ngày tạo</th>';
        thead += '<th class="td-center">Người tạo</th>';
        thead += '</tr>';
        $("#" + $table + " thead").append(thead);

        var jsonForm = {
            strTable_Id: $table,
            "aaData": data,
            colPos: {
                left: [3, 4],
                right: [5]
            },
            "aoColumns": [
                {
                    "mData": "DAOTAO_THOIGIANDAOTAO",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Học kỳ:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO) + '</span>';
                    }
                }
                , {
                    "mData": "DAOTAO_THOIGIANDAOTAO_DOT",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Đợt:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO_DOT) + '</span>';
                    }
                }
                , {
                    "mData": "TAICHINH_CACKHOANTHU_TEN",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Loại khoản:</em> <span>' + edu.util.returnEmpty(aData.TAICHINH_CACKHOANTHU_TEN) + '</span>';
                    }
                }
                , {
                    "mData": "NOIDUNG",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Nội dung:</em> <span>' + edu.util.returnEmpty(aData.NOIDUNG) + '</span>';
                    }
                }
                , {
                    "mData": "SOTIEN",
                    "mRender": function (nRow, aData) {
                        return edu.util.formatCurrency(aData.SOTIEN);
                    }
                }
                , {
                    "mData": "NGAYTAO_DD_MM_YYYY",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Ngày tạo:</em> <span>' + edu.util.returnEmpty(aData.NGAYTAO_DD_MM_YYYY) + '</span>';
                    }
                }
                , {
                    "mData": "NGUOITAO_TENDAYDU",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Người tạo:</em> <span>' + edu.util.returnEmpty(aData.NGUOITAO_TENDAYDU) + '</span>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);

        if (data != null && data.length > 0) {
            edu.system.insertSumAfterTable($table, [5]);
            $('#' + $table + ' tfoot td:eq(5)').attr('style', 'text-align: right');
        }
    },
    genDetail_KhoanDaNop: function (data) {
        var me = this;
        var thead = '';
        var $table = "tblChiTietKhoan";
        //1. thead
        $("#" + $table + " thead").html('');
        $("#" + $table + " tbody").html('');
        $("#" + $table + " tfoot").html('');
        thead += '<tr>';
        thead += '<th class="td-center td-fixed">Stt</th>';
        thead += '<th class="td-center">Học kỳ</th>';
        thead += '<th class="td-center">Đợt</th>';
        thead += '<th class="td-left">Loại khoản</th>';
        thead += '<th class="td-left">Nội dung</th>';
        thead += '<th class="td-right">Số tiền</th>';
        thead += '<th class="td-center">Ngày tạo</th>';
        thead += '<th class="td-center">Số chứng từ</th>';
        thead += '<th class="td-center">Người tạo</th>';
        thead += '</tr>';
        $("#" + $table + " thead").append(thead);

        var jsonForm = {
            strTable_Id: $table,
            "aaData": data,
            colPos: {
                left: [3, 4],
                right: [5]
            },
            "aoColumns": [
                {
                    "mData": "DAOTAO_THOIGIANDAOTAO",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Học kỳ:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO) + '</span>';
                    }
                }
                , {
                    "mData": "DAOTAO_THOIGIANDAOTAO_DOT",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Đợt:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO_DOT) + '</span>';
                    }
                }
                , {
                    "mData": "TAICHINH_CACKHOANTHU_TEN",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Loại khoản:</em> <span>' + edu.util.returnEmpty(aData.TAICHINH_CACKHOANTHU_TEN) + '</span>';
                    }
                }
                , {
                    "mData": "NOIDUNG",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Nội dung:</em> <span>' + edu.util.returnEmpty(aData.NOIDUNG) + '</span>';
                    }
                }
                , {
                    "mData": "SOTIEN",
                    "mRender": function (nRow, aData) {
                        return edu.util.formatCurrency(aData.SOTIEN);
                    }
                }
                , {
                    "mData": "NGAYTAO_DD_MM_YYYY",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Ngày tạo:</em> <span>' + edu.util.returnEmpty(aData.NGAYTAO_DD_MM_YYYY) + '</span>';
                    }
                }
                , {
                    "mData": "NGAYTAO_DD_MM_YYYY",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Chứng từ:</em> <span>' + edu.util.returnEmpty(aData.CHUNGTU_SO) + '</span>';
                    }
                }
                , {
                    "mData": "NGUOITAO_TENDAYDU",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Người tạo:</em> <span>' + edu.util.returnEmpty(aData.NGUOITAO_TENDAYDU) + '</span>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);

        if (data != null && data.length > 0) {
            edu.system.insertSumAfterTable($table, [5]);
            $('#' + $table + ' tfoot td:eq(5)').attr('style', 'text-align: right');
        }
    },
    genDetail_KhoanDaRut: function (data) {
        var me = this;
        var thead = '';
        var $table = "tblChiTietKhoan";
        //1. thead
        $("#" + $table + " thead").html('');
        $("#" + $table + " tbody").html('');
        $("#" + $table + " tfoot").html('');
        thead += '<tr>';
        thead += '<th class="td-center td-fixed">Stt</th>';
        thead += '<th class="td-center">Học kỳ</th>';
        thead += '<th class="td-center">Đợt</th>';
        thead += '<th class="td-left">Loại khoản</th>';
        thead += '<th class="td-left">Nội dung</th>';
        thead += '<th class="td-right">Số tiền</th>';
        thead += '<th class="td-center">Ngày tạo</th>';
        thead += '<th class="td-center">Người tạo</th>';
        thead += '</tr>';
        $("#" + $table + " thead").append(thead);
        //2. tbody
        var jsonForm = {
            strTable_Id: $table,
            "aaData": data,
            colPos: {
                left: [3, 4],
                right: [5]
            },
            "aoColumns": [
                {
                    "mData": "DAOTAO_THOIGIANDAOTAO",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Học kỳ:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO) + '</span>';
                    }
                }
                , {
                    "mData": "DAOTAO_THOIGIANDAOTAO_DOT",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Đợt:</em> <span>' + edu.util.returnEmpty(aData.DAOTAO_THOIGIANDAOTAO_DOT) + '</span>';
                    }
                }
                , {
                    "mData": "TAICHINH_CACKHOANTHU_TEN",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Loại khoản:</em> <span>' + edu.util.returnEmpty(aData.TAICHINH_CACKHOANTHU_TEN) + '</span>';
                    }
                }
                , {
                    "mData": "NOIDUNG",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Nội dung:</em> <span>' + edu.util.returnEmpty(aData.NOIDUNG) + '</span>';
                    }
                }
                , {
                    "mData": "SOTIEN",
                    "mRender": function (nRow, aData) {
                        return edu.util.formatCurrency(aData.SOTIEN);
                    }
                }
                , {
                    "mData": "NGAYTAO_DD_MM_YYYY",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Ngày tạo:</em> <span>' + edu.util.returnEmpty(aData.NGAYTAO_DD_MM_YYYY) + '</span>';
                    }
                }
                , {
                    "mData": "NGUOITAO_TENDAYDU",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Người tạo:</em> <span>' + edu.util.returnEmpty(aData.NGUOITAO_TENDAYDU) + '</span>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
        if (data != null && data.length > 0) {
            edu.system.insertSumAfterTable($table, [5]);
            $('#' + $table + ' tfoot td:eq(5)').attr('style', 'text-align: right');
        }
    },
    genDetail_PhieuHoaDon: function (data) {
        var me = this;
        var thead = '';
        var $table = "tblChiTietKhoan";
        //1. thead
        $("#" + $table + " thead").html('');
        $("#" + $table + " tbody").html('');
        $("#" + $table + " tfoot").html('');
        thead += '<tr>';
        thead += '<th class="td-center td-fixed" style="text-align: center">Stt</th>';
        thead += '<th class="td-center" style="text-align: center">Số phiếu</th>';
        thead += '<th class="td-right" style="text-align: right"><span class="lang" key="">Tổng tiền</span></th>';
        thead += '<th class="td-center" style="text-align: center">Ngày thu</th>';
        thead += '<th class="td-center" style="text-align: center">Người thu</th>';
        thead += '<th class="td-center" style="text-align: center">Chi tiết</th>';
        thead += '</tr>';
        $("#" + $table + " thead").append(thead);
        //2. tbody
        var jsonForm = {
            strTable_Id: $table,
            "aaData": data,
            colPos: {
                center: [0, 1, 3, 4, 5],
                right: [2]
            },
            "aoColumns": [
                {
                    "mData": "SOHOADON",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Số phiếu:</em> <span>' + edu.util.returnEmpty(aData.SOHOADON) + '</span>';
                    }
                }
                , {
                    "mData": "TONGTIEN",
                    "mRender": function (nRow, aData) {
                        return edu.util.formatCurrency(aData.TONGTIEN);
                    }
                }
                , {
                    "mData": "NGAYTHU_DD_MM_YYYY_HHMMSS",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Ngày thu:</em> <span>' + edu.util.returnEmpty(aData.NGAYTHU_DD_MM_YYYY_HHMMSS) + '</span>';
                    }
                }
                , {
                    "mData": "TAIKHOAN_NGUOITHU",
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Người thu:</em> <span>' + edu.util.returnEmpty(aData.TAIKHOAN_NGUOITHU) + '</span>';
                    }
                }
                , {
                    "mData": "Chitiet",
                    "mRender": function (nRow, aData) {
                        return '<a class="detail_PhieuHoaDon" style="cursor: pointer;" id="' + aData.ID + '">Chi tiết</a>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
        if (data != null && data.length > 0) {
            edu.system.insertSumAfterTable($table, [2]);
            $('#' + $table + ' tfoot td:eq(2)').attr('style', 'text-align: right');
        }
    },
    showTongTien: function (strTable_id, arrCol) {
        var x = document.getElementById(strTable_id).rows;
        for (var i = 0; i < arrCol.length; i++) {
            for (var j = 1; j < x.length; j++) {
                var pointTemp = x[j].cells[arrCol[i]];
                var strTemp = pointTemp.innerHTML;
                pointTemp.style = "text-align: right;";
                pointTemp.innerHTML = '<span style="padding-right: 35%">' + strTemp + '</span>';
            }
        }
    },

    genTable_TinhTrangTaiChinh_HoaDon: function (data, strTableId) {
        var me = this;
        console.log(data)
        var jsonForm = {
            strTable_Id: strTableId,
            aaData: data,
            colPos: { center: [0, 7, 6] },
            aoColumns: [
                {
                    "mDataProp": "DAOTAO_THOIGIANDAOTAO",
                },
                {
                    "mDataProp": "DAOTAO_THOIGIANDAOTAO_DOT",
                },
                {
                    "mDataProp": "TAICHINH_CACKHOANTHU_TEN",
                },
                {
                    "mDataProp": "NOIDUNG",
                },
                {
                    //"mDataProp": "SOTIEN",
                    "mRender": function (nRow, aData) {
                        return edu.util.formatCurrency(aData.SOTIEN);
                    }
                },
                {
                    "mDataProp": "NGAYTAO_DD_MM_YYYY",
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<input type="checkbox"  name="' + aData.ID + '" id="checkX' + aData.ID + '"/>';
                    }
                }


            ],
        };

        edu.system.loadToTable_data(jsonForm);
    },
    save_ChungTu: function (strTable_Id_Loai, linkHDDT, strPhuongThuc_Ma) {
        var me = this;
        //
        var strIds = [];
        var strTAICHINH_CACKHOANTHU_Ids = [];
        var strThoiGianDaoTaoIds = [];
        var strNoiDungs = [];
        var strSoTien = [];
        var arrIdCheck = [];
        var strSoLuong = [];
        var strDonGia = [];
        var arrDonViTinh = [];
        var idem = 0;
        var strHinhThucThu_Ma = "";
        var strHinhThucThu_Ten = "";
        var strLoaiTienTe_Ma = "";
        //Lấy dữ liệu theo các check box đã chọn
        var arrChecked_Id = edu.util.getArrCheckedIds("tbldata_HoaDon", "checkX");
        arrChecked_Id.forEach(eHD => {
            let aData = me.dtXuatHD.find(e => e.ID == eHD);
            var iSoLuong = aData.SOLUONG ? aData.SOLUONG : 1;
            var iDonGia = aData.DONGIA ? aData.DONGIA : aData.SOTIEN;

            strIds.push(aData.ID);
            strTAICHINH_CACKHOANTHU_Ids.push(aData.ID);
            strThoiGianDaoTaoIds.push(aData.DAOTAO_THOIGIANDAOTAO_ID);
            strNoiDungs.push(aData.NOIDUNG);
            strSoTien.push(aData.SOTIEN);
            strSoLuong.push(iSoLuong);
            strDonGia.push(iDonGia);
            arrDonViTinh.push(aData.DONVITINH_TEN);
            strHinhThucThu_Ma = aData.HINHTHUCTHU_MA;
            strHinhThucThu_Ten = aData.HINHTHUCTHU_TEN;
            strLoaiTienTe_Ma = aData.LOAITIENTE_MA;
        })
        switch (strTable_Id_Loai) {
            case "HDDT": saveHDDT(strIds, strTAICHINH_CACKHOANTHU_Ids, strThoiGianDaoTaoIds, strNoiDungs, strSoTien); break;
            case "HDDTNHAP": saveHDDT_Nhap(strIds, strTAICHINH_CACKHOANTHU_Ids, strThoiGianDaoTaoIds, strNoiDungs, strSoTien); break;
        }

        function saveHDDT(strTaiChinh_DaNop_Ids, strTaiChinh_CacKhoanThu_Ids, strThoiGianDaoTaoIds, strNoiDung_s, strSoTien_s) {
            var obj_save = {
                'strNguoiThucHien_Id': edu.system.userId,
                'strTaiChinh_CacKhoanThu_Ids': strTaiChinh_CacKhoanThu_Ids.toString(),
                'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
                'strDaoTao_ThoiGianDaoTao_Id': strThoiGianDaoTaoIds.toString(),
                'strHinhThucThu_MA': strHinhThucThu_Ma,
                'strHinhThucThu_TEN': strHinhThucThu_Ten,
                'strTaiChinh_SoTien_s': strSoTien_s.toString(),
                'strTaiChinh_NoiDung_s': strNoiDung_s.join("#"),
                'strDonGia_s': strDonGia.toString(),
                'strSoLuong_s': strSoLuong.toString(),
                'strDonViTinhTen_s': arrDonViTinh.toString(),
                'strLoaiTienTe': strLoaiTienTe_Ma,
                'strPhuongThuc_MA': strPhuongThuc_Ma,
                'strDaoTao_ToChucCT_Id': me.strChuongTrinh_Id,
            };
            obj_save.action = 'HDDT_HoaDon/ThemMoi';
            edu.system.makeRequest({
                success: function (d, s, x) {
                    if (d.Success) {
                        informSaveSuccess(d.Id);
                        me.strChungTu_Id = d.Id;
                        edu.extend.getData_Phieu(d.Id, "HOADON", "MauIn_ChungTu", main_doc.ChungTu.changeWidthPrint);
                    }
                    else {
                        edu.system.alert("Lỗi: " + d.Message, "w");
                    }
                },
                error: function (er) {
                    edu.extend.notifyBeginLoading(JSON.stringify(er));
                    edu.system.endLoading();
                },
                type: "POST",

                complete: function () {

                    $("#lblNutHDDT").show();
                },
                action: obj_save.action,
                versionAPI: obj_save.versionAPI,
                contentType: true,
                data: obj_save,
                fakedb: [
                ]
            }, false, false, false, null, linkHDDT, true);
        }
        function saveHDDT_Nhap(strTaiChinh_DaNop_Ids, strTaiChinh_CacKhoanThu_Ids, strThoiGianDaoTaoIds, strNoiDung_s, strSoTien_s) {
            var obj_save = {
                'strNguoiThucHien_Id': edu.system.userId,
                'strTaiChinh_CacKhoanThu_Ids': strTaiChinh_CacKhoanThu_Ids.toString(),
                'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
                'strDaoTao_ThoiGianDaoTao_Id': strThoiGianDaoTaoIds.toString(),
                'strHinhThucThu_MA': strHinhThucThu_Ma,
                'strHinhThucThu_TEN': strHinhThucThu_Ten,
                'strTaiChinh_SoTien_s': strSoTien_s.toString(),
                'strTaiChinh_NoiDung_s': strNoiDung_s.join("#"),
                'strDonGia_s': strDonGia.toString(),
                'strSoLuong_s': strSoLuong.toString(),
                'strDonViTinhTen_s': arrDonViTinh.toString(),
                'strLoaiTienTe': strLoaiTienTe_Ma,
                'strPhuongThuc_MA': strPhuongThuc_Ma,
                'strDaoTao_ToChucCT_Id': me.strChuongTrinh_Id,
            };
            obj_save.action = 'HDDT_HoaDon/ThemMoi_Nhap';
            edu.system.makeRequest({
                success: function (d, s, x) {
                    if (d.Success) {
                        var strLink = d.Data;
                        if (strLink.indexOf('http') === -1) {
                            strLink = edu.system.objApi["HDDT"];
                            strLink = strLink.substring(0, strLink.length - 3) + d.Data;;
                            if (strLink.indexOf('http') === -1) {
                                strLink = edu.system.strhost + strLink;
                            }
                        }
                        var win = window.open(strLink, '_blank');
                        if (win != undefined)
                            win.focus();
                        else edu.system.alert("Vui lòng cho phép mở tab mới trên trình duyệt và thử lại!");
                    }
                    else {
                        edu.system.alert("Lỗi: " + d.Message, "w");
                        edu.extend.notifyBeginLoading(d.Message, undefined, 5000);
                    }
                },
                error: function (er) {
                    edu.extend.notifyBeginLoading(JSON.stringify(er));
                    edu.system.endLoading();
                },
                type: "POST",

                complete: function () {

                    $("#lblNutHDDT").show();
                },
                action: obj_save.action,
                versionAPI: obj_save.versionAPI,
                contentType: true,
                data: obj_save,
                fakedb: [
                ]
            }, false, false, false, null, linkHDDT, true);
        }

        function informSaveSuccess(data) {
            me.getList_TinhTrangTaiChinh();
            $("#lbSoTienDaChon_CT").html('');
            //Hiển thị lại lưu biên lai
            $("#btnIn_ChungTu").show();
            $("#btnHuy_ChungTu").show();
            $("#btnSave_ChungTu").replaceWith('');
            $(".btnXuat_HDDT").remove();
        }
    },


    getList_KhoanNopTruoc: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TC_ThanhToan_NopTruoc_MH/DSA4BRIKKS4gLw8uMRUzNC4i',
            'func': 'PKG_THANHTOAN_NOPTRUOC.LayDSKhoanNopTruoc',
            'iM': edu.system.iM,
            'strNguoiThucHien_Id': edu.system.userId,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genDetail_KhoanNopTruoc(data.Data);
                }
                else {
                    console.log(data.Message);
                }

                edu.system.endLoading();
            },
            error: function (er) {
                edu.system.endLoading();
            },
            type: "POST",
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: []
        }, false, false, false, null);
    },
    genDetail_KhoanNopTruoc: function (data) {
        var me = this;
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "TEN",
                selectFirst: true,
            },
            renderPlace: ["dropKhoanNopTruoc"],
            title: "Chọn khoản"
        };
        edu.system.loadToCombo_data(obj);
        console.log(data.length)
        if (data.length > 0) $("#zonebtnNopTruoc").show();
    },
    save_KhoanNopTruoc: function (strDaoTao_ThoiGian_KH_Id) {
        var me = this;
        var obj_save = {
            'action': 'TC_ThanhToan_NopTruoc_MH/FSkkLB4VICgCKSgvKR4RKSAoDy4xHg8uMRUzNC4i',
            'func': 'PKG_THANHTOAN_NOPTRUOC.Them_TaiChinh_PhaiNop_NopTruoc',
            'iM': edu.system.iM,
            'strQLSV_NguoiHoc_Id': me.strHSSV_Id,
            'strDaoTao_ChuongTrinh_Id': me.strChuongTrinh_Id,
            'dSoTien': edu.system.getValById('txtSoTienNopTruoc').replace(/[.,]/g, ''),
            'strNoiDung': edu.system.getValById('txtNoiDungNopTruoc'),
            'strTaiChinh_CacKhoanThu_Id': edu.system.getValById('dropKhoanNopTruoc'),
            'strNguoiThucHien_Id': me.strHSSV_Id,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    $("#modalKhoanNopTruoc").modal("hide");
                    me.getList_tblThanhToan();
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er), "w");
            },
            type: 'POST',
            contentType: true,
            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    delete_KhoanNopTruoc: function (Ids) {
        var me = this;
        //--Edit
        var obj_delete = {
            'action': 'TC_ThanhToan_NopTruoc_MH/GS4gHg8uMRUzNC4iHgUuLwkgLyYeAikoFSgkNQPP',
            'func': 'PKG_THANHTOAN_NOPTRUOC.Xoa_NopTruoc_DonHang_ChiTiet',
            'iM': edu.system.iM,
            'strDonHang_ChiTiet_Id': Ids,
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strNguoiThucHien_Id': me.strHSSV_Id,
        };
        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    //edu.system.alert("Đã xóa khoản nộp trước!");
                }
                else {
                    edu.system.alert(data.Message);
                }

            },
            error: function (er) {

                edu.system.alert(JSON.stringify(er));
            },
            type: "POST",
            action: obj_delete.action,

            complete: function () {
                edu.system.start_Progress("zoneprocessXXXX", function () {
                    me.getList_tblThanhToan();
                });
            },
            contentType: true,

            data: obj_delete,
            fakedb: [
            ]
        }, false, false, false, null);
    },

    getList_CauHinhTuKhoa: function (strLoaiCauHinh) {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'CMS_CauHinh_TuKhoa/LayDanhSach',
            'type': 'GET',
            'strLoaiCauHinh': strLoaiCauHinh,
            'strDinhDanh': edu.util.getValById('txtAAAA'),
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me["dtCauHinhTuKhoa"] = dtReRult;
                    me.genTable_CauHinhTuKhoa(dtReRult, data.Pager);
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
    genTable_CauHinhTuKhoa: function (data, iPager) {
        /*III. Callback*/
        var html = "";
        data.forEach(e => {
            switch (e.DINHDANH) {
                case "BACKGROUNDHEADER": document.getElementById("backgroundheader").style.background = "#f3f3f3 url('" + e.DULIEU + "') no-repeat right top"; break;
                case "TITLE": document.title = e.DULIEU; break;
                case "HIDDEN": {
                    var arrHiden = [e.DULIEU];
                    if (e.DULIEU.indexOf(',') != -1) {
                        arrHiden = e.DULIEU.split(',');
                    }
                    arrHiden.forEach(ele => {
                        $(ele).hide();
                    });
                } break;
                case "RUN": {
                    eval(e.DULIEU);
                } break;
                default: $("." + e.DINHDANH).html(edu.util.returnEmpty(e.DULIEU));
            }
        });
    },
}