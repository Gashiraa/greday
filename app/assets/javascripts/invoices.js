$(document).on("turbolinks:load", function () {

        //auto display done projects on customer selection
        $('#invoice_form_customer').on('focus load trigger mouseover change', function () {
            let customer = this.options[this.selectedIndex].value;
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