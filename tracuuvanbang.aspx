<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tracuuvanbang.aspx.cs" Inherits="Apis.NewLogin.tracuuvanbang" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Education management</title>
    <link rel="stylesheet" href="config.css">
    <link rel="stylesheet" href="assets/csstracuuvanbang/styles.css?v=3">
    <link rel="shortcut icon" type="image/x-icon" href="assets/images/logo.ico" />
     
     
    <style>
    .refresh-button {
    background-image:url(assets/images/refresh.png);
    background-repeat:no-repeat;
    background-position: center;
    width:50px;
    height:70px;
    background-color:#f7f7f7;
    border-radius: 5px;
    padding:10px;
    border: none;
    }
    .container { margin: 150px auto; }
      .captcha-box { border-radius: 5px; border: 2px solid; padding: 2rem; max-width: 400px; margin: 20px 0; }
     #canvas {
        width: 200px;
        height: 60px;
      }
    </style>
</head>


<body>
<div class="wrapper-admiss" id="wrapperadmiss">
    <!-- header -->
    <div class="overlay" id="overlay" style="position:fixed; margin-top:150px; z-index:1051; margin-left:50%; display:none">
        <i style="color:#00a65a; font-size: 40px" class="fad fa-sync-alt fa-spin"></i>
    </div>
     
    <div class="wrapper-admiss ad-fee">
        <!-- header -->
          <div class="header">
           
          </div>
        <!-- end header -->
        <!-- content -->
        <div class="page-content lephixettuyen">
            <div class="container-xl">
                <div class="sv-add-info">
                    <div class="sv-add-info-content sv-info-profile">
                        <div class="row">
                            <div class="col-12 col-lg-3 mb-15 text-center">
                                <img class="img-search" src="assets/images/img-vanban.jpg" alt="">
                            </div>
                            <div class="col-12 col-lg-9">
                                <div class="ad-fee-form">
                                    <div class="row sv-info-detail-item"  style="display:none">

                                        <div class="col-12 col-md-3 text-lable">Hệ đào tạo</div>
                                        <div class="col-12 col-md-9">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-graduation-cap"></i>
                                                    <select id="drpHeDaoTao" class="form-select select-opt">
                                                    </select></div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row sv-info-detail-item">

                                        <div class="col-12 col-md-3 text-lable">Loại văn bằng, chứng chỉ</div>
                                        <div class="col-12 col-md-9">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-regular fa-file-certificate"></i>  
                                                    <select id="drpLoaiVanBangChungChi" class="form-select select-opt"></select></div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row sv-info-detail-item">
                                        <div class="col-12 col-md-3 text-lable">Số hiệu</div>
                                        <div class="col-12 col-md-9">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-diploma"></i>
                                                   
                                                    <input id="txtSoHieuChungChi" class="form-control" value="" placeholder=""></div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row sv-info-detail-item" style="display:none">
                                        <div class="col-12 col-md-3 text-lable">Số vào sổ</div>
                                        <div class="col-12 col-md-9">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-diploma"></i>
                                                   
                                                    <input id="txtSoVaoSo" class="form-control" value="" placeholder=""></div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row sv-info-detail-item" id="zoneHoTenNgaySinh">
                                        <div class="col-12 col-md-3 text-lable">Họ tên đầy đủ</div>
                                        <div class="col-12 col-md-4">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group">
                                                    <i class="fal fa-user"></i>
                                                    <input id="txtHoTenDayDu" class="form-control" value="" placeholder=""></div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-2 text-lable">Ngày sinh</div>
                                        <div class="col-12 col-md-3">
                                            <div class="form-item d-flex mb-15 form-add-info">
                                                <div class="input-group icon-right">
                                                    <i class="fal fa-calendar-alt"></i>
                                                    <input id="txtNgaySinh" class="form-control" value="" placeholder="../../.."></div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row sv-info-detail-item"> 
                                           
                                    </div>
                                    
                                        
                                    <div class="row sv-info-detail-item">
                                         <div class="col-12 col-md-3 text-lable"><canvas id="canvas"></canvas>  </div>
                                        <div class="col-1 col-md-1 text-lable"><input type="button" style="height:inherit" class="refresh-button" onclick="refreshImage()" /></div>
                                        <div class="col-12 col-md-6 col-1 col-md-1 text-lable">
                                             
                                                <div class="input-group"> 
                                                    <input id="code" class="form-control" value="" placeholder="Nhập mã bảo vệ"></div>
                                             
                                        </div>
                                        <div class="col-12 col-md-2 text-center mb-15">
                                             
                                        </div>
                                      
                                        <div class="col-12 col-md-3">
                                            <button type="submit" id="btnSearch" class="btn btn-orange mb-15"><i class="fal fa-search me-2"></i>Tìm kiếm</button>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="ad-fee-result">
                            <div class="title-under-line text-dark-blue">
                                <span class="position-relative">Kết quả tìm kiếm</span>
                            </div>
                            <table id ="tblKetQuaTimKiem" class="table table-file">
                                <thead class="table-light">
                                    <tr>
                                        <th scope="col" class="text-center">STT</th>                                        
                                        <th scope="col">Họ và tên</th>
                                        <th scope="col">Giới tính</th>
                                        <th scope="col">Ngày sinh</th>
                                        <th scope="col">Nơi sinh</th>
                                        <th scope="col">Ngành đào tạo</th>
                                        <th scope="col">Chuyên ngành đào tạo</th>
                                        <th scope="col">Số hiệu văn bằng</th>
                                        <th scope="col">Số vào sổ</th>
                                        <th scope="col">Ngày cấp</th>
                                        <th scope="col">Tên văn bằng</th>
                                        <th scope="col" class="text-center">Chi tiết</th>
                                    </tr>
                                </thead>
                                <tbody>
                                     <!-- load from js -->
                                </tbody>
                                <tfoot></tfoot>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
            <!-- end content -->

            <!-- footer -->
                <div class="footer">
      

                </div>
            <!-- end footer -->

        </div>
        <!-- Button trigger modal -->

        <!-- Modal -->
        <div class="modal fade" id="zoneChiTietKetQuaTimKiem" tabindex="-1" aria-labelledby="exampleModalLabel" style="display: none">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Chi tiết - văn bằng chứng chỉ: <label class="lblHoTen"></label></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="vanbang-chitiet">
                            <div class="row vanbang-info">
                                <div class="col-12 col-lg-4 ">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Họ và tên</div>
                                        <div class="value lblHoTen"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Giới tính</div>
                                        <div class="value lblGioiTinh"></div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-4">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Ngày sinh</div>
                                        <div class="value lblNgaySinh"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Nơi sinh</div>
                                        <div class="value lblNoiSinh"></div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-4">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Dân tộc</div>
                                        <div class="value lblDanToc"></div>
                                    </div>

                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Quốc tịch</div>
                                        <div class="value lblQuocTich"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row my-4">
                                <div class="col-12 col-lg-7">
                                    <img class="w-100" src="assets/images/van-bang.jpg" alt="">
                                </div>
                                <div class="col-12 col-lg-5">
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Mã số sinh viên</div>
                                        <div class="value lblMaSoSinhVien"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Ngành đào tạo</div>
                                        <div class="value lblNganh"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Chuyên ngành</div>
                                        <div class="value lblChuyenNganh"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Lớp</div>
                                        <div class="value lblLop"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Trình độ đào tạo</div>
                                        <div class="value lblTrinhDo"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Hình thức đào tạo</div>
                                        <div class="value lblHinhThucDaoTao"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Khóa học</div>
                                        <div class="value lblKhoaHoc"></div>
                                    </div>
                                    <div class="line my-2"></div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Quyết định tốt nghiệp</div>
                                        <div class="value lblQuyetDinhTotNghiep"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Năm tốt nghiệp</div>
                                        <div class="value lblNamTotNghiep"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Xếp loại</div>
                                        <div class="value lblXepLoai"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Số hiệu văn bằng</div>
                                        <div class="value lblSoHieuVanBang"></div>
                                    </div>
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Số vào sổ</div>
                                        <div class="value lblSoVaoSo"></div>
                                    </div>
                                     <div class="vanbang-chitiet-row" id="zoneNgayCapBang">
                                        <div class="label">Ngày cấp bằng</div>
                                        <div class="value lblNgayCapBang"></div>
                                    </div>
                                   
                                    <div class="vanbang-chitiet-row">
                                        <div class="label">Ghi chú</div>
                                        <div class="value lblGhiChu"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
 
    <div id="alert"></div>
