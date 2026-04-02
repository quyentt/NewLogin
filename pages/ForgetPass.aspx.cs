using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Apis.Common.BO.Base;
using Apis.CommonV1.Base;
using Apis.Login.BO.Base;
using System.Data;

namespace Apis.NewLogin.Pages
{
    public partial class ForgetPass : System.Web.UI.Page
    {
        public string logo          = "";
        private string mailTo       = "";
        private string mailFrom     = "";
        private string mailPass     = "";
        private string displayName  = "";
        private string mailSubject  = "";
        private string strBody      = "";
        private string hostname     = "";
        private int port            = 0;
        private int passResetDateOfExpired = 1;
        private int PassResetCodeLong = 6;
        private string lblMail_noExist  = "";
        private string lblMail_invalid  = "";
        private string lblMail_sendOk   = "";
        private string lblError         = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                logo        = AppSetting.GetString("Logo");
                mailFrom    = AppSetting.GetString("MailServerAddress");
                mailPass    = AppSetting.GetString("MailServerPass");
                hostname    = AppSetting.GetString("MailServerHostname");
                port        = int.Parse(AppSetting.GetString("MailServerPort"));
                passResetDateOfExpired = int.Parse(AppSetting.GetString("PassResetDateOfExpired"));
                PassResetCodeLong = int.Parse(AppSetting.GetString("PassResetCodeLong"));
            }
            catch(Exception ex)
            {
                lblNotify_FP.Text = lblError + "Read config.xml file";
                Logger.WriteLog(Logger.LogType.Error, "Read config.xml file: " + ex);
            }
            getNotityContent();
        }
        protected void getPassword_Click(object sender, EventArgs e)
        {
            mailTo = WebUser.GetPost("email_getpassword", string.Empty);
            if (Utility.IsValidEmail(mailTo))
            {
                string strMaBiMat = "";
                try
                {
                    //1. gen code to restore password
                    var jsonData    = AuthorBo.TaoMaKhoiPhucMatKhau(mailTo, "", passResetDateOfExpired, PassResetCodeLong);
                    strMaBiMat      = jsonData.Rows[0]["MABIMAT"].ToString();
                    //2. Send code to email
                    if (strMaBiMat != "")
                    {
                        //2. send email
                        var body = strBody + strMaBiMat;
                        var message = WebUser.SendEmail(mailTo, mailFrom, mailPass, displayName, mailSubject, body, hostname, port);
                        if (message == "")
                        {
                            lblNotify_FP.Text   = lblMail_sendOk;
                            Session["email"]    = mailTo;
                            Response.Redirect("VerifyCode.aspx");
                        }
                        else
                        {
                            lblNotify_FP.Text = message;
                        }
                    }
                    else
                    {
                        lblNotify_FP.Text = lblMail_noExist;
                    }
                }
                catch(Exception ex)
                {
                    lblNotify_FP.Text = lblError + "AuthorBo.TaoMaKhoiPhucMatKhau('" + mailTo + "', '','" + passResetDateOfExpired + "', '" + PassResetCodeLong + "')";
                    Logger.WriteLog(Logger.LogType.Error, "AuthorBo.TaoMaKhoiPhucMatKhau('" + mailTo  +"', '','" + passResetDateOfExpired + "', '"+ PassResetCodeLong + "'): " + ex);
                }
            }
            else
            {
                lblNotify_FP.Text = lblMail_invalid;
            }
            
        }
        private void getNotityContent()
        {
            // Danhmuctenbang: CMS.NOTI
            var type_notify = "";
            try
            {
                var jsonNotify = DanhMucDuLieuBo.LayDanhSach("CMS.NOTI", "", 1);
                foreach (DataRow item in jsonNotify.Rows)
                {
                    type_notify = item["MA"].ToString();
                    switch (type_notify)
                    {
                        case "MAIL.CODE_RESET_PASS":
                            displayName = item["TEN"].ToString();
                            mailSubject = item["THONGTIN1"].ToString();
                            strBody = item["THONGTIN2"].ToString();
                            break;
                        case "MAIL.NOT_EXIST":
                            lblMail_noExist = item["THONGTIN2"].ToString();
                            break;
                        case "MAIL.INVALID":
                            lblMail_invalid = item["THONGTIN2"].ToString();
                            break;
                        case "MAIL.SEND_SUSCESS":
                            lblMail_sendOk = item["THONGTIN2"].ToString();
                            break;
                        case "COMMON.ERROR":
                            lblError = item["THONGTIN2"].ToString();
                            break;
                    }
                }
            }
            catch(Exception ex)
            {
                lblNotify_FP.Text = lblError + "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1)";
                Logger.WriteLog(Logger.LogType.Error, "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1): " + ex);
            }
        }
    }
}