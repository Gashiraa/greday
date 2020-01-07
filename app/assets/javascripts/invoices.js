$(document).on("turbolinks:load", function () {

        $("#invoice_form_customer").select2({
            theme: "bootstrap",
            width: '100%',
            selectOnClose: true,
            language: $('.locale').data('locale')
        }); //PICKING A CUSTOMER IN INVOICE FORM

        $("#invoice_form_number").select2({
            theme: "bootstrap",
            width: '100%', tags: true,
            selectOnClose: true,
            language: $('.locale').data('locale')
        });


        $('#invoice_form_customer').on('focus load trigger mouseover change', function () {
            let customer = this.options[this.selectedIndex].value;
            $("#invoice_form_wares > option").each(function () {
                if (this.getAttribute("customer") === customer) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
            $("#invoice_form_projects > option").each(function () {
                if (this.getAttribute("customer") === customer) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
        });
        $('#invoice_form_customer').trigger('change');

        if ($('#project-customer-id').data('somedata')) {
            $("#invoice_form_customer").val([$('#project-customer-id').data('somedata')]);
            $('#invoice_form_customer').select2({theme: "bootstrap", width: '100%', selectOnClose: true}).trigger('change');
        }
    }
);
