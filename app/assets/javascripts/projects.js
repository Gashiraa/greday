$(document).on("turbolinks:load", function () {

    $("#project_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    }); //PICKING A CUSTOMER IN PROJECT FORM

    if ($('#project-id').data('somedata')) {
        $("#invoice_form_projects").val([$('#project-id').data('somedata')]);
    }

    //Auto sort and select machiens based on customer
    $('#project_form_customer').on('select2:select', function (e) {
        var data = e.params.data;
        let customer = data.id;
        $("#project_customer_machine_line_id > option").each(function () {
            if (this.getAttribute("customer") === customer) {
                this.style.display = "block";
                $('#project_customer_machine_line_id').val(this.value);
            } else {
                this.style.display = "none";
            }
        });
        $('#project_customer_machine_line_id').trigger('change');
    });
});
