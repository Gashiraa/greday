$(document).on("turbolinks:load", function () {

    $("#machine_form_category").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });  //PICKING A CATEGORY IN EXTRA FORM

});