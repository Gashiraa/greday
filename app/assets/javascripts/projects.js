$(document).on("turbolinks:load", function () {

    $("#project_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    }); //PICKING A CUSTOMER IN PROJECT FORM

    if ($('#project-id').data('somedata')) {
        $("#invoice_form_projects").val([$('#project-id').data('somedata')]);
        $('#project_form_customer').select2().trigger('select2:select');

    }

    //Auto sort and select machines based on customer
    $('#project_form_customer').on('select2:select', function (e) {

        let customer;

        if (e.params) {
            customer = e.params.data.id
        } else {
            customer = $('#project_form_customer').children("option:selected").val();
        }

        $("#project_customer_machine_line_id > option").each(function () {
            if (this.getAttribute("customer") === customer) {
                this.style.display = "block";
                $('#project_customer_machine_line_id').val(this.value);
            } else {
                if (this.value !== "") {
                    this.style.display = "none";
                    $("#project_customer_machine_line_id").prop('selectedIndex', -1)
                }
            }
        });
        $('#project_customer_machine_line_id').trigger('change');
    });


    $('#project_form_customer').trigger({
        type: 'select2:select'
    });
});
