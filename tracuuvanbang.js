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
        
        me.page_load(); 
       

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
                            strReturn = "Học ngành 2: " + dt.NGANH;
                        }
                        return strReturn;

                    }
                },
                {
                    "mRender": function (nrow, aData) {
                        var strReturn = aData.CHUYENNGANH;
                        if (aData.SECONDFIELD == "1") {
                            strReturn = "Học ngành 2: " + dt.CHUYENNGANH;
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
                        return '<b class="show-in-mobi">Chi tiết:</b> <a class="btnChiTietTimKiem" id="' + aData.ID + '" data-bs-toggle="modal"><i class="fal fa-ballot"></i></a>';
                        // return '<span><a class="btn btn-default btnChiTiet" id="' + aData.ID + '" title="Thông tin chi tiết"><i class="fa fa-edit color-active"> </i> </a></span>';
                    }
                }

            ]
        };
        edu.system.loadToTable_data(jsonForm);
        var dtr = $('#tblKetQuaTimKiem')[0].rows; 
        for (var ir = 0; ir < dtr.length; ir++) { 
            for (var ic = 0; ic <11; ic++)        
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


       
        /*III. Callback*/
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
                            if (me.strcolHidden.indexOf(iCol.toString()) < 0)
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

