using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Apis.CommonV1.Base;
using Apis.Login.BO.Base;
using Apis.Common.BO.Base;
using System.Data;

namespace Apis.NewLogin.Pages
{
    public partial class VerifyCode : System.Web.UI.Page
    {
        public string logo                  = "";
        private string lblVerify_codeInput  = "";
        private string lblVerify_codeFailed = "";
        private string lblError             = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                logo = AppSetting.GetString("Logo");
            }
            catch(Exception ex)
            {
                lblNotify_VC.Text = lblError + "Read config.xml file";
                Logger.WriteLog(Logger.LogType.Error, "Read config.xml file: " + ex);
            }
            getNotityContent();
            lblNotify_VC.Text = lblVerify_codeInput;
            linkEmail_VC.Text = (string)Session["email"];
            linkEmail_VC.NavigateUrl = "https://mail.google.com/mail/u/0/#inbox";
        }
        protected void authenCode_Click(object sender, EventArgs e)
        {
            string verify_code  = WebUser.GetPost("verify_code", string.Empty);
            if (verify_code != "")
            {
                try
                {
                    var jsonData    = AuthorBo.KiemTraMaKhoiPhucMatKhau(verify_code);
                    string check    = jsonData.Rows[0]["KETQUA"].ToString();

                    if (check == "1")
                    {
                        Response.Redirect("UpdatePass.aspx");
                    }
                    else
                    {
                        lblNotify_VC.Text = lblVerify_codeFailed;
                        linkEmail_VC.Text = "";
                    }
                }
                catch(Exception ex)
                {
                    lblNotify_VC.Text = lblError + ": AuthorBo.KiemTraMaKhoiPhucMatKhau(" + verify_code + ")";
                    Logger.WriteLog(Logger.LogType.Error, "AuthorBo.KiemTraMaKhoiPhucMatKhau(" + verify_code + "): " + ex);
                }
            }
        }
        protected void resend_verifyCode_Click(object sender, EventArgs e)
        {

            Response.Redirect("ForgetPass.aspx");
        }
        private void getNotityContent()
        {
            // Danhmuctenbang: CMS.NOTI
            var type_notify = "";
            try
            {
                var jsonNotify  = DanhMucDuLieuBo.LayDanhSach("CMS.NOTI", "", 1);
                foreach (DataRow item in jsonNotify.Rows)
                {
                    type_notify = item["MA"].ToString();
                    switch (type_notify)
                    {
                        case "VERIFY.CODE_INPUT":
                            lblVerify_codeInput = item["THONGTIN2"].ToString();
                            break;
                        case "VERIFY.CODE_FAILED":
                            lblVerify_codeFailed = item["THONGTIN2"].ToString();
                            break;
                        case "COMMON.ERROR":
                            lblError = item["THONGTIN2"].ToString();
                            break;
                    }
                }
            }
            catch(Exception ex)
            {
                lblNotify_VC.Text = lblError + "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1)";
                Logger.WriteLog(Logger.LogType.Error, "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1): " + ex);
            }
        }
    }
}