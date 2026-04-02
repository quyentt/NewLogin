<%@ Page Language="C#" MasterPageFile="~/emasterpage.Master" AutoEventWireup="true" CodeBehind="eIndex.aspx.cs" Inherits="Apis.NewLogin.eindex" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">         
     <div class="container-xl main-content">
        <div class="start-page">
            <p class="welcome fs-30 text-center lh-40 mt-5">
                Chào mừng thí sinh                
                <b><%= (HttpContext.Current.User as Apis.CommonV1.Base.CustomPrincipal).Fullname %></b>
                <br> Đến với hệ thống thi trắc nghiệm
            </p>
            
            <p class="wlike">Chúc bạn may mắn!</p>
            <div class="d-flex justify-content-center image">
                <img src="assets/images/start-1.png" alt="">
            </div>
        </div>
    </div>
</asp:Content>
 