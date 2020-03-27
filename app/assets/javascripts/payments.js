$(document).on("turbolinks:load", function () {

    //auto display created invoices on customer selection
    $('#customer_select_invoice').on('focus load trigger mouseover change', function () {
            let invoice = this.options[this.selectedIndex].value;
            $("#select_invoices_payment > option").each(function () {
                if (this.getAttribute("invoice") === invoice) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
        });
        $('#customer_select_invoice').trigger('change');
    }
);