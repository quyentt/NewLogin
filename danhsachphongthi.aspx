<%@ Page Language="C#" MasterPageFile="emasterpage.Master" AutoEventWireup="true" CodeBehind="danhsachphongthi.aspx.cs" Inherits="Apis.NewLogin.danhsachphongthi" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">         
    
     <div class="user-info">
        <div class="container-xl">
            <div class="user-label">
                Thông tin cá nhân
            </div>
            <div class="row">
                <div class="col-12 col-md-2">
                    <div class="avata">
                        <img src="eassets/images/avata.png" alt="">
                    </div>
                </div>
                <div class="col-12 col-md-5">
                    <div class="row-info">
                        <div class="label">Họ và tên:</div>
                        <div class="info"><span><label id="lblHoTen"></label></span></div>
                    </div>
                    <div class="row-info">
                        <div class="label">Mã thí sinh:</div>
                        <div class="info"><span><label id="lblMaThiSinh"></label></span></div>
                    </div>
                    <div class="row-info">
                        <div class="label">Ngày sinh:</div>
                        <div class="info"><span><label id="lblNgaySinh"></label></span></div>
                    </div>
                </div>
                <div class="col-12 col-md-5">
                    <div class="row-info">
                        <div class="label">Số điện thoại:</div>
                        <div class="info"><span><label id="lblSoDienThoaiCaNhan"></label></span></div>
                    </div>
                    <div class="row-info">
                        <div class="label">Email:</div>
                        <div class="info"><span><label id="lblEmail"></label></span></div>
                        <input type="hidden" id="txtMacAddress" value="<%=strMacAddress %>" />   
                        <input type="hidden" id="txtIpAddress" value="<%=strIpAddress %>" />   
                        <input type="hidden" id="txtComputerName" value="<%=strComputerName %>" />   
                        <input type="hidden"  id="txtThiSinh_Id" value="<%=strThiSinh_Id %>" />                       
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-xl">
        <div class="section-label">
            Danh sách các bài thi của thí sinh
        </div>
        <div class="table-responsive">
            <table class="table fs-14" id="tblBaiThi">
                <thead>
                    <tr>
                        <th class="text-center" scope="col">STT</th>
                        <th class="text-center" scope="col">SBD</th>
                        <th class="text-center" scope="col">Bài thi</th>
                        <th class="text-center" scope="col">Trạng thái</th>
                        <th class="text-center" scope="col">Phòng thi</th>
                        <th class="text-center" scope="col">Ngày thi</th>
                        <th class="text-center" scope="col">Thông tin phòng thi</th>
                    </tr>
                </thead>
                <tbody></tbody>
                <tfoot></tfoot>
            </table>
        </div>
        <p class="text-center mt-2 fs-15">
            <b class="text-blue">* Hướng dẫn:</b> bấm vào dãy số <b>màu xanh gạch chân</b> đề chọn bài thi cần làm
        </p>
    </div>
      
   
<script src="ApisThiTracNghiem/Modules/danhsachphongthi/script/danhsachphongthi.js?v=<%= Guid.NewGuid().ToString() %>"></script>
      
<script type="text/javascript">
    var main_doc = {};
    main_doc['danhsachphongthi'] = new danhsachphongthi();
    $(document).ready(function () {
        main_doc.danhsachphongthi.init();
    });
</script>
<script type="text/javascript">
        function doExam(strStudentExamroom_Id, strThiSinh_Id, strExamRoomInfo_Id, strFinish, COFILEAUDIO) {
            var url = "";
             
            if (strFinish == '1')
                url = "ketquathi.aspx?strExamRoomInfo_Id=" + strExamRoomInfo_Id + "&strStudentExamroom_Id=" + strStudentExamroom_Id + "&strThiSinh_Id=" + strThiSinh_Id
            else {
                
                if (COFILEAUDIO != '0')
                    url = "TestAudio.aspx?strStudentExamroom_Id=" + strStudentExamroom_Id + "&strThiSinh_Id=" + strThiSinh_Id + "&strExamRoomInfo_Id=" + strExamRoomInfo_Id;
                    //url = "../../confirm/html/confirm.aspx?strStudentExamroom_Id=" + strStudentExamroom_Id + "&strThiSinh_Id=" + strThiSinh_Id + "&strExamRoomInfo_Id=" + strExamRoomInfo_Id+"&v=<%=Guid.NewGuid().ToString() %>";
                else
                    url = "confirm.aspx?strStudentExamroom_Id=" + strStudentExamroom_Id + "&strThiSinh_Id=" + strThiSinh_Id + "&strExamRoomInfo_Id=" + strExamRoomInfo_Id+"&v=<%=Guid.NewGuid().ToString() %>";
                
            }
            url += "&v=<%= System.Guid.NewGuid() %>";
            
                 
            window.open(url, "_parent");
        }

</script> 

</asp:Content>
 