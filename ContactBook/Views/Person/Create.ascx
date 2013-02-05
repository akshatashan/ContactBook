<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ContactBook.Models.Person>" %>

<% using (Ajax.BeginForm("Create", "Person", null,
        new AjaxOptions
        {UpdateTargetId = "updateMessage",
            InsertionMode = InsertionMode.InsertAfter,
            HttpMethod = "POST",
            OnSuccess = "addSuccess",
        }, new { @id = "addPersonForm" }))        
    { %> 
    <%: Html.ValidationSummary(true) %>
    
     <div id="updateMessage"></div>
    
    <fieldset>
        <legend>Add Contact</legend>
        
        <div class="editor-label">
            <%: Html.LabelFor(model => model.FirstName) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.FirstName)%>
            <%: Html.ValidationMessageFor(model => model.FirstName)%>
        </div>

    
            <div class="editor-label">
                <%: Html.LabelFor(model => model.LastName) %>
            </div>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.LastName) %>
                <%: Html.ValidationMessageFor(model => model.LastName) %>
            </div>
    
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Email) %>
            </div>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Email) %>
                <%: Html.ValidationMessageFor(model => model.Email) %>
            </div>
  
            <div class="editor-label">
                <%: Html.LabelFor(model => model.Phone) %>
            </div>
             <div class="editor-field">
                <%: Html.EditorFor(model => model.Phone) %>
                <%: Html.ValidationMessageFor(model => model.Phone) %>
            </div>  

            <div class="editor-label">
                <%: Html.LabelFor(model => model.Web) %>
            </div>
            <div class="editor-field">
                <%: Html.EditorFor(model => model.Web) %>
                <%: Html.ValidationMessageFor(model => model.Web) %>
            </div>    
 

    </fieldset>
<% } %>