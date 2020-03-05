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

        $("#project_machine_id > option").each(function () {
            if (this.getAttribute("customer") === customer) {
                this.style.display = "block";
                // $('#project_machine_id').val(this.value);
            } else {
                if (this.value !== "") {
                    this.style.display = "none";
                    $("#project_machine_id").prop('selectedIndex', -1)
                }
            }
        });
        $('#project_machine_id').trigger('change');
    });


    $('#project_form_customer').trigger({
        type: 'select2:select'
    });
    $("#project_no_vat").change(function() {
        if (this.checked) {
            $("#project_comment").val("Autoliquidation Art 21 § 2 du code TVA belge");
        }
       else {
            $("#project_comment").val("");
        }
    });
    $('.description-cell')
        .popup()
    ;
});
