/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function TuyenSinh() { };
TuyenSinh.prototype = {
    strSinhVien_Id: '',
    strTuyenSinh_Id: '',
    dtTuyenSinh: [],
    dtTuNhapHoSo: [],
    dtNganhNghe: [],
    dtMonThi: [],
    bcheck: false,
    dtKetQuaThi: [],
    dtCheckKetQua: [],
    bCoLoiHoSo: false,
    dtCauHinhTuKhoa: [],
    dtToHop: [],
    uuid: '',
    iDemLanGoi: 0,
    iDaTaoTaiKhoan: 0,
    iSendEmail: 0,
    strDaoTao_LopQuanLy_Id: '',

    init: function () {
        var me = this;
        var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && window['safari'].pushNotification));

        edu.system.makeLog('VAOTRANGTUYENSINH', "isSafari:" + isSafari + ";" + navigator.userAgent);
        //if (navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/Macintosh/i)  || isSafari) {
        //    alert('Hệ điều iOS của bạn hiện không hỗ trợ. Vui lòng chuyển qua hệ hệ điều hành Windows');
        //    return;
        //}
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        var urlParams = new URLSearchParams(window.location.search);
        console.log(urlParams);
        if (urlParams.has('userId')) {
            edu.system.userId = urlParams.get('userId');
            me.strSinhVien_Id = urlParams.get('strSinhVien_Id');
        } else {
            //me.strSinhVien_Id = edu.system.userId;
            me.save_KiemTraTaiKhoan();
        }
        //edu.system.pickerdate();
        edu.system.appCode = "TS";
        me.getList_CauHinhTuKhoa("CONGTUYENSINH");
        edu.system.loadToCombo_DanhMucDuLieu("NS.GITI", "dropGioiTinh");
        edu.system.loadToCombo_DanhMucDuLieu("CHUN.CHLU", "dropQuocTich");
        me.getList_TuyenSinh();
        edu.extend.getDataTinhThanh();
        me.getList_KeHoach();
        $("#wrapperadmiss").delegate(".switchzone", "click", function () {
            var strId = $(this).attr("id");
            var strTab = $(this).attr("name");
            me.strDaoTao_LopQuanLy_Id = "";
            switch (strTab) {
                case "zonebatdau": $("#lblTieuDe").html('<img src="../assets/images/letter.png"> ĐĂNG KÝ XÉT TUYỂN'); break;
                case "zonedangky": $("#lblTieuDe").html('<img src="../assets/images/letter.png"> Thông tin hồ sơ dự tuyển');
                    me.strDaoTao_LopQuanLy_Id = $("#dropLQL" + strId).val();
                    break;
                case "zonelephi": $("#lblTieuDe").html('<img src="../assets/images/xettuyen.png"> Lệ phí xét tuyển'); break;
                case "zoneketqua": me.getList_KetQuaNguyenVong(); break;
            }
            $(".zone-bus").slideUp(300);
            $("#" + strTab).slideDown(500);
            if (strId) {
                loadHoSo(strId);
            }
        });
        $("#btnDangKy").click(function () {
            $(".btnThanhToanHocPhi").attr('href', './thanhtoan.aspx?');
            me.uuid = edu.util.uuid();
            if (!$('#checkcamdoan').is(":checked")) return;

            edu.system.makeLog('VAOTRANGTUYENSINHUSER', "user:" + edu.util.getValById("txtCMT") + ";" + "isSafari:" + isSafari + ";" + navigator.userAgent);
            var bcheckBatBuoc = false;
            var dtBatBuoc = me.dtTuNhapHoSo.filter(e => e.BATBUOC == 1);
            var arrBatBuoc= [];
            dtBatBuoc.forEach(e => {
                if ($("#m" + e.ID).val() == "") {
                    bcheckBatBuoc = true;
                    arrBatBuoc.push(e);
                    //edu.system.alert("Hãy nhập: <span style='color: red'>" + e.TEN + "</span>");
                }
            });
            $("#tblMonThi .batbuocmuonthi").each(function () {
                var point = this;
                console.log($(point).attr('title') + ":" + $(point).val() + ":" + $(point).is(":visible"));
                if ($(point).val() == "" && $(point).is(":visible")) {
                    bcheckBatBuoc = true;
                    arrBatBuoc.push({ 'TEN': $(point).attr('title') });
                }
            })
            if (bcheckBatBuoc) {
                $("#tblThongBaoRangBuoc").remove();
                edu.system.alert('<table id="tblThongBaoRangBuoc"><tbody></tbody></table>');
                arrBatBuoc.forEach(e => {
                    $("#tblThongBaoRangBuoc tbody").append("<tr><td>Hãy nhập: </td><td style='text-align: left'><span style='color: red'>" + e.TEN + "</span></td></tr>");
                })
                
                return;
            }

            var bcheckRangBuoc = false;
            var dtRangBuoc = me.dtTuNhapHoSo.filter(e => e.TRUONGTHONGTIN_RANGBUOC_ID !== null);
            console.log(dtRangBuoc);
            dtRangBuoc.forEach(e => {
                if ($("#m" + e.ID).val() == "") return;
                var strRangBuoc_Id = e.TRUONGTHONGTIN_RANGBUOC_ID;
                var arrRangBuoc = [strRangBuoc_Id];
                if (strRangBuoc_Id.indexOf(",") != -1) arrRangBuoc = strRangBuoc_Id.split(',');
                console.log(arrRangBuoc)
                arrRangBuoc.forEach(ele => {
                    if ($("#m" + ele).val() == "") {
                        bcheckRangBuoc = true;
                        var objRangBuoc = me.dtTuNhapHoSo.find(ep => ep.ID === ele);
                        edu.system.alert("Hãy nhập: <span style='color: red'>" + objRangBuoc.TEN + "</span>");
                    }
                });
            });
            if (bcheckRangBuoc) return;

            me.bCoLoiHoSo = false;
            edu.system.alert('<div id="zoneprocessXXXXCheck"></div>');
            edu.system.genHTML_Progress("zoneprocessXXXXCheck", me.dtTuNhapHoSo.length + $("#tblCauHinhThongTin .deleteRowButton").length + $("#tblMonThi tbody tr").length);
            var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
            if (aData === undefined) {
                edu.system.alert("Đợt tuyển sinh không tồn tại");
                return;
            }
            for (var i = 0; i < me.dtTuNhapHoSo.length; i++) {
                me.save_KiemTraDuLieu(me.dtTuNhapHoSo[i], aData.TS_MAUHOSO_ID);
            }
            $("#tblCauHinhThongTin .deleteRowButton").each(function () {
                var strKetQua_Id = this.id.replace(/rm_row/g, '');
                me.save_KiemTraNguyenVong(strKetQua_Id, me.strSinhVien_Id);
            });
            $("#tblMonThi tbody tr").each(function () {
                var strKetQua_Id = this.id.replace(/rm_row/g, '');
                me.save_KiemTraKetQua(strKetQua_Id);
            });
            //if (me.strSinhVien_Id) {
            //    me.save_HoSo();
            //}
            //me.save_TaiKhoan();
        });

        $("#btnThemDongMoi").click(function () {
            var id = edu.util.randomString(30, "");
            me.genHTML_NguyenVong(id, "");
            me.checkThemNguyenVong();
        });
        $("#tblCauHinhThongTin").delegate(".deleteRowButton", "click", function () {
            var strRowId = this.id;
            $("#tblCauHinhThongTin .sv-info-regis-item[id='" + strRowId + "']").remove();
            me.checkThemNguyenVong();
        });
        $("#tblCauHinhThongTin").delegate(".deleteKetQua", "click", function () {
            var strId = this.id;
            edu.system.confirm(edu.constant.getting("NOTIFY", "CF_DELETE"));
            $("#btnYes").click(function (e) {
                me.delete_NguyenVong(strId);
            });
        });
        //
        if (edu.system.userId) {
            setTimeout(function () {
                me.getDetail_TaiKhoan(me.strSinhVien_Id);
                me.getList_KetQuaNguyenVong();
            }, 2000);
            //edu.util.toggle_overide("zone-bus", "zoneketqua");
        }
        $("#tblKetQuaNguyenVong").delegate(".btnEdit", "click", function () {
            var strId = this.id;
            edu.util.toggle_overide("zone-bus", "zonedangky");
            loadHoSo(strId);
        });

        function loadHoSo(strTuyenSinh_Id) {
            me.uuid = edu.util.uuid();
            me.strTuyenSinh_Id = strTuyenSinh_Id;
            me.getList_TuNhapHoSo();
            me.getList_NganhNghe();
            me.getList_KetQuaThi();
            setTimeout(function () {
                me.getList_NguyenVong();
            }, 1000)
        }

        $("#btnSearch_LePhi").click(function () {
            me.getList_SinhVien();
        });
        $("#txtSearch_CMND").keypress(function (e) {
            if (e.which === 13) {
                e.preventDefault();
                me.getList_SinhVien();
            }
        });


        edu.system.uploadAvatar(['txtAvartar'], "");
        //setTimeout(function () {
        //    $("#srctxtAvartar").attr("style", "width: 260px;height: 260px;");
        //}, 2000);

        $("#btnNopLePhi").click(function () {
            let url = './thanhtoan.aspx?strMa=' + edu.util.getValById("txtSearch_CMND") 
            window.open(url, '_blank').focus();
        })

    },
    checkThemNguyenVong: function () {
        var me = this;
        var icheckcount = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id)
        if (icheckcount) icheckcount = icheckcount.NGUYENVONGTOIDACANNHAP;
        if (icheckcount) {
            var check = $("#tblCauHinhThongTin .sv-info-regis-item").length;
            if (check < icheckcount) $("#btnThemDongMoi").show();
            else $("#btnThemDongMoi").hide();
        }
        
    },
    sendEmail: function (mailTo, arrFileDinhKem) {
        var me = this;
        if (me.iSendEmail) return "";
        var mailSubject = "CHÚC MỪNG BẠN ĐÃ ĐĂNG KÝ TUYỂN SINH THÀNH CÔNG";
        var strBody = $("#mailThanhCong").html();
        var strIp = edu.system.rootPath;
        strBody = strBody.replace(/img src="../g, 'img src="' + strIp);
        strBody = strBody.replace(/href="#" x/g, 'href="' + strIp + '/pages/tuyensinh.aspx"');
        var obj_list = {
            'action': 'CMS_NguoiDung/SendEmail',
            'mailTo': mailTo,
            'mailSubject': mailSubject,
            'strBody': strBody,
            'arrFileDinhKem': arrFileDinhKem,
        };

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    edu.system.alert("Đã gửi email");
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
            },
            complete: function () {
                edu.system.start_Progress("zonepercentInDSA", function () {
                });
            },
            type: "POST",
            action: obj_list.action,
            versionAPI: obj_list.versionAPI,
            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    save_All: function () {
        var me = this;
        var total = me.dtTuNhapHoSo.length + $("#tblCauHinhThongTin .deleteRowButton").length + $("#tblMonThi tbody tr").length;
        
        edu.system.alert('<div id="zoneprocessXXXX"></div>');
        edu.system.genHTML_Progress("zoneprocessXXXX", total);
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id)
        for (var i = 0; i < me.dtTuNhapHoSo.length; i++) {
            me.save_TuNhapHoSo(me.dtTuNhapHoSo[i], aData.TS_MAUHOSO_ID);
        }
        $("#tblCauHinhThongTin .deleteRowButton").each(function () {
            var strKetQua_Id = this.id.replace(/rm_row/g, '');
            me.save_NguyenVong(strKetQua_Id, me.strSinhVien_Id);
        });
        $("#tblMonThi tbody tr").each(function () {
            var strKetQua_Id = this.id.replace(/rm_row/g, '');
            me.save_MonThi(strKetQua_Id);
        });

        //Test
        var objCheck = me.dtCauHinhTuKhoa.find(e => e.DINHDANH === "CALLBACK_CRM");
        if (objCheck != undefined) {
            me.callback_CMR(objCheck.DULIEU, objCheck.MOTA);
        }
    },
    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/
    getList_TuyenSinh: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_Dot_DoiTuong/LayDSDotTuyenSinh',
            'type': 'GET',
            'strChucNang_Id': edu.system.strChucNang_Id,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.dtTuyenSinh = dtReRult;
                    me.genTable_TuyenSinh(dtReRult, data.Pager);
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
    genTable_TuyenSinh: function (data, iPager) {
        var me = this;
        /*III. Callback*/
        var html = "";
        data.forEach(e => {
            html += '<div class="col-12 col-md-4 col-lg-3 register-item">';
            html += '<div class="register-item-box">';
            html += '<div class="title"';
            html += 'title="' + edu.util.returnEmpty(e.TEN) +'">';
            html += edu.util.returnEmpty(e.TEN);
            html += '</div>';
            html += '<div class="register-item-row">';
            html += '<i class="fal fa-calendar-day"></i>';
            html += '<span>Ngày bắt đầu: <b>' + edu.util.returnEmpty(e.NGAYBATDAU) +'</b></span>';
            html += '</div>';
            html += '<div class="register-item-row">';
            html += '<i class="fal fa-calendar-edit"></i>';
            html += '<span>Ngày kết thúc: <b>' + edu.util.returnEmpty(e.NGAYKETTHUC) +'</b></span>';
            html += '</div>';
            html += e.CHITIEU ? '<div class="register-item-row"><i class="fal fa-chart-pie"></i><span>Chỉ tiêu: <b>' + edu.util.returnEmpty(e.CHITIEU) +'</b></span></div>': '';
            html += '<div class="register-item-row" style="margin-bottom: 10px">';
            html += '<i class="fal fa-file-signature"></i>';
            html += '<span>Điều kiện: ' + edu.util.returnEmpty(e.MOTADIEUKIENXET) +'</span>';
            html += '</div>';

            html += '<div class="" id="zoneLopQuanLy'+ e.ID +'">';
            html += '</div>';

            html += '<a href="#" class="register-item-btn mb-0 switchzone" name="zonedangky" id="' + edu.util.returnEmpty(e.ID) +'">Đăng ký </a>';
            html += '<div class="register-item-row mb-0" style="margin-top: 15px">';
            html += '<i class="fal fa-file-signature"></i>';
            html += '<a href="' + edu.util.returnEmpty(e.DOITUONGDUTUYEN_HDSD) +'" target="_blank">Hướng dẫn đăng ký</a>';
            html += '</div>';
            html += '</div>';
            html += '</div>';
        });
        $("#phieuxettuyen").html(html);
        data.forEach(e => me.getList_LopQuanLy(e.ID));
    },
    getList_LopQuanLy: function (strId) {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_TaiKhoan/LayDSLopQLDangKy',
            'type': 'GET',
            'strTS_DotTS_DoiTuong_Id': strId,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    if (dtReRult.length > 0) {
                        var html = '';
                        html += '<i class="fal fa-file-signature"></i>';
                        html += '<span>Lớp -\t\t Số lượng: <div class="custom-select"><select id="dropLQL' + strId + '" class="form-select select-opt selectLop"></select></div></span>';
                        html += '<b id="lblSoLuong' + strId + '" style="color:red"> ' + edu.util.returnEmpty() + '</b>';
                        $("#zoneLopQuanLy" + strId).html(html);
                        $("#zoneLopQuanLy" + strId).attr("class", "register-item-row");

                        $('.selectLop').on('change', function () {
                            let strId = this.id.replace(/dropLQL/, '');
                            let strSL = $(this).find("option:selected").attr("id");
                            $("#lblSoLuong" + strId).html(strSL);
                        });
                        var obj = {
                            data: dtReRult,
                            renderInfor: {
                                id: "ID",
                                parentId: "",
                                avatar: "SOLUONG",
                                selectFirst: true,
                                mRender: function (nRow, aData) {
                                    return edu.util.returnEmpty(aData.TEN) + " \n <br/> - <b style='color: red'> SL: " + edu.util.returnEmpty(aData.SOLUONG) + "</b>"
                                }
                            },
                            renderPlace: ["dropLQL" + strId],
                            title: "Chọn lớp"
                        };
                        edu.system.loadToCombo_data(obj);
                        $("#dropLQL" + strId).select2({
                            templateResult: function (data) {
                                if (!data.id) return data.text;
                                return $('<span>' + data.text.replace(' - ', '<br>') + '</span>');
                            },
                            templateSelection: function (data) {
                                if (!data.id) return data.text;
                                return $('<span>' + data.text.replace(' - ', '<br>') + '</span>');
                            },
                            escapeMarkup: function (markup) {
                                return markup;
                            }
                        });
                    }
                }
                else {
                    //edu.system.alert(data.Message, "s");
                }

            },
            error: function (er) {

                //edu.system.alert(JSON.stringify(er), "w");
            },
            type: 'GET',
            action: obj_list.action,

            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/
    save_TuNhapHoSo: function (aData, strTS_MauHoSo_Id) {
        var me = this;
        var obj_notify = {};
        var strTruongThongTin_GiaTri = aData.TRUONGTHONGTIN_GIATRI;
        var strThongTinXacMinh = "";
        strTruongThongTin_GiaTri = $("#m" + aData.ID).val();
        strThongTinXacMinh = $("#m" + aData.ID).val();
        if (aData.KIEUDULIEU.toUpperCase() == "FILE") {
            edu.system.saveFiles("m" + aData.ID, me.strSinhVien_Id + aData.ID, "SV_Files");
        }
        //--Edit
        var obj_save = {
            'action': 'TS_TaiKhoan/Them_TS_HoSo_DuLieu',
            'type': 'POST',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strTS_HoSoTuyenSinh_Id': me.strSinhVien_Id,
            'strTruongThongTin_Id': aData.ID,
            'strTruongThongTin': edu.util.returnEmpty(aData.THUOCNHOM) + " " + aData.TEN,
            'strTruongThongTin_GiaTri': strTruongThongTin_GiaTri,
            'strThongTinXacMinh': strThongTinXacMinh,
            'strTS_MauHoSo_Id': strTS_MauHoSo_Id,
            'strNguoiThucHien_Id': edu.system.userId,
            'strHoDem': edu.util.getValById('txtHoDem'),
            'strTen': edu.util.getValById('txtTen'),
            'strSoDienThoai': edu.util.getValById('txtSoDienThoai'),
            'strEmail': edu.util.getValById('txtEmail'),
            'strCMT': edu.util.getValById('txtCMT'),
            'strTS_KeHoachTuyenSinh_Id': me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id).TS_KEHOACHTUYENSINH_ID,
            'strTS_DotTS_DoiTuong_Id': me.strTuyenSinh_Id,
        };
        //default
        edu.system.makeRequest({
            success: function (data) {
                
                if (data.Success) {
                    edu.system.alert("Thực hiện thành công");

                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alertOnModal(obj_notify);
            },
            type: "POST",
            action: obj_save.action,

            complete: function () {
                edu.system.start_Progress("zoneprocessXXXX", function () {
                    me.getList_KetQuaDangKy();
                });
            },
            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    save_KiemTraDuLieu: function (aData, strTS_MauHoSo_Id) {
        var me = this;
        var obj_notify = {};
        var strTruongThongTin_GiaTri = aData.TRUONGTHONGTIN_GIATRI;
        var strThongTinXacMinh = "";
        strTruongThongTin_GiaTri = $("#m" + aData.ID).val();
        strThongTinXacMinh = $("#m" + aData.ID).val();
        

        //--Edit
        var obj_save = {
            'action': 'TS_TaiKhoan/Them_TS_HoSo_DuLieu_KiemTra',
            'type': 'POST',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strTS_HoSoTuyenSinh_Id': me.strSinhVien_Id,
            'strTruongThongTin_Id': aData.ID,
            'strTruongThongTin': edu.util.returnEmpty(aData.THUOCNHOM) + " " + aData.TEN,
            'strTruongThongTin_GiaTri': strTruongThongTin_GiaTri,
            'strThongTinXacMinh': strThongTinXacMinh,
            'strTS_MauHoSo_Id': strTS_MauHoSo_Id,
            'strNguoiThucHien_Id': edu.system.userId,
            'strTS_KeHoachTuyenSinh_Id': me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id).TS_KEHOACHTUYENSINH_ID,
            
            'strKhoaKiemTraDuLieu': me.uuid,
            'strHoDem': edu.util.getValById('txtHoDem'),
            'strTen': edu.util.getValById('txtTen'),
            'strSoDienThoai': edu.util.getValById('txtSoDienThoai'),
            'strEmail': edu.util.getValById('txtEmail'),
            'strCMT': edu.util.getValById('txtCMT'),
            'strTS_DotTS_DoiTuong_Id': me.strTuyenSinh_Id,
        };
        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success && data.Id) {
                    //edu.system.alert("Thực hiện thành công");
                    //me.save_TuNhapHoSo(obj_save);
                }
                else {
                    if (!me.bCoLoiHoSo) {
                        me.bCoLoiHoSo = true;
                        var html = '';
                        html += '<div class="row">';
                        html += '<p class="group-title-name">';
                        html += '<span class="badge bg-blue">Các thông tin không hợp lệ</span>';
                        html += '</p>';
                        html += '</div>';
                        html += '<div class="row">';
                        html += '<table id="tblBaoLoi" class="table">';
                        html += '<thead>';
                        html += '<tr>';
                        html += '<td class="td-fixed td-center">STT</td>';
                        html += '<td class="td-center">Thông tin</td>';
                        html += '<td class="td-center">Nội dung</td>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody></tbody>';
                        html += '</table>';
                        html += '</div>';
                        edu.system.alert(html);
                    }
                    setTimeout(function () {
                        var strErr = data.Message ? data.Message: "Không kiểm tra được dữ liệu";

                        var row = '';
                        row += '<tr>';
                        row += '<td></td>';
                        row += '<td>' + obj_save.strTruongThongTin + '</td>';
                        row += '<td>' + strErr + '</td>';
                        row += '</tr>';
                        $("#tblBaoLoi tbody").append(row);
                    }, 1000);
                }
            },
            error: function (er) {
                edu.system.alertOnModal(obj_notify);
            },
            type: "POST",
            action: obj_save.action,

            complete: function () {
                edu.system.start_Progress("zoneprocessXXXXCheck", function () {
                    if (me.bCoLoiHoSo) return;
                    if (me.strSinhVien_Id) {
                        me.save_HoSo();
                    }
                    me.save_TaiKhoan();
                });
            },
            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    getList_TuNhapHoSo: function () {
        var me = this;
        //--Edit
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        $("#lblphieuxettuyen").html(aData.TEN);
        var obj_list = {
            'action': 'TS_TaiKhoan/LayDSHoSoTheoMauHoSo',
            'type': 'GET',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strTS_HoSoTuyenSinh_Id': me.strSinhVien_Id,
            'strNguoiThucHien_Id': edu.system.userId,
            'strTS_MauHoSo_Id': aData.TS_MAUHOSO_ID,
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,

        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.dtTuNhapHoSo = dtReRult;
                    me.genTable_TuNhapHoSo(dtReRult, data.Pager);
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
    genTable_TuNhapHoSo: function (data, iPager) {
        var me = this;
        var html = '';
        var strGroup = data.length > 0 ? data[0].THUOCNHOM : "";
        data.forEach((aData, nRow) => {
            var strTempG = aData.THUOCNHOM;
            if (nRow != 0 && strTempG != strGroup) {
                strGroup = strTempG;
                html += '<hr>';
            } else {
                if (nRow != 0)
                    strTempG = "";
            }
            var iDoRongNhom = strTempG ? 2 : 0;
            html += '<div class="row sv-info-detail-item">';
            html += '<div class="col-12 col-md-' + iDoRongNhom +' text-lable-groud"><b>' + edu.util.returnEmpty(strTempG) + '</b></div>';
            html += '<div class="col-12 col-md-' + (6 - iDoRongNhom) +' text-lable">' + aData.TEN;
            html += aData.BATBUOC == 1 ? '<span>*</span>' : '';
            html += '</div>';
            html += '<div class="col-12 col-md-4">';
            html += '<div class="form-item d-flex mb-15 form-add-info">';
            html += '<div class="input-group">';
            //html += '<i class="fa-alarm-clock color-dask-blue"></i>';
            html += aData.TENANH ? '<i class="' + aData.TENANH + ' color-dask-blue"></i>' : '';
            html += geninput(nRow, aData);
            html += '</div>';
            html += '</div>';
            html += '</div>';
            html += '<div class="col-12 col-md-2">' + edu.util.returnEmpty(aData.KETQUAXACNHAN_TEN) + '</div>';
            html += '</div>';
        });
        $("#tblTuNhapHoSo").html(html);



        function geninput(nRow, aData) {
            if (aData.KIEUDULIEU) {
                var strLoai = 'input';
                var strDuocSua = (aData.DUOCSUA === 0 ? 'readonly="readonly"' : '');
                var strDoDai = (aData.DORONG) ? 'height: ' + aData.DORONG + 'px' : '';
                if (aData.DORONG) strLoai = "textarea";
                switch (aData.KIEUDULIEU.toUpperCase()) {
                    case "TEXT":
                    case "NUMBER":
                        return '<' + strLoai + ' id="m' + aData.ID + '"  class="form-control" value="' + me.getGiaTri(aData) + '" style="' + strDoDai + '" ' + strDuocSua + ' />';
                    case "DATE": return '<input id="m' + aData.ID + '"  class="form-control input-datepicker" value="' + me.getGiaTri(aData) + '" ' + strDuocSua + ' placeholder="dd/mm/yyyy" />';
                    case "TINH":
                    case "HUYEN":
                    case "XA":
                    case "LIST":
                        {
                            
                            return '<select id="m' + aData.ID + '" class="form-select select-opt"></select>';
                        }
                    case "FILE": return '<div id="m' + aData.ID + '"></div>';
                    //case "AVATAR": return '<div id="' + aData.ID + '"></div>';
                }
            }
        }

        var arrFile = [];
        data.forEach(aData => {
            if (aData.KIEUDULIEU) {
                switch (aData.KIEUDULIEU.toUpperCase()) {
                    case "LIST": {
                        if (aData.MABANGDANHMUC) {
                            $("#m" + aData.ID).select2();
                            edu.system.loadToCombo_DanhMucDuLieu(aData.MABANGDANHMUC, "", "", dtDanhMuc => {
                                if (aData.THONGTIN5) {
                                    me['dt' + aData.ID] = dtDanhMuc;
                                }
                                var obj = {
                                    data: dtDanhMuc,
                                    renderInfor: {
                                        id: "ID",
                                        parentId: "",
                                        name: "TEN",
                                        default_val: aData.TRUONGTHONGTIN_GIATRI
                                    },
                                    renderPlace: ["m" + aData.ID],
                                };
                                edu.system.loadToCombo_data(obj);
                            });
                        }
                    }; break;
                    case "FILE": {
                        edu.system.uploadFiles(["m" + aData.ID]);
                        edu.system.viewFiles("m" + aData.ID, me.strSinhVien_Id + aData.ID, "SV_Files");
                        break;
                    }
                    case "TINH": {
                        var objHuyen = data.find(e => (e.NHOM === aData.NHOM && e.KIEUDULIEU === "HUYEN"));
                        var objXa = data.find(e => (e.NHOM === aData.NHOM && e.KIEUDULIEU === "XA"));

                        var strTinh_Id = "m" + aData.ID;
                        var strHuyen_Id = "m";
                        if (objHuyen) strHuyen_Id = strHuyen_Id + objHuyen.ID;
                        var strXa_Id = "m";
                        if (objXa) strXa_Id = strXa_Id + objXa.ID;
                        $("#" + strTinh_Id).select2();
                        $("#" + strHuyen_Id).select2();
                        $("#" + strXa_Id).select2();
                        console.log("TT:" +strTinh_Id + strHuyen_Id + strXa_Id)
                        var strTinh = me.getGiaTri(aData);
                        var strHuyen = me.getGiaTri(objHuyen);
                        var strXa = me.getGiaTri(objXa);

                        edu.extend.genDropTinhThanh(strTinh_Id, strHuyen_Id, strXa_Id, strTinh, strHuyen, strXa);
                        if (aData.THONGTIN3) {
                            //var objHoSo = data.find(e => e.MABANGDANHMUC === aData.THONGTIN3);
                            //console.log('#m' + aData.ID);
                            $('#m' + aData.ID).on('change', function () {
                                var strCha_Id = $("#m" + aData.ID).val();
                                //console.log(strCha_Id)
                                if (strCha_Id == "") {
                                    var dtReRult = me['dt' + aData.THONGTIN3];
                                } else {
                                    var dtReRult = me['dt' + aData.THONGTIN3].filter(e => e.QUANHECHA_ID === strCha_Id);
                                }
                                var obj = {
                                    data: dtReRult,
                                    renderInfor: {
                                        id: "ID",
                                        parentId: "",
                                        name: "TEN",
                                        code: "MA",
                                    },
                                    renderPlace: ["m" + aData.THONGTIN3],
                                    type: "",
                                    //title: "Chọn " + edu.util.returnEmpty(aData.TENHIENTHITOHOP)
                                };
                                edu.system.loadToCombo_data(obj);
                            });
                        }
                    }; break;
                }
            }
        });
        //if (arrFile.length) edu.system.uploadFiles(arrFile);
        //setTimeout(function () {
        //    data.forEach(aData => {
        //        if (aData.KIEUDULIEU) {

        //            switch (aData.KIEUDULIEU.toUpperCase()) {
        //                case "LIST": {
        //                    if (me.getGiaTri(aData)) $("#m" + aData.ID).val(me.getGiaTri(aData)).trigger("change");
        //                }; break;
        //            }
        //        }
        //    });
        //}, 6666);
        //edu.system.pickerdate();
        //me.actionRowSpanForACol(jsonForm.strTable_Id, 1);
        /*III. Callback*/
        //$('.form-select').searchBox({
        //    elementWidth: ''
        //});
        //$(".form-select").select2();
    },
    getGiaTri: function (aData) {
        var me = this;
        if (aData) return edu.util.returnEmpty(aData.TRUONGTHONGTIN_GIATRI);
        return "";
        //return edu.util.returnEmpty(aData.THONGTINXACMINH);
    },
    /*------------------------------------------
    --Discription: [2] AccessDB ThongTin
    --ULR:  Modules
    -------------------------------------------*/

    save_KiemTraTaiKhoan: function () {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'TS_TaiKhoanDangNhap/XacMinhTaiKhoanDangNhap',
            'type': 'POST',
            'strNguoiDung_Id': edu.system.userId,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    if (data.Data == "THISINH") me.strSinhVien_Id = edu.system.userId;
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er));
            },
            type: 'POST',

            async: false,
            contentType: true,
            complete: function () {
            },
            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    save_KiemTraNguyenVong: function (strKetQua_Id, strDeTai_Id) {
        var me = this;
        var strId = strKetQua_Id;
        var strTruongThongTin_Id = edu.util.getValById('dropNganh' + strKetQua_Id);
        if (!edu.util.checkValue(strTruongThongTin_Id)) {
            edu.system.start_Progress("zoneprocessXXXXCheck", function () {
                if (me.bCoLoiHoSo) return;
                if (me.strSinhVien_Id) {
                    me.save_HoSo();
                }
                me.save_TaiKhoan();
            });
            return;
        }
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        //Kiểm tra dữ liệu để them mới hoặc sửa
        if (strId.length == 30) strId = "";
        var obj_notify;
        var strNguoiThucHien_Id = edu.system.userId;
        //--Edit
        var obj_save = {
            'action': 'TS_ThiSinh_NguyenVong_KT/ThemMoi',

            'strId': strId,
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strNganhNghe_Id': edu.util.getValById('dropNganh' + strKetQua_Id),
            'strTS_Dot_DoiTuong_Id': me.strTuyenSinh_Id,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'iThuTu': edu.util.getValById('txtThuTu' + strKetQua_Id),
            'strTS_ToHop_Id': edu.util.getValById('dropToHop' + strKetQua_Id),
            'strNguoiThucHien_Id': strNguoiThucHien_Id,
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strKhoaKiemTraDuLieu': me.uuid,
        };
        //if (edu.util.checkValue(strId)) {
        //    obj_save.action = 'TS_ThiSinh_NguyenVong/CapNhat';
        //}
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success && data.Id) {
                    //edu.system.alert("Thực hiện thành công");
                    //me.save_TuNhapHoSo(obj_save);
                }
                else {
                    if (!me.bCoLoiHoSo) {
                        me.bCoLoiHoSo = true;
                        var html = '';
                        html += '<div class="row">';
                        html += '<p class="group-title-name">';
                        html += '<span class="badge bg-blue">Các thông tin không hợp lệ</span>';
                        html += '</p>';
                        html += '</div>';
                        html += '<div class="row">';
                        html += '<table id="tblBaoLoi" class="table">';
                        html += '<thead>';
                        html += '<tr>';
                        html += '<td class="td-fixed td-center">STT</td>';
                        html += '<td class="td-center">Thông tin</td>';
                        html += '<td class="td-center">Nội dung</td>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody></tbody>';
                        html += '</table>';
                        html += '</div>';
                        edu.system.alert(html);
                    }
                    setTimeout(function () {
                        var strErr = data.Message ? data.Message : "Không kiểm tra được dữ liệu";
                        var row = '';
                        row += '<tr>';
                        row += '<td></td>';
                        row += '<td>' + $("#dropNganh" + strKetQua_Id + " option:select").text() + '</td>';
                        row += '<td>' + strErr + '</td>';
                        row += '</tr>';
                        $("#tblBaoLoi tbody").append(row);
                    }, 1000);
                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er));
            },
            type: 'POST',

            async: false,
            contentType: true,
            complete: function () {
                edu.system.start_Progress("zoneprocessXXXXCheck", function () {
                    if (me.bCoLoiHoSo) return;
                    if (me.strSinhVien_Id) {
                        me.save_HoSo();
                    }
                    me.save_TaiKhoan();
                });
            },
            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    save_KiemTraKetQua: function (strKetQua_Id, strDeTai_Id) {
        var me = this;
        var strId = "";
        
        //Kiểm tra dữ liệu để them mới hoặc sửa
        if (strId.length == 30) strId = "";
        var obj_notify;
        var strNguoiThucHien_Id = edu.system.userId;
        //--Edit
        var obj_save = {
            'action': 'TS_ThiSinh_KetQua_KT/ThemMoi',


            'strTS_MonThi_Id': strKetQua_Id,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strDiem': edu.util.getValById('txtMonThi' + strKetQua_Id),
            'strKhoaKiemTraDuLieu': me.uuid,
            
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strNguoiThucHien_Id': strNguoiThucHien_Id,
        };
        //if (edu.util.checkValue(strId)) {
        //    obj_save.action = 'TS_ThiSinh_NguyenVong/CapNhat';
        //}
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success && data.Id) {
                    //edu.system.alert("Thực hiện thành công");
                    //me.save_TuNhapHoSo(obj_save);
                }
                else {
                    if (!me.bCoLoiHoSo) {
                        me.bCoLoiHoSo = true;
                        var html = '';
                        html += '<div class="row">';
                        html += '<p class="group-title-name">';
                        html += '<span class="badge bg-blue">Các thông tin không hợp lệ</span>';
                        html += '</p>';
                        html += '</div>';
                        html += '<div class="row">';
                        html += '<table id="tblBaoLoi" class="table">';
                        html += '<thead>';
                        html += '<tr>';
                        html += '<td class="td-fixed td-center">STT</td>';
                        html += '<td class="td-center">Thông tin</td>';
                        html += '<td class="td-center">Nội dung</td>';
                        html += '</tr>';
                        html += '</thead>';
                        html += '<tbody></tbody>';
                        html += '</table>';
                        html += '</div>';
                        edu.system.alert(html);
                    }
                    setTimeout(function () {
                        var strErr = data.Message ? data.Message : "Không kiểm tra được dữ liệu";
                        var row = '';
                        row += '<tr>';
                        row += '<td></td>';
                        row += '<td>' + $("#lblMonThi" + strKetQua_Id).html() + '</td>';
                        row += '<td>' + strErr + '</td>';
                        row += '</tr>';
                        $("#tblBaoLoi tbody").append(row);
                    }, 1000);
                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er));
            },
            type: 'POST',

            async: false,
            contentType: true,
            complete: function () {
                edu.system.start_Progress("zoneprocessXXXXCheck", function () {
                    if (me.bCoLoiHoSo) return;
                    if (me.strSinhVien_Id) {
                        me.save_HoSo();
                    }
                    me.save_TaiKhoan();
                });
            },
            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    save_NguyenVong: function (strKetQua_Id, strDeTai_Id) {
        var me = this;
        var strId = strKetQua_Id;
        var strTruongThongTin_Id = edu.util.getValById('dropNganh' + strKetQua_Id);
        if (!edu.util.checkValue(strTruongThongTin_Id)) {
            edu.system.start_Progress("zoneprocessXXXX", function () {
                me.getList_KetQuaDangKy();
            });
            return;
        }
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        //Kiểm tra dữ liệu để them mới hoặc sửa
        if (strId.length == 30) strId = "";
        var obj_notify;
        var strNguoiThucHien_Id = edu.system.userId;
        //--Edit
        var obj_save = {
            'action': 'TS_ThiSinh_NguyenVong/ThemMoi',

            'strId': strId,
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strNganhNghe_Id': edu.util.getValById('dropNganh' + strKetQua_Id),
            'strTS_Dot_DoiTuong_Id': me.strTuyenSinh_Id,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'iThuTu': edu.util.getValById('txtThuTu' + strKetQua_Id),
            'strTS_ToHop_Id': edu.util.getValById('dropToHop' + strKetQua_Id),
            'strNguoiThucHien_Id': strNguoiThucHien_Id,
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
        };
        if (edu.util.checkValue(strId)) {
            obj_save.action = 'TS_ThiSinh_NguyenVong/CapNhat';
        }
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    if (strId == "") {
                        strId = data.Id;
                    }
                }
                else {
                    obj_notify = {
                        type: "w",
                        title: obj_save + ": " + data.Message
                    };
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er));
            },
            type: 'POST',

            async: false,
            contentType: true,
            complete: function () {
                edu.system.start_Progress("zoneprocessXXXX", function () {
                    me.getList_KetQuaDangKy();
                });
            },
            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    getList_NguyenVong: function () {
        var me = this;
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id)
        var obj_list = {
            'action': 'TS_ThiSinh_NguyenVong/LayDanhSach',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strNganhNghe_Id': edu.util.getValById('dropAAAA'),
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
            'pageIndex': 1,
            'pageSize': 20000,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtResult = data.Data;
                    var iPager = 0;
                    me.dtNguyenVong = dtResult;
                    me.genHTML_NguyenVong_Data(dtResult);
                    dtResult.forEach(e => me.genHTML_MonThi(e.TS_TOHOP_ID));
                }
                else {
                    edu.system.alert(obj_list.action + ": " + data.Message, "w");
                }
            },
            error: function (er) {
                edu.system.alert(obj_list.action + " (er): " + JSON.stringify(er), "w");
            },
            type: "GET",
            action: obj_list.action,

            contentType: true,

            data: obj_list,
            fakedb: [
            ]
        }, false, false, false, null);
    },

    getList_NguyenVong_TT: function (strTuyenSinh_Id) {
        var me = this;
        var aData = me.dtTuyenSinh.find(e => e.ID === strTuyenSinh_Id);
        if (aData === undefined) return;
        var obj_list = {
            'action': 'TS_ThiSinh_NguyenVong/LayDanhSach',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strNganhNghe_Id': edu.util.getValById('dropAAAA'),
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
            'pageIndex': 1,
            'pageSize': 20000,
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtResult = data.Data;
                    dtResult.forEach(e => {
                        $("#tblCauHinhThongTin_TT").append('<input class="form-control thutunguyenvong" value="' + edu.util.returnEmpty(e.THUTU) + '" />');
                    });
                }
                else {
                    edu.system.alert(obj_list.action + ": " + data.Message, "w");
                }
            },
            error: function (er) {
                edu.system.alert(obj_list.action + " (er): " + JSON.stringify(er), "w");
            },
            type: "GET",
            action: obj_list.action,

            contentType: true,

            data: obj_list,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    delete_NguyenVong: function (strIds) {
        var me = this;
        var obj = {};
        var obj_delete = {
            'action': 'TS_ThiSinh_NguyenVong/Xoa',

            'strIds': strIds,
            'strNguoiThucHien_Id': edu.system.userId
        };
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    obj = {
                        content: "Xóa thành công!",
                        code: ""
                    };
                    edu.system.afterComfirm(obj);
                    me.getList_NguyenVong();
                    me.checkThemNguyenVong();
                }
                else {
                    obj = {
                        content: "" + data.Message,
                        code: ""
                    };
                    edu.system.afterComfirm(obj);
                }
            },
            error: function (er) {
                var obj = {
                    content: "(er): " + JSON.stringify(er),
                    code: "w"
                };
                edu.system.afterComfirm(obj);
            },
            type: 'POST',
            action: obj_delete.action,

            contentType: true,

            data: obj_delete,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    /*------------------------------------------
    --Discription: [4] GenHTML Kết quả Đề tài
    --ULR:  Modules
    -------------------------------------------*/
    genHTML_NguyenVong_Data: function (data) {
        var me = this;
        $("#tblCauHinhThongTin").html("");
        var aData2 = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        var row = '';
        for (var i = 0; i < data.length; i++) {
            var aData = data[i];
            var strKetQua_Id = aData.ID;
            //row += '<tr id="' + strKetQua_Id + '">';
            //row += '<td style="text-align: center"><label id="txtStt' + strKetQua_Id + '">' + (i + 1) + '</label></td>';
            //row += '<td><select id="dropThongTin' + strKetQua_Id + '" class="select-opt"><option value=""> --- Chọn thông tin--</option ></select ></td>';
            //row += '<td><input type="text" id="txtMoTa' + strKetQua_Id + '" value="' + edu.util.returnEmpty(aData.MOTA) + '" class="form-control"/></td>';
            //row += '<td><input type="text" id="txtThuTu' + strKetQua_Id + '" value="' + edu.util.returnEmpty(aData.THUTU) + '" class="form-control"/></td>';
            //row += '<td><input type="text" id="txtDoRong' + strKetQua_Id + '" value="' + edu.util.returnEmpty(aData.DORONG) + '" class="form-control"/></td>';
            //row += '<td><input type="text" id="txtBatBuoc' + strKetQua_Id + '" value="' + edu.util.returnEmpty(aData.BATBUOC) + '" class="form-control"/></td>';
            //row += '<td style="text-align: center"><a title="Xóa" class="deleteKetQua" id="' + strKetQua_Id + '" href="javascript:void(0)" style="color: red">Xóa</a></td>';
            //row += '</tr>';

            row += '<div class="row sv-info-regis-item" id="' + strKetQua_Id + '">';
            row += '<div class="col-12 col-md-2 col-stt">';
            row += '<div class="row">';
            row += '<div class="col-12 col-md-5 text-lable">Thứ tự nguyện vọng<span>*</span></div>';
            row += '<div class="col-12 col-md-7" style="padding-right: 0px">';
            row += '<div class="form-item d-flex mb-15 form-add-info">';
            row += '<div class="input-group">';
            row += '<i class="fal fa-angle-down"></i>';
            row += '<input class="form-control" value="' + edu.util.returnEmpty(aData.THUTU) + '" />';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '<div class="col-12 col-md-5 col-branch">';
            row += '<div class="row">';
            row += '<div class="col-12 col-md-3 text-lable">Chuyên ngành<span>*</span></div>';
            row += '<div class="col-12 col-md-9">';
            row += '<div class="form-item d-flex mb-15 form-add-info">';
            row += '<div class="input-group">';
            row += '<i class="fal fa-ballot-check"></i>';
            row += '<input class="form-control" value="' + edu.util.returnEmpty(aData.NGANHNGHE_TEN) + '" readonly="readonly" />';
            //row += '<select class="form-select" aria-label="Default select example"></select>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '<div class="col-12 col-md-4 col-subject">';
            row += aData.TS_TOHOP_TEN ? '<div class="row">' : '<div class="row" style="display: none">';
            row += '<div class="col-12 col-md-4 text-lable">' + edu.util.returnEmpty(aData2.TENHIENTHITOHOP) +'<span>*</span></div>';
            row += '<div class="col-12 col-md-8">';
            row += '<div class="form-item d-flex mb-15 form-add-info">';
            row += '<div class="input-group">';
            row += '<i class="fal fa-books"></i>';
            row += '<input class="form-control" value="' + edu.util.returnEmpty(aData.TS_TOHOP_TEN) + '" readonly="readonly" />';
            //row += '<select class="form-select" aria-label="Default select example"></select>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '</div>';
            row += '<div class="col-12 col-md-1 text-center col-delete">';
            row += '<button type="submit" class="btn btn-delete deleteKetQua" id="' + strKetQua_Id + '"><i class="fal fa-times"></i>';
            row += '</button>';
            row += '</div>';
            row += '</div>';
        }
        $("#tblCauHinhThongTin").html(row);
        var iSL = 3;
        if (me.dtCauHinhTuKhoa.find(e => e.DULIEU === "UTT") != undefined) iSL = 1;
        for (var i = data.length; i < iSL; i++) {
            var id = edu.util.randomString(30, "");
            me.genHTML_NguyenVong(id, "");
        }
        me.checkThemNguyenVong();
    },
    genHTML_NguyenVong: function (strKetQua_Id) {
        var me = this;
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        var iViTri = $("#tblCauHinhThongTin .sv-info-regis-item").length + 1;
        //$(".thutunguyenvong").each(function () {
        //    var iKetQua = $(this).val();
        //    iKetQua = parseInt(iKetQua);
        //    if (iKetQua >= iViTri) iViTri = iKetQua + 1;
        //});
        var row = '';
        row += '<div class="row sv-info-regis-item" id="' + strKetQua_Id + '">';
        row += '<div class="col-12 col-md-2 col-stt">';
        row += '<div class="row">';
        row += '<div class="col-12 col-md-5 text-lable">Thứ tự nguyện vọng<span>*</span></div>';
        row += '<div class="col-12 col-md-7" style="padding-right: 0px">';
        row += '<div class="form-item d-flex mb-15 form-add-info">';
        row += '<div class="input-group">';
        row += '<i class="fal fa-angle-down"></i>';
        row += '<input class="form-control thutunguyenvong" id="txtThuTu' + strKetQua_Id + '" value="' + iViTri + '" />';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '<div class="col-12 col-md-5 col-branch">';
        row += '<div class="row">';
        row += '<div class="col-12 col-md-3 text-lable">Chuyên ngành<span>*</span></div>';
        row += '<div class="col-12 col-md-9">';
        row += '<div class="form-item d-flex mb-15 form-add-info">';
        row += '<div class="input-group">';
        row += '<i class="fal fa-ballot-check"></i>';
        row += '<select id="dropNganh' + strKetQua_Id + '" class="form-select"></select>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '<div class="col-12 col-md-4 col-subject">';
        row += '<div class="row" id="zoneToHop' + strKetQua_Id +'" style="display: none">';
        row += '<div class="col-12 col-md-4 text-lable">' + edu.util.returnEmpty(aData.TENHIENTHITOHOP) +'<span>*</span></div>';
        row += '<div class="col-12 col-md-8">';
        row += '<div class="form-item d-flex mb-15 form-add-info">';
        row += '<div class="input-group">';
        row += '<i class="fal fa-books"></i>';
        row += '<select id="dropToHop' + strKetQua_Id + '" class="form-select"></select>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '</div>';
        row += '<div class="col-12 col-md-1 text-center col-delete">';
        row += '<button type="submit" class="btn btn-delete deleteRowButton" id="' + strKetQua_Id + '"><i class="fal fa-times"></i>';
        row += '</button>';
        row += '</div>';
        row += '</div>';
        $("#tblCauHinhThongTin").append(row);
        $("#dropNganh" + strKetQua_Id).select2();
        $("#dropToHop" + strKetQua_Id).select2();
        me.genComBo_NganhNghe("dropNganh" + strKetQua_Id, "");
        $('#dropNganh' + strKetQua_Id).on('change', function () {
            me.getList_TopHopMon($('#dropNganh' + strKetQua_Id).val(), "dropToHop" + strKetQua_Id, strKetQua_Id);
        });
        $('#dropToHop' + strKetQua_Id).on('change', function () {
            //var strKetQuaId = this.id.replace("dropToHop", "");
            //var dtRe = me.getList_MonThi(strKetQuaId);
            me.getAllMonThi();
        });
    },
    getAllMonThi: function () {
        var me = this;
        var arrCheck = [].concat(me.dtCheckKetQua);
        me.dtCheckKetQua = [];
        var x = $("#tblCauHinhThongTin .sv-info-regis-item");
        for (var i = 0; i < x.length; i++) {
            var strToHop_Id = $("#dropToHop" + x[i].id);
            if (strToHop_Id) {
                me.getList_MonThi(x[i].id);
            }
        }

        var arrX = me.dtCheckKetQua;
        arrX.forEach(e => {
            me.genHTML_MonThi(e);
        });
        arrCheck.forEach(e => {
            if (arrX.find(ele => ele.TS_MONTHI_ID === e.TS_MONTHI_ID) === undefined) {
                $("#tblMonThi tr[id='" + e.TS_MONTHI_ID + "']").remove();
            }
        });
    },
    /*------------------------------------------
    --Discription: [4] GenHTML Kết quả Đề tài
    --ULR:  Modules
    -------------------------------------------*/
    getList_NganhNghe: function () {
        var me = this;
        //--Edit
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        var obj_list = {
            'action': 'TS_Dot_DT_NganhNghe/LayDanhSach',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strNganhNghe_Id': edu.util.getValById('dropAAAA'),
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
            'pageIndex': 1,
            'pageSize': 100000,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.dtNganhNghe = dtReRult;
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
    genComBo_NganhNghe: function (strTinhTrang_Id, default_val) {
        var me = this;
        var obj = {
            data: me.dtNganhNghe,
            renderInfor: {
                id: "NGANHNGHE_ID",
                parentId: "",
                name: "NGANHNGHE_TEN",
                code: "NGANHNGHE_MA",
                default_val: default_val
            },
            renderPlace: [strTinhTrang_Id],
            type: "",
            title: "Chọn chuyên ngành"
        };
        edu.system.loadToCombo_data(obj);
    },
    getList_TopHopMon: function (strNganhNghe_Id, strTinhTrang_Id, strKetQua_Id) {
        var me = this;
        //--Edit
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id)
        var obj_list = {
            'action': 'TS_Dot_DT_NganhNghe/LayDSTS_ToHop_Theo_Nganh_Dot',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strNganhNghe_Id': strNganhNghe_Id,
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
            'pageIndex': 1,
            'pageSize': 100000,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.genComBo_ToHopMon(dtReRult, strTinhTrang_Id, strKetQua_Id);
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
    genComBo_ToHopMon: function (dtReRult, strTinhTrang_Id, strKetQua_Id) {
        var me = this;
        
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        var obj = {
            data: dtReRult,
            renderInfor: {
                id: "TS_TOHOP_ID",
                parentId: "",
                name: "TS_TOHOP_TEN",
                code: "TS_TOHOP_MA",
            },
            renderPlace: [strTinhTrang_Id],
            type: "",
            title: "Chọn " + edu.util.returnEmpty(aData.TENHIENTHITOHOP)
        };
        edu.system.loadToCombo_data(obj);
        if (dtReRult.length > 0) {
            //if (dtReRult.length == 1) {

            //}
            $("#" + strTinhTrang_Id).val(dtReRult[0].TS_TOHOP_ID).trigger("change").trigger({ type: 'select2:select' });
            $("#zoneToHop" + strKetQua_Id).attr("style", "");
        } else {
            $("#zoneToHop" + strKetQua_Id).attr("style", "display: none");
        }
    },
    /*------------------------------------------
    --Discription: [4] GenHTML Kết quả Đề tài
    --ULR:  Modules
    -------------------------------------------*/
    save_MonThi: function (strKetQua_Id, strDeTai_Id) {
        var me = this;
        var obj_notify;
        var strNguoiThucHien_Id = edu.system.userId;
        //--Edit
        var obj_save = {
            'action': 'TS_ThiSinh_KetQua/ThemMoi',
            'type': 'POST',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strTS_MonThi_Id': strKetQua_Id,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strDiem': edu.util.getValById('txtMonThi' + strKetQua_Id),
            'strNguoiThucHien_Id': strNguoiThucHien_Id,
        };
        if (edu.util.checkValue(obj_save.strId)) {
            obj_save.action = 'TS_ThiSinh_KetQua/CapNhat';
        }
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    if (obj_save.strId == "") {
                        edu.system.alert("Cập nhật thành công");
                    }
                }
                else {
                    obj_notify = {
                        type: "w",
                        title: obj_save + ": " + data.Message
                    };
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                edu.system.alert(JSON.stringify(er));
            },
            type: 'POST',

            contentType: true,
            complete: function () {
                edu.system.start_Progress("zoneprocessXXXX", function () {
                    me.getList_KetQuaDangKy();
                });
            },
            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    getList_MonThi: function (strToHop_Id) {
        var me = this;
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        //--Edit
        var obj_list = {
            'action': 'TS_Dot_DT_NganhNghe/LayDSTS_MonThi_Theo_Nganh_Dot',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strNganhNghe_Id': edu.util.getValById('dropNganh' + strToHop_Id),
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strDoiTuongDuTuyen_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strTS_ToHop_Id': edu.util.getValById('dropToHop' + strToHop_Id),
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.dtCheckKetQua = me.dtCheckKetQua.concat(dtReRult);
                    //dtReRult.forEach(e => {
                    //    me.genHTML_MonThi(e);
                    //});
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
            async: false,
            contentType: true,
            data: obj_list,
            fakedb: [

            ]
        }, false, false, false, null);
    },
    genHTML_MonThi: function (aData) {
        var me = this;
        if (!aData || aData.TS_MONTHI_ID === undefined || $("#tblMonThi tbody #" + aData.TS_MONTHI_ID).length > 0) return;
        var iViTri = $("#tblMonThi tbody tr").length;
        if (iViTri == 0) $("#tblMonThi").attr("style", "");
        //if (aData.THUTU) iViTri = aData.THUTU;
        var row = "";
        row += '<tr id="' + aData.TS_MONTHI_ID + '">';
        row += '<td style="text-align: center">' + (iViTri + 1) + '</td>';
        //VI
        var temp = aData.TINHCHAT_MA == '1' ? '<span>*</span>' : '';
        var classAdd = aData.TINHCHAT_MA == '1' ? 'batbuocmuonthi' : '';
        row += '<td id="lblMonThi' + aData.TS_MONTHI_ID + '">' + edu.util.returnEmpty(aData.TS_MONTHI_TEN) + ' ' + temp + '</td > ';
        row += '<td><input type="text" title="' + aData.TS_MONTHI_TEN +'" id="txtMonThi' + aData.TS_MONTHI_ID + '" value="' + edu.util.returnEmpty(aData.DIEM) + '" class="form-control ' + classAdd +'"/></td>';
        row += '</tr>';
        $("#tblMonThi tbody").append(row);
    },
    /*------------------------------------------
    --Discription: [4] GenHTML Kết quả Đề tài
    --ULR:  Modules
    -------------------------------------------*/
    getList_KetQuaThi: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_ThiSinh_KetQua/LayDanhSach',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strTS_MonThi_Id': edu.util.getValById('dropAAAA'),
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
            'pageIndex': 1,
            'pageSize': 10000,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.dtKetQuaThi = dtReRult;
                    //$("#tblMonThi").attr("style", "display: none");
                    $("#tblMonThi").parent().hide();
                    $("#tblMonThi tbody").html("");
                    dtReRult.forEach(e => {
                        me.genHTML_MonThi(e);
                    });

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
    
    save_TaiKhoan: function () {
        var me = this;
        me.iSendEmail = 0;
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        if (aData === undefined) {
            edu.system.alert("Đợt tuyển sinh không tồn tại");
            return;
        }
        //--Edit
        var obj_save = {
            'action': 'TS_TaiKhoan/KhoiTaoTaiKhoan',
            'type': 'GET',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strHoDem': edu.util.getValById('txtHoDem'),
            'strTen': edu.util.getValById('txtTen'),
            'strSoDienThoai': edu.util.getValById('txtSoDienThoai'),
            'strEmail': edu.util.getValById('txtEmail'),
            'strCMT': edu.util.getValById('txtCMT'),
            'strDotTuyenSinh_Id': aData.DOTTUYENSINH_ID,
            'strKhoaKiemTraDuLieu': me.uuid,
            'strDoiTuongTuyenSinh_Id': aData.DOITUONGDUTUYEN_ID,
            'strTS_KeHoachTuyenSinh_Id': aData.TS_KEHOACHTUYENSINH_ID,
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strNguoiThucHien_Id': edu.system.userId,

            'strAnhCaNhan': edu.system.getImage('txtAvartar', edu.system.userId),
            'strCMT_NgayCap': edu.util.getValById('txtNgayCap'),
            'strCMT_NoiCap': edu.util.getValById('txtNoiCap'),
            'strNgaySinh': edu.util.getValById('txtNgaySinh'),
            'strNoiSinh': edu.util.getValById('txtNoiSinh'),
            'strQuocTich_Id': edu.util.getValById('dropQuocTich'),
            'strGioiTinh_Id': edu.util.getValById('dropGioiTinh'),
            'strTS_DotTS_DoiTuong_Id': me.strTuyenSinh_Id,
            'strDaoTao_LopQuanLy_Id': me.strDaoTao_LopQuanLy_Id,
        };

        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    if (data.Data.length > 0) {
                        if (!me.iDaTaoTaiKhoan) {
                            edu.system.alert("Khởi tạo thành công");
                            //$("#zoneTaiKhoan").hide();
                            if (!edu.system.userId) {
                                edu.system.userId = data.Data[0].ID;
                            }
                            me.strSinhVien_Id = data.Data[0].ID;
                            $("#lblTenDangNhap").html(edu.util.returnEmpty(data.Data[0].NAME))
                            $("#lblMatKhau").html(edu.util.returnEmpty(data.Data[0].PASSWORDNOTMD5))
                            $("#lblMaHoSo").html(edu.util.returnEmpty(data.Data[0].MAHOSO))
                            $("#password").val(edu.util.returnEmpty(data.Data[0].PASSWORDNOTMD5))
                            $("#username").val(edu.util.returnEmpty(data.Data[0].NAME))
                            me.iDaTaoTaiKhoan = 1;
                            $(".btnThanhToanHocPhi").attr('href','./thanhtoan.aspx?strMa=' + data.Data[0].NAME)

                            if (data.Pager == 1) {
                                me.iSendEmail = 1;
                            }
                        }
                        me.save_All();
                    } else {
                        edu.system.alert("Không tạo được tài khoản");
                    }
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                me.iDemLanGoi = 0;
                //setTimeout(function () {
                //    me.getList_ThongTinTaiKhoan();
                //}, 10000);
                //edu.system.alert(obj_notify);
            },
            type: "POST",
            action: obj_save.action,
            async: false,
            complete: function () {
            },
            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
        setTimeout(function () {
            me.getList_ThongTinTaiKhoan();
        },240000)
    },

    getList_ThongTinTaiKhoan: function () {
        var me = this;
        me.iDemLanGoi++;
        if (me.iDemLanGoi > 100 || me.iDaTaoTaiKhoan) return;
        //--Edit
        var obj_list = {
            'action': 'TS_TaiKhoan/LayTTTaiKhoan',
            'type': 'GET',
            'strCMT': edu.util.getValById('txtCMT'),
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    if (data.Data.length > 0) {
                        if (!me.iDaTaoTaiKhoan) {
                            edu.system.alert("Khởi tạo thành công");
                            //$("#zoneTaiKhoan").hide();
                            if (!edu.system.userId) {
                                edu.system.userId = data.Data[0].ID;
                            }
                            me.strSinhVien_Id = data.Data[0].ID;
                            $("#lblTenDangNhap").html(edu.util.returnEmpty(data.Data[0].NAME))
                            $("#lblMatKhau").html(edu.util.returnEmpty(data.Data[0].PASSWORDNOTMD5))
                            $("#lblMaHoSo").html(edu.util.returnEmpty(data.Data[0].MAHOSO))
                            $("#password").val(edu.util.returnEmpty(data.Data[0].PASSWORDNOTMD5))
                            $("#username").val(edu.util.returnEmpty(data.Data[0].NAME))
                            me.iDaTaoTaiKhoan = 1;
                        }
                        me.save_All();
                    } else {
                        setTimeout(function () {
                            me.getList_ThongTinTaiKhoan();
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
    getList_KetQuaDangKy: function () {
        var me = this;
        me.getList_ThongTinDangKy();
        
    },
    HienThiKetQua: function () {
        var me = this;
        $("#modal-registration-notice").modal("show");
        if (edu.util.getValById('txtEmail')) {
            var objCheck = me.dtCauHinhTuKhoa.find(e => e.DINHDANH === "EMAIL_FILEDINHKEM");
            if (objCheck != undefined) {
                me.report(objCheck.DULIEU, objCheck.MOTA);
            } else {
                me.sendEmail(edu.util.getValById('txtEmail'));
                var objCheck = me.dtCauHinhTuKhoa.find(e => e.DINHDANH == "ANOTHER_EMAIL");
                if (objCheck != undefined) {
                    me.sendEmail(objCheck.DULIEU);
                }
            }
        }
    },

    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/
    getList_ThongTinDangKy: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_XacNhan/ThucHienTongHopDuLieu',
            'type': 'GET',
            'strQLSV_NguoiHoc_Id': edu.system.userId,
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    if (dtReRult.length > 0) {
                        $("#tblThongTinDangKy").show();
                        $("#tblThongTinDangKy tbody").html("");
                        var html = "";
                        dtReRult.forEach(e => {
                            html += '<tr>';
                            html += '<td>' + edu.util.returnEmpty(e.TEN) + '</td>';
                            html += '<td>' + edu.util.returnEmpty(e.GIATRI) + '</td>';
                            html += '</tr>';
                        })
                        $("#tblThongTinDangKy tbody").html(html);
                    } else {
                        $("#tblThongTinDangKy").hide();
                    }
                }
                else {
                    edu.system.alert(data.Message, "s");
                }
                me.HienThiKetQua();
            },
            error: function (er) {

                me.HienThiKetQua();
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
    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/
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

    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/
    getList_KetQuaNguyenVong: function () {
        var me = this;

        //--Edit
        var obj_list = {
            'action': 'TS_ThiSinh_NguyenVong/LayDSTS_ThiSinh_PhuongThuc',
            'type': 'GET',
            'strTuKhoa': edu.util.getValById('txtAAAA'),
            'strNganhNghe_Id': edu.util.getValById('dropAAAA'),
            'strDoiTuongDuTuyen_Id': edu.util.getValById('dropAAAA'),
            'strDotTuyenSinh_Id': edu.util.getValById('dropAAAA'),
            'strTS_KeHoachTuyenSinh_Id': edu.util.getValById('dropAAAA'),
            'strTS_HoSoDuTuyen_Id': me.strSinhVien_Id,
            'strNguoiTao_Id': edu.util.getValById('dropAAAA'),
            'pageIndex': 1,
            'pageSize': 10000,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    dtReRult.forEach(e => {
                        me.getList_NguyenVong_TT(e.TS_DOTTUYENSINH_DOITUONG_ID);
                    });
                    me.dtKetQuaNguyenVong = dtReRult;
                    me.genTable_KetQuaNguyenVong(dtReRult, data.Pager);
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
    genTable_KetQuaNguyenVong: function (data, iPager) {
        var me = this;
        /*III. Callback*/
        if (data.length > 0) edu.util.toggle_overide("zone-bus", "zoneketqua");
        var jsonForm = {
            strTable_Id: "tblKetQuaNguyenVong",
            aaData: data,
            colPos: {
                center: [0, 5],
                //right: [5]
            },
            bHiddenOrder: true,
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<div class="mobi-flex"><em class="show-in-mobi">Mã hồ sơ:</em><span class="name-file"> ' + edu.util.returnEmpty(aData.MAHOSO) + '</span></div>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Hình thức xét tuyển:</em> ' + edu.util.returnEmpty(aData.DOITUONGDUTUYEN_TEN);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<p class="show-in-mobi mb-0"><em>Danh sách nguyện vọng:</em></p><p class="mb-0">' + edu.util.returnEmpty(aData.NGUYENVONG) + '</p>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<span id="lblKetQua' + aData.ID + '"></span> ';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Đã nộp:</em> ' + edu.util.returnEmpty(aData.DANOP);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Phải nộp:</em> ' + edu.util.returnEmpty(aData.PHAINOP);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<a href="' + edu.util.returnEmpty(aData.PHUONGTHUCTHUTIEN_LINK) +'" target="_blank"><i class="fal fa-hand-holding-usd me-2"></i> HD nộp lệ phí</a>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<div class="text-center mobi-flex"><b class="show-in-mobi">Trạng thái:</b> <span class="text-66 ">' + edu.util.returnEmpty(aData.TS_XACNHANDUYETTT_TEN) + '</span></div>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<button class="btn btn-edit btnEdit" id="' + aData.TS_DOTTUYENSINH_DOITUONG_ID + '" title="Sửa"><i class="fal fa-edit"></i></button>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
        data.forEach(e => me.getList_ThanhToan2(e.ID, e.TS_KEHOACHTUYENSINH_ID, e.MAHOSO))
    },

    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/
    save_HoSo: function () {
        var me = this;
        var strNgaySinh = edu.util.getValById('txtNgaySinh');
        var arrNgaySinh = strNgaySinh.split('/');
        if (arrNgaySinh.length < 2) {
            edu.system.alert("Ngày sinh không đúng định dạng");
            return;
        }

        var obj_save = {
            'action': 'TS_HoSoDuTuyen/CapNhat',


            'strId': me.strSinhVien_Id,
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strMaSo': "",
            'strHoDem': edu.util.getValById("txtHoDem"),
            'strTen': edu.util.getValById("txtTen"),
            'strCMT_So': edu.util.getValById("txtCMT"),
            'strTTCN_DienThoai': edu.util.getValById("txtSoDienThoai"),
            'strTTCN_Email': edu.util.getValById("txtEmail"),
            'strNguoiThucHien_Id': edu.system.userId,

            'strNgaySinhDayDu': edu.util.getValById('txtNgaySinh'),
            'strCMT_NgayCap': edu.util.getValById('txtNgayCap'),
            'strCMT_NoiCap': edu.util.getValById('txtNoiCap'),
            'strNoiSinh_DiaChi': edu.util.getValById('txtNoiSinh'),
            'strAnhCaNhan': edu.system.getImage('txtAvartar', edu.system.userId),
            'strGioiTinh_Id': edu.util.getValById('dropGioiTinh'),
            'strQuocTich_Id': edu.util.getValById('dropQuocTich'),
            //'strNgaySinh_Nam': arrNgaySinh[2],
            //'strNgaySinh_Thang': arrNgaySinh[1],
            //'strNgaySinh_Ngay': arrNgaySinh[0],
        };

        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    edu.system.alert("Cập nhật thành công");
                }
                else {
                    edu.system.alert(data.Message);
                }
            },
            error: function (er) {
                //edu.system.alert(obj_notify);
            },
            type: "POST",
            action: obj_save.action,
            async: false,
            complete: function () {
            },
            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
    getDetail_TaiKhoan: function (strId) {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_HoSoDuTuyen/LayChiTiet',
            'type': 'GET',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strId': strId,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.viewForm_TaiKhoan(dtReRult, data.Pager);
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
    viewForm_TaiKhoan: function (data, iPager) {
        /*III. Callback*/
        if (data.length > 0) {
            var aData = data[0];
            edu.util.viewValById("txtHoDem", aData.HODEM);
            edu.util.viewValById("txtTen", aData.TEN);
            edu.util.viewValById("txtSoDienThoai", aData.TTCN_DIENTHOAI);
            edu.util.viewValById("txtEmail", aData.TTCN_EMAIL);
            edu.util.viewValById("txtCMT", aData.CMT_SO);

            edu.util.viewValById("txtNgayCap", aData.CMT_NGAYCAP);
            edu.util.viewValById("txtNoiCap", aData.CMT_NOICAP);
            edu.util.viewValById("txtNoiSinh", aData.CF_NI_SINH);
            edu.util.viewValById("dropGioiTinh", aData.GIOITINH_ID);
            edu.util.viewValById("dropQuocTich", aData.QUOCTICH_ID);
            //var strNgaySinh = "";
            //if (aData.NGAYSINH_NAM) strNgaySinh = aData.NGAYSINH_NAM;
            //if (aData.NGAYSINH_THANG) strNgaySinh = aData.NGAYSINH_THANG + "/" + strNgaySinh;
            //if (aData.NGAYSINH_NGAY) strNgaySinh = aData.NGAYSINH_NGAY + "/" + strNgaySinh;
            edu.util.viewValById("txtNgaySinh", aData.CF_NGAY_THANG_NAM_SINH);
            edu.util.viewValById("txtAvartar", aData.ANHCANHAN);////
            var strAnh = edu.system.getRootPathImg(aData.ANHCANHAN);
            $("#srctxtAvartar").attr("src", strAnh);////
        }
    },
    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/

    getList_KeHoach: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_KeHoachTuyenSinhCongKhai/LayDanhSach',
            'type': 'GET',
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.genComBo_KeHoach(dtReRult);
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
    genComBo_KeHoach: function (dtReRult) {
        var me = this;
        var obj = {
            data: dtReRult,
            renderInfor: {
                id: "ID",
                parentId: "",
                name: "TEN",
                code: "MA",
                default_val: 1
            },
            renderPlace: ["dropSearch_KeHoach"],
            type: "",
            title: "Chọn kế hoạch"
        };
        edu.system.loadToCombo_data(obj);
        (dtReRult.length) ? $("#dropSearch_KeHoach").parent().parent().parent().parent().show() : $("#dropSearch_KeHoach").parent().parent().parent().parent().hide();
    },

    /*------------------------------------------
    --Discription: [3] AccessDB HOC
    --ULR:  Modules
    -------------------------------------------*/

    getList_ThanhToan: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_ThiSinh_PhuongThuc/LayDanhSach',
            'type': 'GET',
            'strTS_KeHoachTuyenSinh_Id': edu.util.getValById('dropSearch_KeHoach'),
            'strTS_HoSoDuTuyen': edu.util.getValById('txtSearch_CMND'),
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.genTable_DangKy(dtReRult.rs);
                    me.genTable_TrangThai(dtReRult.rsDaNop);
                    me.genTable_PhaiNop(dtReRult.rsPhaiNop);
                    if (dtReRult.rsPhuongThucThanhToan && dtReRult.rsPhuongThucThanhToan.length > 0)
                    me.genTable_ThanhToan(dtReRult.rsPhuongThucThanhToan);
                    me.genTable_KetQuaTuyenSinh(dtReRult.rsKetQuaTS);
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

    getList_ThanhToan2: function (strId, strTS_KeHoachTuyenSinh_Id, strTS_HoSoDuTuyen) {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_ThiSinh_PhuongThuc/LayDanhSach',
            'type': 'GET',
            'strTS_KeHoachTuyenSinh_Id': strTS_KeHoachTuyenSinh_Id,
            'strTS_HoSoDuTuyen': strTS_HoSoDuTuyen,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    var html = '';
                    dtReRult.rsKetQuaTS.forEach(e => {
                        html += '<b>' + edu.util.returnEmpty(e.THANHPHAN_TEN) + '</b>: ' + edu.util.returnEmpty(e.KETQUA) + '<br/>';
                    });
                    $("#lblKetQua" + strId).html(html);
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
    getList_SinhVien: function () {
        var me = this;
        //--Edit
        var obj_list = {
            'action': 'TS_HoSoDuTuyen/LayChiTiet',
            'type': 'GET',
            'strChucNang_Id': edu.system.strChucNang_Id,
            'strId': edu.util.getValById('txtSearch_CMND')
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.genTable_SinhVien(dtReRult);
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

    genTable_SinhVien: function (data, iPager) {
        var me = this;
        $(".zone-pay").slideUp(300);
        var strTab = "pay_empty";
        if (data.length > 0) {
            strTab = "pay_thanhtoan";
            var aData = data[0];
            $(".lblHoTen").html(edu.util.returnEmpty(aData.HODEM) + " " + edu.util.returnEmpty(aData.TEN));
            $(".lblSoDienThoai").html(edu.util.returnEmpty(aData.TTCN_DIENTHOAI));
            $(".lblCMND").html(edu.util.returnEmpty(aData.CMT_SO));
            $(".lblEmail").html(edu.util.returnEmpty(aData.TTCN_EMAIL));
            me.getList_ThanhToan();
        } else {
            edu.system.alert("Hồ sơ không tồn tại!");
        }
        $("#" + strTab).slideDown(500);
    },
    genTable_TrangThai: function (data, iPager) {
        var jsonForm = {
            strTable_Id: "tblTrangThai_NopTien",
            aaData: data,
            colPos: {
                center: [0],
                right: [2]
            },
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Nội dung:</em>' + edu.util.returnEmpty(aData.TAICHINH_CACKHOANTHU_TEN);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<p class="mobi-flex"><b class="show-in-mobi">Số tiền:</b>' + edu.util.returnEmpty(aData.SOTIEN) + 'đ</p>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
    },
    genTable_DangKy: function (data, iPager) {

        var jsonForm = {
            strTable_Id: "tblDangKy_NopTien",
            aaData: data,
            colPos: {
                center: [0],
                //right: [5]
            },
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Mã hồ sơ:</em>' + edu.util.returnEmpty(aData.MAHOSO);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<p class=" mobi-flex"><b class="show-in-mobi">Nguyện vọng:</b><span>' + edu.util.returnEmpty(aData.NGUYENVONG) +'</span></p>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<p class=" mobi-flex"><b class="show-in-mobi">Phương thức:</b><span>' + edu.util.returnEmpty(aData.DOITUONGDUTUYEN_TEN) +'</span></p>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
    },
    genTable_PhaiNop: function (data, iPager) {
        var jsonForm = {
            strTable_Id: "tblPhaiNop",
            aaData: data,
            colPos: {
                center: [0],
                right: [2]
            },
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Nội dung:</em>' + edu.util.returnEmpty(aData.TAICHINH_CACKHOANTHU_TEN);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<p class="mobi-flex"><b class="show-in-mobi">Số tiền:</b>' + edu.util.returnEmpty(aData.SOTIEN) + 'đ</p>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
    },
    genTable_ThanhToan: function (data, iPager) {

        var jsonForm = {
            strTable_Id: "tblThanhToan",
            aaData: data,
            colPos: {
                //center: [0],
                //right: [5]
            },
            bHiddenOrder: true,
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Phương thúc:</em>' + edu.util.returnEmpty(aData.PHUONGTHUC_TEN);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        if (!aData.PHUONGTHUC_UNGDUNG) return '';
                        return '<a href="' + edu.util.returnEmpty(aData.PHUONGTHUC_UNGDUNG) + '" target="_blank"><i class="fal fa-hand-holding-usd me-2"></i> Nộp lệ phí</a>';
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        if (!aData.PHUONGTHUC_HDSD) return '';
                        return '<a href="' + edu.util.returnEmpty(aData.PHUONGTHUC_HDSD) + '" target="_blank"> Xem hướng dẫn</a>';
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
    },
    genTable_KetQuaTuyenSinh: function (data, iPager) {

        var jsonForm = {
            strTable_Id: "tblKetQuaTuyenSinh",
            aaData: data,
            colPos: {
                //center: [0],
                //right: [5]
            },
            bHiddenOrder: true,
            aoColumns: [
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Loại điểm:</em>' + edu.util.returnEmpty(aData.THANHPHAN_TEN);
                    }
                },
                {
                    "mRender": function (nRow, aData) {
                        return '<em class="show-in-mobi">Điểm:</em>' + edu.util.returnEmpty(aData.KETQUA);
                    }
                }
            ]
        };
        edu.system.loadToTable_data(jsonForm);
    },

    report: function (strLoaiBaoCao, strDuongDan, callback) {
        var me = this;
        var arrTuKhoa = [];
        var arrDuLieu = [];
        var aData = me.dtTuyenSinh.find(e => e.ID === me.strTuyenSinh_Id);
        //
        addKeyValue("strTS_HoSoTuyenSinh_Id", me.strSinhVien_Id);
        addKeyValue("strDoiTuongDuTuyen_Id", aData.DOITUONGDUTUYEN_ID);
        addKeyValue("saveFile", "pdf");
        addKeyValue("strLoaiBaoCao", strLoaiBaoCao);
        addKeyValue("strReportCode", strLoaiBaoCao);
        addKeyValue("strNguoiThucHien_Id", edu.system.userId);

        if (jQuery.type(callback) == "function") {
            var check = callback(addKeyValue);
            console.log(check);
            if (check == false) return;
        }
        //không sửa ở đây

        var obj_save = {
            'arrTuKhoa': arrTuKhoa,
            'arrDuLieu': arrDuLieu,
            'strNguoiThucHien_Id': edu.system.userId
        };
        //console.log(obj_save);
        //return;
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var strBaoCao_Id = data.Message;
                    if (!edu.util.checkValue(strBaoCao_Id)) {
                        edu.system.alert("Chưa lấy được dữ liệu báo cáo!");
                        return false;
                    }
                    else {
                        var url_report = edu.system.rootPathReport + "?id=" + strBaoCao_Id;
                        if (edu.util.checkValue(strDuongDan) && strDuongDan != "undefined") {
                            url_report = strDuongDan + "?id=" + strBaoCao_Id;
                            if (strDuongDan.indexOf("http") == -1) url_report = edu.system.strhost + url_report;
                        }
                        me.getList_BaoCao(url_report, strLoaiBaoCao);
                        //location.href = url_report;
                    }
                }
                else {
                    edu.system.alert("Có lỗi xảy ra vui lòng thử lại!");
                }
            },
            type: "POST",
            action: 'SYS_Report/ThemMoi',

            contentType: true,

            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);

        function addKeyValue(strTuKhoa, strDulieu) {
            arrTuKhoa.push(strTuKhoa);
            arrDuLieu.push(strDulieu);
        }
    },
    getList_BaoCao: function (strUrl, strToken) {
        var me = this;
        //--Edit
        $.ajax({
            type: "GET",
            crossDomain: true,
            url: strUrl,
            success: function (d, s, x) {
                var arrFile =[];
                if (d.Success) {

                    arrFile = [d.Data];
                    if (d.Data.indexOf(',')) {
                        arrFile = d.Data.split(',');
                    }
                    //arrFile.push(d.Data);
                } else {
                    edu.system.alert(d.Message);
                }
                console.log(arrFile);
                me.sendEmail(edu.util.getValById('txtEmail'), arrFile);
                var objCheck = me.dtCauHinhTuKhoa.find(e => e.DINHDANH == "ANOTHER_EMAIL");
                if (objCheck != undefined) {
                    me.sendEmail(objCheck.DULIEU, arrFile);
                }
            },
            error: function (x, t, m) {
                edu.system.alert(x);
            },
            data: {
            },
            cache: false,
        });
        //edu.system.makeRequest({aa
        //    success: function (data) {
        //        if (data.Success) {
        //            var dtReRult = data.Data;
        //            me.dtTuyenSinh = dtReRult;
        //            me.genTable_TuyenSinh(dtReRult, data.Pager);
        //        }
        //        else {
        //            edu.system.alert(data.Message, "s");
        //        }

        //    },
        //    error: function (er) {

        //        edu.system.alert(JSON.stringify(er), "w");
        //    },
        //    type: 'GET',
        //    action: obj_list.action,

        //    contentType: true,
        //    data: obj_list,
        //    fakedb: [

        //    ]
        //}, false, false, false, null);
    },
    
    callback_CMR: function (strUrl, strToken) {
        var me = this;
        //--Edit
        var custom_field = {};
        //for (var i = 0; i < me.dtTuNhapHoSo.length; i++) {
        //    arrCus.push({})
        //}
        custom_field["cf_ngay_thang_nam_sinh"] = $("#txtNgaySinh").val();
        custom_field["cf_ni_sinh"] = $("#txtNoiSinh").val();
        custom_field["cf_cccdcmtnd"] = $("#txtCMT").val();
        custom_field["mobile_number"] = $("#txtSoDienThoai").val();
        var i = 0;
        $("#tblCauHinhThongTin .deleteRowButton").each(function () {
            var strKetQua_Id = this.id.replace(/rm_row/g, '');
            custom_field["cf_nguyn_vng_" + ++i] = $('#dropNganh' + strKetQua_Id + " option:selected").text();
        });
        me.dtTuNhapHoSo.forEach(aData => {
            var strVal = "";
            switch (aData.KIEUDULIEU.toUpperCase()) {
                case "TINH":
                case "HUYEN":
                case "XA":
                case "LIST":
                    {
                        strVal = $("#m" + aData.ID + " option:selected").text();
                        break;
                    }

                default: strVal = $("#m" + aData.ID).val();
            }
            if (aData.MA) custom_field[aData.MA] = strVal;
        });
        
        var obj_save = {
            'action': 'TS_TaiKhoan/CallCRM',
            
            'url': strUrl,
            'token': strToken,
            'bodyrequest': JSON.stringify({
                'strId': '',
                'first_name': edu.util.getValById("txtHoDem"),
                'last_name': edu.util.getValById("txtTen"),
                'mobile_number': edu.util.getValById("txtSoDienThoai"),
                'email': edu.util.getValById("txtEmail"),
                'custom_field': custom_field
            })
        };

        //default
        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    //edu.system.alert("Cập nhật thành công");
                }
                else {
                    console.log(data.Message);
                }
            },
            error: function (er) {
                //edu.system.alert(obj_notify);
            },
            type: "POST",
            action: obj_save.action,
            complete: function () {
            },
            contentType: true,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
    },
}