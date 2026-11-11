function tracuuvanbang() { };

tracuuvanbang.prototype = {
    dtKetQuaTimKiem: [],
    dtCauHinhTuKhoa: [],
    
    strMaSinhVien: '',
    strcolHidden:'',
    MaDonHang_Gui_NganHang: '',
    strCreatedDate: '',
    init: function () {
        var me = this;
        me.getList_CauHinhTuKhoa("CONGTHONGTIN");
        me.getList_CauHinhHienThi("TRACUUVANBANG.FORM");
        $(".select-opt").select2();
        $("#btnSearch").click(function () {
             me["strTN_KetQua_CongNhan_VB_Id"] = "";
            //Kiểm tra mã capcha             
            const ans = captcha.valid(edu.util.getValById("code"));
            if (ans == false) {
                edu.system.alert("Bạn nhập sai mã bảo vệ");
                captcha.refresh();
                return;  
            }
            captcha.refresh();
            
            if ($('#zoneHoTenNgaySinh').is(':hidden')) {
                if (edu.util.getValById("txtSoHieuChungChi") == "") {
                    edu.system.alert("Bạn chưa nhập thông tin tìm kiếm");
                    return;
                }
            }
            else {
                if (edu.util.getValById("txtSoHieuChungChi") == "" &&
                    edu.util.getValById("txtHoTenDayDu") == "" &&
                    edu.util.getValById("txtNgaySinh") == "") {
                    edu.system.alert("Bạn chưa nhập thông tin tìm kiếm");
                    return;
                }
            };
           
            me.get_tblKetQuaTimKiem(); 
             
        });
        $("#tblKetQuaTimKiem").delegate(".btnChiTietTimKiem", "click", function () {
            var strId = this.id;            
            $("#zoneChiTietKetQuaTimKiem").modal("show");
            
            var dt = edu.util.objGetDataInData(strId, me.dtKetQuaTimKiem, "ID");
            //me.rewrite_ThongTinChiTietKetQuaTimKiem();
           //me.toggle_edit_ThongTinChiTietKetQuaTimKiem();
           me.viewEdit_ThongTinChiTietKetQuaTimKiem(dt[0]);

        });
        $("#drpHeDaoTao").on("select2:select", function () {
            me.getList_drpLoaiVanBangChungChi();
        });
        // Nhấn Enter để tìm kiếm
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
        
        me.page_load(); 
       const urlParams = new URLSearchParams(window.location.search);
        let strMa = urlParams.get('m');
        if(strMa != null && strMa != ""){
            me["strTN_KetQua_CongNhan_VB_Id"] = strMa;
            me.get_tblKetQuaTimKiem();
        }
    },
   
    page_load: function () {
        var me = this;
        edu.system.page_load(); 
        me.getList_drpHeDaoTao();
        me.getList_drpLoaiVanBangChungChi();
         
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
                    me.dtCauHinhTuKhoa = dtReRult;
                    me.genTable_CauHinhTuKhoa(dtReRult, data.Pager);
                }
                else {
                    edu.system.alert(data.Message, "s");
                }

            },
            error: function (er) {

                edu.system.alert(obj_list + " (er): " + JSON.stringify(er), "w");
            },
            type: 'GET',
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
     
    viewEdit_ThongTinChiTietKetQuaTimKiem: function (dt) {
        var me = this;
        $(".lblHoTen").html(dt.HOTEN);
        if (dt.GENDER=="1")
            $(".lblGioiTinh").html("Nam");
        else
            $(".lblGioiTinh").html("Nữ");
        $(".lblNgaySinh").html(dt.NGAYSINH);
        $(".lblNoiSinh").html(dt.PLACEOFBIRTH);
        $(".lblDanToc").html(dt.DANTOC);
        $(".lblQuocTich").html(dt.QUOCTICH);
        $(".lblMaSoSinhVien").html(dt.MASINHVIEN);
        $(".lblNganh").html(dt.NGANH);
        $(".lblChuyenNganh").html(dt.CHUYENNGANH);
        if (dt.SECONDFIELD == "1") {
            $(".lblNganh").html("Học ngành 2: " + dt.NGANH);
            $(".lblChuyenNganh").html("Học chuyên ngành 2:"+dt.CHUYENNGANH);
        }
       
        $(".lblLop").html(dt.TENLOP);
        $(".lblTrinhDo").html(dt.TENLOP);
        $(".lblTrinhDo").html(dt.TRINHDODAOTAO);
        $(".lblHinhThucDaoTao").html(dt.HINHTHUCDAOTAO);
        $(".lblKhoaHoc").html(dt.KHOAHOC);
        $(".lblQuyetDinhTotNghiep").html(dt.SOQDTN);
        $(".lblNamTotNghiep").html(dt.NAMTN);
        $(".lblXepLoai").html(dt.XEPLOAI);
        $(".lblSoVaoSo").html(dt.SOVAOSOCAPVBCC);
        
        $(".lblSoHieuVanBang").html(dt.SOHIEUBANG);
        $(".lblGhiChu").html(dt.GHICHU);
        $(".lblTenVanBang").html(edu.util.returnEmpty(dt.DANHHIEUVANBANG));
        $(".lblNgayCapBang").html(dt.NGAYQUYETDINH);
        
        
        
    },
    getList_drpHeDaoTao: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'TS_TraCuuVanBang/GetList_HeDaoTao',
            'versionAPI': 'v1.0', 
        }

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genList_drpHeDaoTao(data.Data);
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
    genList_drpHeDaoTao: function (data) {
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "NAME",
                code: "CODE",
                avatar: ""
            },
            renderPlace: ["drpHeDaoTao"],
            type: "",
            title: "Chọn hệ đào tạo"
        };
        edu.system.loadToCombo_data(obj);
    },
    getList_drpLoaiVanBangChungChi: function () {
        var me = this; 
        //--Edit
        var obj_list = {
            'action': 'TS_TraCuuVanBang/GetList_VanBangChungChi',
            'versionAPI': 'v1.0',
            'strHeDaoTaoId': edu.util.getValById("drpHeDaoTao")
        }

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.genList_drpLoaiVanBangChungChi(data.Data);
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
    genList_drpLoaiVanBangChungChi: function (data) {
        var obj = {
            data: data,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "NAME",
                code: "CODE",
                avatar: ""
            },
            renderPlace: ["drpLoaiVanBangChungChi"],
            type: "",
            title: "Chọn loại văn bằng chứng chỉ"
        };
        edu.system.loadToCombo_data(obj);
    },
    get_tblKetQuaTimKiem: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_TraCuuVanBang/GetList_ThongTinVanBangSV',
            'versionAPI': 'v1.0',
            'strTN_KetQua_CongNhan_VB_Id': me["strTN_KetQua_CongNhan_VB_Id"],
            'strVanBangChungChiId': edu.util.getValById("drpLoaiVanBangChungChi"),
            'strHoTen': edu.util.getValById("txtHoTenDayDu"),
            'strNgaySinh': edu.util.getValById("txtNgaySinh"),
            'strSoHieuVanBangChungChi': edu.util.getValById("txtSoHieuChungChi"),
            'strSoVaoSo': edu.util.getValById("txtSoVaoSo") 

        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    me.dtKetQuaTimKiem = data.Data;
                    me.gen_tblKetQuaTimKiem(data.Data);
                }
                else {
                    edu.system.alert(obj_list.action + " (er): " + JSON.stringify(data.Message), "w");
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
    gen_tblKetQuaTimKiem: function (data) {
        var me = this;


        var jsonForm = {
            strTable_Id: "tblKetQuaTimKiem",
            aaData: data,
            sort: true,
            colPos: {
                center: [0,],
            },
            aoColumns: [

                {
                    "mDataProp": "HOTEN"
                },
                {
                    "mRender": function (nrow, aData) {
                        var strHTML = "Nữ";
                        if (aData.GENDER == "1")
                            strHTML = "Nam";
                        return strHTML;
                    }
                },
                {
                    "mDataProp": "NGAYSINH"
                },
                {
                    "mDataProp": "PLACEOFBIRTH"
                },
                {
                    "mRender": function (nrow, aData) {
                        var strReturn = aData.NGANH;
                        if (aData.SECONDFIELD == "1") {
                            strReturn = "Học ngành 2: " + aData.NGANH;
                        }
                        return strReturn;

                    }
                },
                {
                    "mRender": function (nrow, aData) {
                        var strReturn = aData.CHUYENNGANH;
                        if (aData.SECONDFIELD == "1") {
                            strReturn = "Học chuyên ngành 2: " + aData.CHUYENNGANH;
                        }
                        return strReturn;

                    }
                },
                {
                    "mDataProp": "SOHIEUBANG"
                },
                {
                    "mDataProp": "SOVAOSOCAPVBCC"
                },
                {
                    "mDataProp": "NGAYQUYETDINH"
                },
                {
                    "mDataProp": "DANHHIEUVANBANG"
                },
                {
                    "mRender": function (nrow, aData) {
                        return '<a class="btnChiTietTimKiem" id="' + aData.ID + '" title="Xem chi tiết"><i class="fal fa-eye"></i></a>';
                        // return '<span><a class="btn btn-default btnChiTiet" id="' + aData.ID + '" title="Thông tin chi tiết"><i class="fa fa-edit color-active"> </i> </a></span>';
                    }
                }

            ]
        };
        edu.system.loadToTable_data(jsonForm);

        // Trạng thái rỗng + số lượng kết quả
        var iSoLuong = data ? data.length : 0;
        $("#wrapKetQuaTimKiem").toggle(iSoLuong > 0);
        $("#cntKetQuaTimKiem").text(iSoLuong > 0 ? iSoLuong + " kết quả" : "");
        if (iSoLuong == 0) {
            $("#emptyKetQuaTimKiem").show()
                .find("h3").text("Không tìm thấy kết quả").end()
                .find("p").text("Vui lòng kiểm tra lại thông tin đã nhập.");
                edu.system.alert("Không tìm thấy kết quả. Vui lòng kiểm tra lại thông tin đã nhập.", "w");
        }
        else {
            $("#emptyKetQuaTimKiem").hide();
        }

        // Gán nhãn cột cho từng ô (dùng khi hiển thị dạng thẻ trên điện thoại)
        var arrLabel = $("#tblKetQuaTimKiem thead th").map(function () { return $(this).text(); }).get();
        $("#tblKetQuaTimKiem tbody tr").each(function () {
            $(this).children("td").each(function (i) { $(this).attr("data-label", arrLabel[i] || ""); });
        });

        var dtr = $('#tblKetQuaTimKiem')[0].rows;
        for (var ir = 0; ir < dtr.length; ir++) {
            for (var ic = 0; ic < dtr[ir].cells.length; ic++)
                dtr[ir].cells[ic].style.display = "";
        }
        if (me.strcolHidden.indexOf(',') != - 1) {
            var arrColHidden = me.strcolHidden.split(',');
            for (var iCol = 0; iCol < arrColHidden.length - 1; iCol++)
                for (var ir = 0; ir < dtr.length; ir++) {
                    console.log(arrColHidden[iCol]);
                    var ihd = arrColHidden[iCol];
                    dtr[ir].cells[ihd].style.display = "none";
                }
        }

        setTimeout(function () {
            if(data.length == 1){
                $("#tblKetQuaTimKiem #" + data[0].ID).trigger("click");
                edu.util.viewValById("txtSoHieuChungChi", data[0].SOHIEUBANG);
                edu.util.viewValById("txtHoTenDayDu", data[0].HOTEN);
                edu.util.viewValById("txtNgaySinh", data[0].NGAYSINH);
            }
        }, 1000);
       
        /*III. Callback*/
    },
    genTable_CauHinhTuKhoa: function (data, iPager) {
        /*III. Callback*/
        var html = "";
        data.forEach(e => {
            switch (e.DINHDANH) {
                case "BACKGROUNDHEADER": {
                    var elHeader = document.getElementById("backgroundheader");
                    if (elHeader) elHeader.style.background = "#f3f3f3 url('" + e.DULIEU + "') no-repeat right top";
                } break;
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
                default: $("." + e.DINHDANH).html(edu.util.returnEmpty(e.DULIEU));
            }
        });
    },
    getList_CauHinhHienThi: function (strLoaiCauHinh) {
        var me = this;
        //--Edit
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
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                     
                    var dtReRult = data.Data;
                    
                    me.genForm_HienThi(dtReRult, data.Pager);
                }
                else {
                    edu.system.alert(data.Message, "s");
                }

            },
            error: function (er) {

                edu.system.alert(obj_list + " (er): " + JSON.stringify(er), "w");
            },
            type: 'GET',
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    genForm_HienThi: function (data, iPager) {
        var me = this;
        me.strcolHidden = "";
        for (var i = 0; i < data.length; i++) {
            
            // tim trong bang danh muc THONGTIN2 ='tblKetQuaTimKiem' nếu tên cột = TEN thì set cột của bảng  =data[i].THONGTIN1
            var iCol = 0; 
            if (edu.util.returnEmpty(data[i].THONGTIN2).toUpperCase() == 'TBLKETQUATIMKIEM') {
               
                $("#tblKetQuaTimKiem thead tr th").each(function () {                    
                    if (edu.util.returnEmpty(data[i].TEN).toUpperCase() == $(this).text().toUpperCase()) {                       
                        if (data[i].THONGTIN1 == "0") {
                            if (("," + me.strcolHidden).indexOf("," + iCol + ",") < 0)
                            me.strcolHidden += iCol + ",";                            
                        }
                    }                    
                    iCol++;
                });

            }
            else if (edu.util.returnEmpty(data[i].THONGTIN2).toUpperCase() == 'ZONESHOWHIDE') {                
                if (data[i].THONGTIN1 == '0')
                    $("#" + data[i].MA).hide();
            }
            else if (edu.util.returnEmpty(data[i].THONGTIN2).toUpperCase() == 'PLACEHOLDER') {
                $("#" + data[i].MA).attr("placeholder", data[i].MOTA);
                 
            }
           
        }; 
        if (me.strcolHidden.indexOf(',') != - 1) {
            var arrColHidden = me.strcolHidden.split(',');
            var dtr = $('#tblKetQuaTimKiem')[0].rows;
            for (var iCol = 0; iCol < arrColHidden.length - 1; iCol++)
                for (var ir = 0; ir < dtr.length; ir++) {
                    console.log(arrColHidden[iCol]);
                    var ihd = arrColHidden[iCol];
                    dtr[ir].cells[ihd].style.display = "none";
                }
        }
        
    },

}

