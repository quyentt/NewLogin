<%@ Page Language="C#" MasterPageFile="emasterpage.Master" AutoEventWireup="true" CodeBehind="confirm.aspx.cs" Inherits="Apis.NewLogin.confirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">          
    <div class="test-info">
        <div class="container-xl position-relative z-1">
            <div class="test-label">Thông tin chi tiết về bài thi</div>

            <div class="test-row">
                <div class="label">Tên thí sinh:</div>
                <div class="info"><span><label id="lblHoTen"></label></span></div>
            </div>
            <div class="test-row">
                <div class="label">Mã thí sinh:</div>
                <div class="info"><span><label id="lblMaThiSinh"></label></span></div>
            </div>
            <div class="test-row">
                <div class="label">Thời gian thi:</div>
                <div class="info text-yellow"><span><label id="lblThoiGianLamBai"></label></span></div>
            </div>
            <div class="test-row">
                <div class="label">Môn thi:</div>
                <div class="info"><span><label id="lblMonThi"></label></span></div>
            </div>
            <div class="test-row">
                <div class="label">Phòng thi:</div>
                <div class="info"><span><label id="lblPhongThi"></label></span></div>
            </div>
            <div class="test-row">
                 <div class="info"><span style="color: black;font-size: 18px;"><label id="lblHuongDanThiSinhLamBai"></label></span></div>
            </div>
            <a href="#" id="btnBatDauLamBai" class="btn btn-xl btn-orange w-315 h-55 fs-28 text-uppercase mt-4 fw-bold">
                <span>làm bài thi</span>
                <i class="fas fa-arrow-right"></i>
            </a>
            <br>
            <input type="hidden" id="txtStudentExamroom_Id" value="<%=strStudentExamroom_Id %>" />
            <input type="hidden" id="txtExamRoomInfo_Id" value="<%=strExamRoomInfo_Id %>" />
            <input type="hidden" id="txtThiSinh_Id" value="<%=strThiSinh_Id %>" /> 
            <input type="hidden" id="txtMacAddress" value="<%=strMacAddress %>" />   
            <input type="hidden" id="txtIpAddress" value="<%=strIpAddress %>" />   
            <input type="hidden" id="txtComputerName" value="<%=strComputerName %>" />   
            <a href="danhsachphongthi.aspx" class="btn btn-xl btn-outline-white w-315 h-55 fs-24 mt-3 d-flex align-items-center justify-content-center">
                <i class="fal fa-arrow-left me-2"></i>
                <span>Quay về</span>

            </a>
        </div>
        <div class="image">
            <img src="eassets/images/start-1.png" alt="">
        </div>
    </div>
    
<!-- Modal -->
<div class="modal fade" id="zoneMatKhauPhongThi" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title m-h-c fs-5 text-center">
                    Nhập mật khẩu phòng thi
                </h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input class="form-control" type="text" name="" id="txtMatKhauPhongThi" placeholder="Nhập mật khẩu phòng thi" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Đóng</button>
                <a href="#" id="btn_NhapMatKhauPhongThi" type="button" class="btn btn-dask-blue">Xác nhận mật khẩu phòng thi</a>
            </div>
        </div>
    </div>
</div>
    <script src="ApisThiTracNghiem/Modules/confirm/script/confirm.js?v=<%= Guid.NewGuid().ToString() %>"></script>
    <script type="text/javascript">
        var main_doc = {};
        main_doc['confirm'] = new confirm();
        $(document).ready(function () {
            main_doc.confirm.init();
        });
    </script> 
</asp:Content>