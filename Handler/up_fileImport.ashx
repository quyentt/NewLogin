<%@ WebHandler Language="C#" Class="MulFileUp" %>
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using Apis.CommonV1.Base;

public class MulFileUp : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string outFolderPath = context.Request.QueryString["outFolderPath"].ToString();
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection UploadedFilesCollection = context.Request.Files;
                string strFile = "";
                var strtime = DateTime.Now.Year.ToString().Substring(2,2) + "-" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Hour.ToString() + "-" + DateTime.Now.Minute.ToString();
                for (int i = 0; i < UploadedFilesCollection.Count; i++)
                {
                    HttpPostedFile PostedFiles = UploadedFilesCollection[i];

                    string strExtension = System.IO.Path.GetExtension(PostedFiles.FileName).ToLower();
                    string fileName = PostedFiles.FileName.ToString().Replace(strExtension, "");

                    fileName = Utility.UnicodeToKoDauAndGach(fileName);
                    if (fileName.Length > 30) fileName = fileName.Substring(0, 30);
                    fileName += "_" + strtime + "_" + Guid.NewGuid().ToString().Replace("-","");
                        
                    if (IsFile(strExtension) && CheckSourceFile(ReadTwoBytes(PostedFiles.InputStream)))
                    {
                        string FilePath = context.Server.MapPath("~/"+ outFolderPath);
                        if (!Directory.Exists(FilePath))
                        {
                            Directory.CreateDirectory(FilePath);
                        }
                        PostedFiles.SaveAs(FilePath + fileName + strExtension);
                        strFile += FilePath + fileName + strExtension + ",";
                    }
                    else
                    {
                        context.Response.ContentType = "text/plain";
                        context.Response.Write("Loi system: File Khong duoc phep " + ReadTwoBytes(PostedFiles.InputStream));
                        return;
                    }
                }
                strFile = strFile.Substring(0, strFile.Length - 1);
                context.Response.ContentType = "text/plain";
                context.Response.Write(strFile);
            }
        }
        catch(Exception ex)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("Loi system: " + ex.ToString());
        }
    }
    private bool CheckSourceFile(string b)
    {
        bool result = false;
        Dictionary<string, string> imageHeader = new Dictionary<string, string>();
        imageHeader.Add("JPG", "255,216");
        imageHeader.Add("PNG", "137,80");
        imageHeader.Add("GIF", "71,73");
        imageHeader.Add("PDF", "37,80");
        imageHeader.Add("DOC", "80,75");
        imageHeader.Add("XLS", "208,207");
        imageHeader.Add("RAR", "82,97");     
       

        result = imageHeader.ContainsValue(b);

        return result;
    }
    private string ReadTwoBytes(Stream fsSource)
    {
        string result = "";
        try
        {
            byte[] bytes = new byte[2];
            int n = fsSource.Read(bytes, 0, 2);
            result = bytes.GetValue(0).ToString();
            result = result + "," + bytes.GetValue(1).ToString();
            return result;
        }
        catch
        {
            return "";
        }
    }
    private bool IsFile(string extension)
    {

        string check = ".xls.xlsx.doc.docx.mp3.wav";
        var ivitri = check.IndexOf(extension);
        if (ivitri != -1) return true;
        return false;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}