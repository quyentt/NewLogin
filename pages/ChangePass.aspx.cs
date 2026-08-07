using System;
using System.Web;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Apis.Common.BO.Base;
using Apis.CommonV1.Base;
using Apis.Login.BO.Base;
using Apis.Login.Entity.Base;
using System.Web.Security;
using System.Net.Http;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;

namespace Apis.NewLogin.Pages
{
    public partial class ChangePass : System.Web.UI.Page
    {
        private string rootPathAPI = "";
        public string logo = "";
        private string lblExpiredSession = "";
        private string lblPass_notMatch = "";
        private string lblPass_wrongPass = "";
        private string lblError = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                rootPathAPI = AppSetting.GetString("RootPathAPI");
                logo = AppSetting.GetString("Logo");
            }
            catch (Exception ex)
            {
                lblNotify_ChangePass.Text = lblError + "Read config.xml file";
                Logger.WriteLog(Logger.LogType.Error, "Read config.xml file: " + ex);
            }
            getNotityContent();
        }
        protected void changePassword_Click(object sender, EventArgs e)
        {
            bool check = checkPassword();
            if (check)
            {
                changePassword();
            }
            else
            {
                lblNotify_ChangePass.Text = lblPass_wrongPass;
            }
        }
        private bool checkPassword()
        {
            bool check = false;
            string oldPassword = WebUser.GetPost("old_password", string.Empty);
            string password = MD5.Encrypt(oldPassword);
            string username = "";
            try
            {
                if (!HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    //Logger.WriteLog(Logger.LogType.Error, "get Tciket");
                    //GetTicket();
                    Response.Redirect("../Login.aspx", false);
                }
                username = (HttpContext.Current.User as CustomPrincipal).Username;
                Logger.WriteLog(Logger.LogType.Error, username);
                try
                {
                    var data = UserBo.Authenticate(username, password);
                    if (data != null)
                    {
                        if (data.Rows[0]["passed"].ToString() == "1")
                        {
                            check = true;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblNotify_ChangePass.Text = lblError + "UserBo.Authenticate('" + username + "', '" + MD5.Encrypt(password) + "')";
                    Logger.WriteLog(Logger.LogType.Error, "UserBo.Authenticate('" + username + "', '" + password + "'): " + ex);
                }
            }
            catch
            {
                lblNotify_ChangePass.Text = lblExpiredSession;
            }

            return check;
        }
        private void changePassword()
        {
            string password = WebUser.GetPost("new_password", string.Empty);
            string retype_password = WebUser.GetPost("retype_password", string.Empty);
            if (password != retype_password || password == "")
            {
                lblNotify_ChangePass.Text = lblPass_notMatch;
            }
            else
            {
                string userId = "";
                try
                {
                    userId = (HttpContext.Current.User as CustomPrincipal).User_Id;
                    if (userId != "")
                    {
                        try
                        {
                            var errorCode = UserBo.ChangePassword(userId, userId, MD5.Encrypt(password));
                            if (errorCode)
                            {
                                Response.Redirect("../index.aspx", false);
                            }
                            else
                            {
                                Response.Redirect("Pages/ChangePass.aspx", false);
                            }
                        }
                        catch (Exception ex)
                        {
                            lblNotify_ChangePass.Text = lblError + "UserBo.ChangePassword('" + userId + "', '" + userId + "', '" + MD5.Encrypt(password) + "')";
                            Logger.WriteLog(Logger.LogType.Error, "UserBo.ChangePassword('" + userId + "', '" + userId + "', '" + MD5.Encrypt(password) + "'): " + ex);
                        }
                    }
                    else
                    {
                        lblNotify_ChangePass.Text = lblExpiredSession;
                    }
                }
                catch
                {
                    lblNotify_ChangePass.Text = lblExpiredSession;
                }
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
                        case "CHANGEPASS.NOT_MATCH":
                            lblPass_notMatch = item["THONGTIN2"].ToString();
                            break;
                        case "SESSION.EXPIRED":
                            lblExpiredSession = item["THONGTIN2"].ToString();
                            break;
                        case "CHANGEPASS.WRONGPASS":
                            lblPass_wrongPass = item["THONGTIN2"].ToString();
                            break;
                        case "COMMON.ERROR":
                            lblError = item["THONGTIN2"].ToString();
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                lblNotify_ChangePass.Text = lblError + "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1)";
                Logger.WriteLog(Logger.LogType.Error, "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1): " + ex);
            }
        }
        
    }
}