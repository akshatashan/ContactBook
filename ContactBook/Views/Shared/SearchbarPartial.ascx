<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

@using (Html.BeginForm("Search", "Person"))
{
    @Html.TextBox("SearchText")
    <input type="submit" value="Search" class="search-button" />
}

