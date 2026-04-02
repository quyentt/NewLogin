using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Apis.Common.BO.Base;
using Apis.CommonV1.Base;
using Apis.Login.BO.Base;
using System.Data;

namespace Apis.NewLogin.Pages
{
    public partial class UpdatePass : System.Web.UI.Page
    {
        public string logo                  = "";
        private string lblPass_notMatch     = "";
        private string lblExpiredSession    = "";
        private string lblChangePass_Ok     = "";
        private string lblVerifyCode_Ok     = "";
        private string lblError             = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                logo = AppSetting.GetString("Logo");
            }
            catch (Exception ex)
            {
                lblNotify_UP.Text = lblError + "Read config.xml file";
                Logger.WriteLog(Logger.LogType.Error, "Read config.xml file: " + ex);
            }
            getNotityContent();
            lblNotify_UP.Text = lblVerifyCode_Ok;
        }
        protected void updatePass_Click(object sender, EventArgs e)
        {
            string email            = (string)Session["email"];
            string password         = WebUser.GetPost("new_pass", string.Empty);
            string retype_password  = WebUser.GetPost("renew_pass", string.Empty);
            //get
            var userId = getDetailUser(email);
            if (userId != "")
            {
                if (password != retype_password || password == "")
                {
                    lblNotify_UP.Text = lblPass_notMatch;
                }
                else
                {
                    Session["email"] = null;
                    changePassword(userId, password);
                }
            }
            else
            {
                lblNotify_UP.Text = lblExpiredSession + " UserId is null";
            }
        }
        private void changePassword(string userId, string password)
        {
            try
            {
                Logger.WriteLog(Logger.LogType.Error, "1111");
                var errorCode = UserBo.ChangePassword(userId, userId, MD5.Encrypt(password));
                Logger.WriteLog(Logger.LogType.Error, "222");
                Logger.WriteLog(Logger.LogType.Error, errorCode? "OK": "False");
                if (errorCode)
                {
                    Response.Redirect("UpdatePassSuccess.aspx", false);
                }
                else
                {
                    lblNotify_UP.Text = lblError;
                }
            }
            catch (Exception ex)
            {
                lblNotify_UP.Text = lblError + "UserBo.ChangePassword('"+ userId + "', '" + userId + "', '" + MD5.Encrypt(password) + "')";
                Logger.WriteLog(Logger.LogType.Error, "UserBo.ChangePassword('" + userId + "', '" + userId + "', '" + MD5.Encrypt(password) + "'): " + ex);
            }
        }
        private string getDetailUser(string email)
        {
            var user_Id         = "";
            try
            {
                var jsonUser    = UserBo.GetDetail(email);
                foreach (DataRow item in jsonUser.Rows)
                {
                    user_Id = item["ID"].ToString();
                }
            }
            catch(Exception ex)
            {
                lblNotify_UP.Text = lblError + "UserBo.getDetail('" + email + "')";
                Logger.WriteLog(Logger.LogType.Error, "UserBo.getDetail('" + email + "'): " + ex);
            }
            
            return user_Id;
        }
        private void getNotityContent()
        {
            // Danhmuctenbang: CMS.NOTI
            try
            {
                var type_notify = "";
                var jsonNotify  = DanhMucDuLieuBo.LayDanhSach("CMS.NOTI", "", 1);
                foreach (DataRow item in jsonNotify.Rows)
                {
                    type_notify = item["MA"].ToString();
                    switch (type_notify)
                    {
                        case "CHANGEPASS.NOT_MATCH":
                            lblPass_notMatch = item["THONGTIN2"].ToString();
                            break;
                        case "SESSION.EXPIRED":
                            lblExpiredSession = item["THONGTIN2"].ToString();
                            break;
                        case "CHANGEPASS.SUSSCESS":
                            lblChangePass_Ok = item["THONGTIN2"].ToString();
                            break;
                        case "VERIFY.CODE_SUCCESS":
                            lblVerifyCode_Ok = item["THONGTIN2"].ToString();
                            break;
                        case "COMMON.ERROR":
                            lblError = item["THONGTIN2"].ToString();
                            break;
                    }
                }
            }
            catch(Exception ex)
            {
                lblNotify_UP.Text = lblError + "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1)";
                Logger.WriteLog(Logger.LogType.Error, "DanhMucDuLieuBo.LayDanhSach('','',''): " + ex);
            }
        }
    }
}