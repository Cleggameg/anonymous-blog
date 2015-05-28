$(document).ready(function() {
  $(".entry_creation_form").submit(function(event){
    var form = $(this);
    event.preventDefault();
    $.ajax({
      url: "/entries",
      method: "post",
      data: form.serialize(),
      success: function(response){
        $("#all_entries").append(response.form);
        console.log(response.form);
        form[0].reset();
      }
    });
  });
  $(".create_tag_form").submit(function(event){
    var tags_form = $(this);
    var form_action = tags_form.attr('action');
    event.preventDefault();
    $.ajax({
      url: form_action,
      method: "post",
      data: tags_form.serialize(),
      success: function(response){
        $("#tags_list").append(response.form);
        $(".tag_text_area").val("");
      }
    });
  });

  $(".entry_edit_form").submit(function(event){
    console.log(event);
    event.preventDefault();
    var edit_form = $(this);
    var edit_action = edit_form.attr('action');
    $.ajax({
      url: edit_action,
      method: "put",
      data: edit_form.serialize(),
      success: function(response){
        $("h1").text(response.entry);
        $(".entry_edit_textarea").val("");
      }
    });

  });

  $(".quick_entry_delete").on("click", function(event){
    console.log("HEY!!!")
    var delete_url = $(this).attr("href");
    event.preventDefault();
    $.ajax({
      url: delete_url,
      method: "delete",
      success: function(response){
        console.log(response)
        console.log(response.link)
        $("#" + response.link).css("display", "none")
      }

    });
  });

});