</div> 
 </body>  
<script src="assets/js/bootstrap.bundle.min.js "></script>
<script src="assets/js/jquery-2.2.0.min.js" type="text/javascript"></script>
<script src="assets/js/select2.min.js"></script>
<script src="assets/js/swiper-bundle.min.js"></script>
<script src="assets/js/slick.js"></script>
<script src="assets/js/custom.js"></script>
<script src="assets/js/crypto-js.js?v=3"></script>
<script src="assets/pagination/jquery.simplePagination.min.js?v=1.8"></script>

    
<script type="text/javascript" src="Core/constant.js?v=<%= Guid.NewGuid().ToString() %>"></script>    <!--CORE JS-->
<script type="text/javascript" src="Core/systemroot.js?v=<%= Guid.NewGuid().ToString() %>"></script>  <!--CORE JS-->
<script type="text/javascript" src="Core/util.js?v=<%= Guid.NewGuid().ToString() %>"></script>        <!--CORE JS-->
<script type="text/javascript" src="Core/systemextend.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
<script type="text/javascript" src="Config.js?v=<%= Guid.NewGuid().ToString() %>"></script><!--CORE JS-->
 <script src="assets/js/jscaptcha.js?v=1.3.2.4 "></script>
<script type="text/javascript">

    function Init_Prammater() {
        var rootPath        = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPath") %>';
        var rootPathUpload  = '<%= Apis.CommonV1.Base.AppSetting.GetString("RootPathUpload") %>';
        var rootPathReport  = '<%= report %>';

        var appId           = '<%= app_id %>';
        var avatar           = '<%= avatar %>';
        var userId          = '<%= user_id %>';
        var tokenJWT        = '<%= tokenjwt %>';

        var oConfig = {
            rootPath: rootPath,
            rootPathUpload: rootPathUpload,
            rootPathReport: rootPathReport,
                    
            avatar: avatar,
            folderAvatar: '',
            folderDoc: '',

            appId: appId,
            userId: userId,
            langId: '',
            tokenJWT: tokenJWT,
            iDisableChucNang: true
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
    
<script src="tracuuvanbang.js?v=<%= Guid.NewGuid().ToString() %>"></script>
    
<script type="text/javascript">
    const captcha = new Captcha($('#canvas'),{
        length: 4
    }); 
    var main_doc = {};
    main_doc['tracuuvanbang'] = new tracuuvanbang();
   
    $(document).ready(function () {
        
        main_doc.tracuuvanbang.init();
        
    });
    function refreshImage() { 
          captcha.refresh(); 
    }
      
</script> 
  
</html>
