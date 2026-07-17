/*----------------------------------------------
--Author: 
--Phone:
--Date of created: 29/06/2018
--Input:
--Output:
--Note:
----------------------------------------------*/
function GiangDuong() { };
GiangDuong.prototype = {
    ilandau: 1,
    arrTimeCallDb: [0],
    swiper: null,
    strKhuVuc_Id: '',
    arrketqua: [],
    init: function () {
        var me = this;
        /*------------------------------------------
        --Discription: Initial system
        -------------------------------------------*/
        edu.system.appCode = "NS";
        var strKhuVuc_Id = localStorage.getItem("strKhuVuc_Id");
        console.log(strKhuVuc_Id)
        if (strKhuVuc_Id) me.strKhuVuc_Id = strKhuVuc_Id;
        me.getList_KhuVuc();
        me.showDay();

        $("#zoneKhuVuc").delegate('.btnSelectInList', 'click', function (e) {
            var strId = this.id;
            var point = this; e.preventDefault();
            var x = $("#zoneKhuVuc .btnSelectInList");
            for (var i = 0; i < x.length; i++) {
                x[i].classList.remove("btn-primary");
            }
            point.classList.add("btn-primary");
            me.strKhuVuc_Id = strId;
            localStorage.setItem("strKhuVuc_Id", strId);
            me.ilandau = 1;
            me.showDay();
        });
        //if (edu.system.userId) {
        //    me.showDay();
        //} else {
        //    //console.log(111111);
        //    //$("#btnDangNhapGiangDuong").trigger("click");
        //    $("#modal-sv-registration").modal("show")
        //}
        const urls = [
            "https://www.kbjfan.com/2025/08/16/korean-bj-pandaclass-2025-07-24/",
            "https://www.kbjfan.com/2025/08/16/korean-bj-pandaclass-2025-07-22/",
            "https://www.kbjfan.com/2025/08/16/korean-bj-pandaclass-2025-07-19/",
            "https://www.kbjfan.com/2025/08/03/korean-bj-pandaclass-2025-07-17/",
            "https://www.kbjfan.com/2025/07/27/korean-bj-pandaclass-2025-07-15/",
            "https://www.kbjfan.com/2025/07/27/korean-bj-pandaclass-2025-07-12/",
            "https://www.kbjfan.com/2025/07/22/korean-bj-pandaclass-2025-07-10/",
            "https://www.kbjfan.com/2025/07/21/korean-bj-pandaclass-2025-07-08/",
            "https://www.kbjfan.com/2025/07/21/korean-bj-pandaclass-2025-07-05/",
            "https://www.kbjfan.com/2025/07/21/korean-bj-pandaclass-2025-07-03/",
            "https://www.kbjfan.com/2025/07/21/korean-bj-pandaclass-2025-07-01/",
            "https://www.kbjfan.com/2025/07/21/korean-bj-pandaclass-2025-06-28/",
            "https://www.kbjfan.com/2025/07/21/korean-bj-pandaclass-2025-06-26/",
            "https://www.kbjfan.com/2025/07/09/korean-bj-pandaclass-2025-06-24/",
            "https://www.kbjfan.com/2025/07/09/korean-bj-pandaclass-2025-06-21/",
            "https://www.kbjfan.com/2025/06/29/korean-bj-pandaclass-2025-06-19/",
            "https://www.kbjfan.com/2025/06/29/korean-bj-pandaclass-2025-06-17/",
            "https://www.kbjfan.com/2025/06/06/korean-bj-pandaclass-2025-05-22/",
            "https://www.kbjfan.com/2025/05/31/korean-bj-pandaclass-2025-05-20/",
            "https://www.kbjfan.com/2025/05/31/korean-bj-pandaclass-2025-05-17/",
            "https://www.kbjfan.com/2025/05/31/korean-bj-pandaclass-2025-05-15/",
            "https://www.kbjfan.com/2025/05/19/korean-bj-pandaclass-2025-05-13/",
            "https://www.kbjfan.com/2025/05/18/korean-bj-pandaclass-2025-05-10/",
            "https://www.kbjfan.com/2025/05/18/korean-bj-pandaclass-2025-05-08/",
            "https://www.kbjfan.com/2025/05/11/korean-bj-pandaclass-2025-05-01/",
            "https://www.kbjfan.com/2025/05/07/korean-bj-pandaclass-2025-04-29/",
            "https://www.kbjfan.com/2025/05/07/korean-bj-pandaclass-2025-04-26/",
            "https://www.kbjfan.com/2025/05/03/korean-bj-pandaclass-2025-04-24/",
            "https://www.kbjfan.com/2025/04/28/korean-bj-pandaclass-2025-04-22/",
            "https://www.kbjfan.com/2025/04/26/korean-bj-pandaclass-2025-04-19/",
            "https://www.kbjfan.com/2025/04/24/korean-bj-pandaclass-2025-04-17/",
            "https://www.kbjfan.com/2025/04/20/korean-bj-pandaclass-2025-04-15/",
            "https://www.kbjfan.com/2025/06/29/korean-bj-pandaclass-2025-04-03/",
            "https://www.kbjfan.com/2025/04/04/korean-bj-pandaclass-2025-03-27/",
            "https://www.kbjfan.com/2025/04/02/korean-bj-pandaclass-2025-03-25/",
            "https://www.kbjfan.com/2025/04/01/korean-bj-pandaclass-2025-03-22/",
            "https://www.kbjfan.com/2025/03/27/korean-bj-pandaclass-2025-03-20/",
            "https://www.kbjfan.com/2025/03/25/korean-bj-pandaclass-2025-03-18/",
            "https://www.kbjfan.com/2025/03/23/korean-bj-pandaclass-2025-03-15/",
            "https://www.kbjfan.com/2025/03/20/korean-bj-pandaclass-2025-03-13/",
            "https://www.kbjfan.com/2025/03/18/korean-bj-pandaclass-2025-03-11/",
            "https://www.kbjfan.com/2025/03/15/korean-bj-pandaclass-2025-03-08/",
            "https://www.kbjfan.com/2025/03/15/korean-bj-pandaclass-2025-03-06/",
            "https://www.kbjfan.com/2025/03/12/korean-bj-pandaclass-2025-03-04/",
            "https://www.kbjfan.com/2025/03/09/korean-bj-pandaclass-2025-03-01/",
            "https://www.kbjfan.com/2025/03/09/korean-bj-pandaclass-2025-02-25/",
            "https://www.kbjfan.com/2025/03/04/korean-bj-pandaclass-2025-02-22/",
            "https://www.kbjfan.com/2025/02/27/korean-bj-pandaclass-2025-02-20/",
            "https://www.kbjfan.com/2025/02/24/korean-bj-pandaclass-2025-02-18/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-24/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-21/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-19/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-17/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-14/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-12/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-10/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-07/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-05/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-12-03/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-11-30/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-11-28/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-11-26/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-11-23/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-11-21/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-11-19/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-15/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-12/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-10/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-08/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-05/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-03/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-10-01/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-28/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-26/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-24/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-21/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-19/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-14/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-12/",
            "https://www.kbjfan.com/2025/01/03/korean-bj-pandaclass-2024-09-10/"
        ];


        //edu.system.alert('<div id="zoneprocessXXXX"></div>');
        if (urls && urls.length) {
            edu.system.genHTML_Progress("zoneprocessXXXX", urls.length);
            for (var i = 0; i < urls.length; i++) {
                me.get_CustomAPI(urls[i]);
            }
        }
    },

    get_CustomAPI: function (strId) {
        var me = this;
        //--Edit
        var obj_save = {
            'action': 'CM_UngDung/CustomAPIGet',
            'type': 'POST',
            'strHost': strId,
            'strApi': '',
            'strLoaiXacThuc': "",
            'strMaXacThuc': '',
            'strData': '',
            'strNguoiThucHien_Id': edu.system.userId,
        };
        //default

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var strKeHoach_Id = "";
                    let html = data.Data;
                    let ibatdau = html.indexOf('video-url=\"');
                    while (ibatdau != -1) {
                        let iketthuc = html.indexOf('.mp4\"', ibatdau);
                        let ketqua = html.substring(ibatdau + 11, iketthuc + 4)
                        let replace = html.substring(ibatdau, iketthuc + 4)
                        html = html.replace(replace, '');
                        if (ketqua != 'https://cdn.plyr.io/static/blank.mp4') me.arrketqua.push(ketqua);
                        ibatdau = html.indexOf('video-url=\"');
                    }
                }

            },
            error: function (er) {
                edu.system.alert("(er): " + JSON.stringify(er), "w");

            },
            type: 'POST',
            complete: function () {
                edu.system.start_Progress("zoneprocessXXXX", function () {
                    console.log(me.arrketqua.join('\n'));
                });
            },
            contentType: true,

            action: obj_save.action,
            data: obj_save,
            fakedb: [
            ]
        }, false, false, false, null);
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
        $("#lblNgayThu").html(iThu + " ngày " + strDay)
        $("#lblcurent_time").html(hour + ":" + minute)
        if (me.ilandau) {
            me.ilandau = 0;
            me.getList_LichGiang(strDay)
        } else { 
            //location.reload(); 
            if (date.getMinutes() == 0 && me.arrTimeCallDb.indexOf(date.getHours())) {
                location.reload(); 
            }

        }
        //me.getList_LichGiang(strDay)
        setTimeout(function () {
            me.showDay();
        }, 60000);
    },

    getList_KhuVuc: function (strNgayHoc) {
        var me = this;
        var obj_list = {
            'action': 'TKGG_GiangDuongTrucTuyen/LayDSKhuVuc',
            'type': 'GET',
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.genTable_KhuVuc(dtReRult, data.Pager);
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

    genTable_KhuVuc: function (data, iPager) {
        var me = this;
        var row = '';
        data.forEach(e => {
            row += '<a id="' +e.ID + '" class="btn btnSelectInList" style="cursor: pointer">' + e.TENKHUVUC  + '</a>';
        })
        $("#zoneKhuVuc").html(row);
        if (me.strKhuVuc_Id) $("#" + me.strKhuVuc_Id).addClass("btn-primary");
        if (data.length == 1 && me.strKhuVuc_Id != data[0].ID) $("#zoneKhuVuc #" + data[0].ID).trigger("click");
    },
    getList_LichGiang: function (strNgayHoc) {
        var me = this;
        var obj_list = {
            'action': 'TKGG_GiangDuongTrucTuyen/LayDSLichGiangTheoNgay',
            'type': 'GET',
            'strKhuVuc_Id': me.strKhuVuc_Id,
            'strNguoiThucHien_Id': edu.system.userId,
            'strNgayHoc': strNgayHoc,
        };
        //

        edu.system.makeRequest({
            success: function (data) {
                if (data.Success) {
                    var dtReRult = data.Data;
                    me.genTable_GiangDuong(dtReRult, data.Pager);
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

    genTable_GiangDuong: function (data, iPager) {
        var me = this;
        //if (data.length > 0) $("#lblGiangDuong").html(edu.util.returnEmpty(data[0].TOANHA_TEN));
        var html = "";
        //html += '<div class="swiper mySwiper">';
        //html += '<div class="swiper-wrapper">';
        data.forEach(aData => {
            var strPhut = aData.PHUTBATDAU ? edu.util.returnEmpty(aData.PHUTBATDAU) : "";
            var strPhutKetThuc = aData.PHUTKETTHUC ? edu.util.returnEmpty(aData.PHUTKETTHUC) : "";
            html += '<div class="swiper-slide">';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.GIOBATDAU) + 'h' + strPhut + '-' + edu.util.returnEmpty(aData.GIOKETTHUC) + 'h' + strPhutKetThuc;
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.GIANGDUONG_TEN);//'K1-305';
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.DAOTAO_HOCPHAN_MA);
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.DAOTAO_LOPHOCPHAN_TEN);//'POLI 4033-K70SP';
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.DAOTAO_LOPHOCPHAN_SOTHUCTE);//'POLI 4033-K70SP';
            html += '</div>';
            html += '<div class="led-table-cell">';
            html += edu.util.returnEmpty(aData.GIANGVIEN_HOTEN);//'POLI 4033-K70SP';
            html += '</div>';
            html += '</div>';
        })
        //html += '</div>';
        //html += '</div>';
        $("#tblGiangDuong").html(html);
        if (data.length > 0) {
            me.swiper = new Swiper(".mySwiper", {
                direction: "vertical",
                pagination: {
                    el: ".swiper-pagination",
                    clickable: true,
                },
                slidesPerView: "auto",
                loop: true,
                speed: 2000,
                autoplay: {
                    delay: 0,
                },
            });
            //if (me.ilandau) {
            //    me.ilandau = 0;
            //    me.swiper = new Swiper(".mySwiper", {
            //        direction: "vertical",
            //        pagination: {
            //            el: ".swiper-pagination",
            //            clickable: true,
            //        },
            //        slidesPerView: "auto",
            //        loop: true,
            //        speed: 2000,
            //        autoplay: {
            //            delay: 0,
            //        },
            //    });

            //}
            //else {
            //    console.log("update");
            //    me.swiper.update({
            //        direction: "vertical",
            //        pagination: {
            //            el: ".swiper-pagination",
            //            clickable: true,
            //        },
            //        slidesPerView: "auto",
            //        loop: true,
            //        speed: 2000,
            //        autoplay: {
            //            delay: 0,
            //        },
            //    });
            //}
            
        }
        
    },
}