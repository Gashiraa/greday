$(document).on("turbolinks:load", function () {

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

    //adds/removes the line when checkbox is toggled
    $("#project_no_vat").change(function() {
        if (this.checked) {
            $("#project_comment").val("Autoliquidation Art 21 § 2 du code TVA belge");
        }
       else {
            $("#project_comment").val("");
        }
    });
});
