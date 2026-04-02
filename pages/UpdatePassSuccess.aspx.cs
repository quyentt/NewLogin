using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Apis.Common.BO.Base;
using Apis.CommonV1.Base;
using Apis.Login.BO.Base;
using System.Data;

namespace Apis.NewLogin.Pages
{
    public partial class UpdatePassSuccess : System.Web.UI.Page
    {
        public string logo = "";
        private string lblChangePass_Ok = "";
        private string lblError = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                logo = AppSetting.GetString("Logo");
            }
            catch (Exception ex)
            {
                lblNotify_UPS.Text = lblError + "Read config.xml file";
                Logger.WriteLog(Logger.LogType.Error, "Read config.xml file: " + ex);
            }
            
            getNotityContent();
            lblNotify_UPS.Text = lblChangePass_Ok;
        }
        protected void backLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("../login.aspx", false);
        }
        private void getNotityContent()
        {
            // Danhmuctenbang: CMS.NOTI
            try
            {
                var type_notify = "";
                var jsonNotify = DanhMucDuLieuBo.LayDanhSach("CMS.NOTI", "", 1);
                foreach (DataRow item in jsonNotify.Rows)
                {
                    type_notify = item["MA"].ToString();
                    switch (type_notify)
                    {
                        case "CHANGEPASS.SUSSCESS":
                            lblChangePass_Ok = item["THONGTIN2"].ToString();
                            break;
                        case "COMMON.ERROR":
                            lblError = item["THONGTIN2"].ToString();
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                lblNotify_UPS.Text = lblError + "DanhMucDuLieuBo.LayDanhSach('CMS.NOTI', '', 1)";
                Logger.WriteLog(Logger.LogType.Error, "DanhMucDuLieuBo.LayDanhSach('','',''): " + ex);
            }
        }
    }
}