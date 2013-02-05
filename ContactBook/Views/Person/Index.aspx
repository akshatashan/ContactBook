<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<IEnumerable<ContactBook.Models.Person>>" MasterPageFile="~/Views/Shared/Site.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="commonMessage"></div>
    <div id="updateDialog" title="Update Contact"></div>
    <div id="createDialog" title="Add Contact"></div>
    <div id="deleteDialog" title="Confirmation">
        <p>Are you sure you want to delete this contact?</p>
     </div>
    <%: Html.Partial("SearchBarPartial") %>
    <%: Html.ActionLink("Add", "Create",null, new { @class = "addLink" })%>
    <table>
    
    <% foreach (var item in Model) { %>
        <tr>
            <td>
                <strong><span class="FirstName"><%: Html.DisplayFor(modelItem => item.FirstName) %></span></strong>
            </td>
            <td>
                <strong><span class="LastName"><%: Html.DisplayFor(modelItem => item.LastName) %></span></strong>
            </td>
            <td>
                <strong><span class="Email"><%: Html.DisplayFor(modelItem => item.Email) %></span></strong>
            </td>
            <td>
                <strong><span class="Phone"><%: Html.DisplayFor(modelItem => item.Phone) %></span></strong>
            </td>
            <td>
               <strong><span class="Web"><%: Html.DisplayFor(modelItem => item.Web) %></span></strong>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { id = item.Id }, new { @class = "editLink" })%>
                <%: Html.ActionLink("Delete", "Delete", new { id=item.Id }, new {@class = "deleteLink" }) %>
            </td>
        </tr>

    <% } %>
    
    </table>

<script type="text/javascript">


    var linkObj;
    $.ajaxSetup({ cache: false });

    $(function () {
        //display the action links as buttons.
        $(".editLink").button();
        $(".addLink").button();
        $(".deleteLink").button();


        $(".deleteLink").click(function () {
            //assign the linkObj to the current context object
            linkObj = $(this);
            var dialogDiv = $('#deleteDialog');
            dialogDiv.dialog('open');
            return false; // prevents the default behaviour
        });

        $("#deleteDialog").dialog({
            autoOpen: false, width: 400, resizable: false, modal: true, //Dialog options
            autoOpen: false,
            width: 400,
            resizable: false,
            modal: true,
            buttons: {
                "Continue": function () {
                    $.post(linkObj.attr('href'), function (data) {  //Post to action
                        if (data == '<%= Boolean.TrueString %>') {
                            linkObj.closest("tr").hide('fast'); //Hide Row
                        }
                        else {
                            //(optional) Display Error
                        }
                    },deleteSuccess);
                    $(this).dialog("close");
                },
                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#updateDialog").dialog({
            autoOpen: false,
            width: 400,
            resizable: false,
            modal: true,
            buttons: {
                "Update": function () {
                    $("#updateMessage").html(''); //make sure there are no messages initially.
                    $("#updatePersonForm").submit();
                },
                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        });

        $(".editLink").click(function () {
            linkObj = $(this);
            var dialogDiv = $('#updateDialog');
            var viewUrl = linkObj.attr('href');
            $.get(viewUrl, function (data) {
                dialogDiv.html(data);
                //validation
                var $form = $("#updatePersonForm");
                // Unbind existing validation
                $form.unbind();
                $form.data("validator", null);
                // Check document for changes
                $.validator.unobtrusive.parse(document);
                // Re add validation with changes
                $form.validate($form.data("unobtrusiveValidation").options);
                //open dialog                            
                dialogDiv.dialog('open');

            });
            return false;
        });

        $("#createDialog").dialog({
            autoOpen: false,
            width: 400,
            resizable: false,
            modal: true,
            buttons: {
                "Create": function () {
                    $("#updateMessage").html(''); 
                    $("#addPersonForm").submit(); //posting to action using the id of the partial view for Create
                    //location.reload(true);
                },
                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        });

        $(".addLink").click(function () {
            //change the title of the dialgo
            linkObj = $(this);
            var dialogDiv = $('#createDialog');
            var viewUrl = linkObj.attr('href');
            $.get(viewUrl, function (data) {
                dialogDiv.html(data);
                //get the handle to the Create partial view.
                var $form = $("#addPersonForm");                          
                dialogDiv.dialog('open');

            });
            return false;
        });

    });


    function deleteSuccess() {
        if ($("#updateMessage").html() == "True") {
            location.reload(true);
        }
    }

    function updateSuccess() {
        if ($("#updateMessage").html() == "True") {
            //update the data on the page without server call.
            var parent = linkObj.closest("tr");
            parent.find(".FirstName").html($("#FirstName").val());
            parent.find(".LastName").html($("#LastName").val());
            parent.find(".Email").html($("#Email").val());
            parent.find(".Phone").html($("#Phone").val());
            parent.find(".Web").html($("#Web").val());

            //now we can close the dialog
            $('#updateDialog').dialog('close');
            $('#commonMessage').html("Create/Update Complete");
            //displaying the message to the user after closing the dialog.
            $('#commonMessage').delay(400).slideDown(400).delay(3000).slideUp(400);
        }
        else {
            $("#updateMessage").show();
        }
    }

    function addSuccess() {
        if ($("#updateMessage").html() == "True") {
            location.reload(true);
        }
    }


</script>
  
</asp:Content>
