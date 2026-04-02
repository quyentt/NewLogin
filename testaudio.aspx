<%@ Page Language="C#" MasterPageFile="emasterpage.Master" AutoEventWireup="true" CodeBehind="testaudio.aspx.cs" Inherits="Apis.NewLogin.testaudio" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">         
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thi trắc nghiệm</title>
    <link rel="stylesheet" href="eassets/css/styles.css">
    <link rel="stylesheet" href="eassets/css/responsive.css">
    <link rel="stylesheet" href="eassets/Audio_Temp/css/AudioPlayer_Temp.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
     <script type="text/javascript" src="eassets/Audio_Temp/js/AudioPlayer_Temp.js"></script>
    <style>

    #player{         
        max-width: 700px;
        height: 50px;
        border: solid 1px gray;
    }
 
    </style>
        <div class="user-info testing">
            <div class="container-xl">
            <div class="row pt-3 ">
                <div class="col-12 col-md-6">
                    <div class="row-info">
                        <div class="label">Họ và tên:</div>
                        <div class="info"><span id="lblHoTen" style="text-align:left;"></span></div>
                    </div>
                    <div class="row-info">
                        <div class="label">Mã thí sinh:</div>
                        <div class="info"><span id="lblMaSinhVien" style="text-align:left;"></span></div>
                    </div>
                    <div class="row-info">
                        <div class="label">Số báo danh:</div>
                        <div class="info"><span id="lblSBD" style="text-align:left;"></span></div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="row-info">
                        <div class="label">Phòng thi:</div>
                        <div class="info"><span id="lblPhongThi" style="text-align:left;"></span></div>
                    </div>
                    <div class="row-info">
                        <div class="label">Môn thi:</div>
                        <div class="info"><span id="lblMonThi" style="text-align:left;"></span></div>
                        <input type="hidden" id="txtStudentExamroom_Id" value="<%=strStudentExamroom_Id %>" />
                        <input type="hidden" id="txtExamRoomInfo_Id" value="<%=strExamRoomInfo_Id %>" />
                        <input type="hidden" id="txtThiSinh_Id" value="<%=strThiSinh_Id %>" />
                    </div>
                </div>
            </div>
            <div class="line-1 bg-white mb-2"></div>
     
        </div>
        </div>
       
      <div class="container-xl">
            <div class="tabs mt-4">                 
                 <div class="tab-c">                     
                     <div class="tab-c-i">
                         <div class="btn-c-g d-flex justify-content-center mt-4"> 
                                <p class="mb-2" style="color:red"><b>MỜI BẠN THỬ TAI NGHE</b></p>    
                         </div>           
                         <div class='btn-c-g d-flex justify-content-center mt-4'  id="zoneTableAudioPart">                            
                            
                         </div>
                           <div class="btn-c-g d-flex justify-content-center mt-4"> 
                                 <a href="#" id="btnBatDauLamBai" class="btn btn-xl btn-orange w-315 h-55 fs-28 text-uppercase mt-4 fw-bold" onclick="confirm();">
                                <span>làm bài thi</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                         </div>
                         
                     </div>
                     
                 </div>
                  
            </div>
        </div>
    
     
           
     
     
<script src="ApisThiTracNghiem/Modules/danhsachphongthi/script/testaudio.js?v=<%= Guid.NewGuid().ToString() %>"></script>
     <script type="text/javascript">
                function Init_Prammater() {
                    var rootPath        = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPath") %>';
                    var rootPathUpload = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>';
                    var RootAudioFiles  = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootAudioFiles") %>';
                    var rootPathReport  = '<%= report %>';

                    var appId           = '<%= app_id %>';
                    var avatar           = '<%= avatar %>';
                    var userId          = '<%= user_id %>';
                    var tokenJWT        = '<%= tokenjwt %>';

                    var oConfig = {
                        rootPath: rootPath,
                        rootPathUpload: rootPathUpload,
                        rootPathReport: rootPathReport,
                        RootAudioFiles: RootAudioFiles,
                    
                        avatar: avatar,
                        folderAvatar: '',
                        folderDoc: '',

                        appId: appId,
                        userId: userId,
                        langId: '',
                        tokenJWT: tokenJWT
                    };
                
                    return oConfig;
            }
             var edu = {};
                edu['system']   = new systemroot();
                edu['extend']   = new systemextend();
                edu['constant'] = new constant();
                edu['util']     = new util();
                $(document).ready(function () {
                    edu.system.startApp();
                    edu.extend.init();
                    edu.constant.init();
                });
            
        </script>
<script type="text/javascript">
    var main_doc = {};
    main_doc['testaudio'] = new testaudio();
    $(document).ready(function () {
        main_doc.testaudio.init();
    });
</script>
<script type="text/javascript">
    function confirm() {
        var url = "";
        strStudentExamroom_Id = document.getElementById("txtStudentExamroom_Id").value ;
        strThiSinh_Id = document.getElementById("txtThiSinh_Id").value ;
        strExamRoomInfo_Id = document.getElementById("txtExamRoomInfo_Id").value ;
        console.log(strExamRoomInfo_Id);
        url = "confirm.aspx?strStudentExamroom_Id=" + strStudentExamroom_Id + "&strThiSinh_Id=" + strThiSinh_Id + "&strExamRoomInfo_Id=" + strExamRoomInfo_Id+"&v=<%=Guid.NewGuid().ToString() %>";
        url += "&v=<%= System.Guid.NewGuid() %>";
        window.open(url, "_parent");
    }

</script> 

</asp:Content>
 