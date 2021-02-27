$(document).on("turbolinks:load", function () {

        //On selection of extra, autoselect : unit and price
        $('#project_extra_line_extra_id').on('focus load trigger mouseover change', function () {
            if (this.selectedIndex >= 0) {
                let extra = this.options[this.selectedIndex].value;
                //autoselect unit
                $("#extra_unit_price > option").each(function () {
                    if (this.getAttribute("extra") === extra) {
                        this.style.display = "block";
                        $('#extra_unit_price').val(extra);
                    } else {
                        this.style.display = "none";
                    }
                });
                //auto select price
                $("#extra_unit > option").each(function () {
                    if (this.getAttribute("extra") === extra) {
                        this.style.display = "block";
                        $('#extra_unit').val(extra);
                    } else {
                        this.style.display = "none";
                    }
                });
            }
            //trigger auto calculation when we're done
            $('#extra_total_gross').trigger('mouseover');
        });

        //Filter extras depending on selected category
        $('#project_extra_line_id').on('load trigger change', function () {
            //check all extra options, hide ones not belonging to selected category
            let category = this.options[this.selectedIndex].text;
            $("#project_extra_line_extra_id > option").each(function () {
                if (this.getAttribute("category") === category) {
                    this.style.display = "block";
                    $('#project_extra_line_extra_id').val(this.value);
                } else {
                    this.style.display = "none";
                }
            });
            $('#project_extra_line_extra_id').trigger('change');
        });

        //Auto-calculation
        $('#extra_edit_select,#edit_project_extra_line,#extra_total_gross,#extra_total,#extra_quantity,#extra_tva_rate,#extra_unit_price')
            .on('keyup keypress mouseover change', function () {
                let quantity = document.getElementById('extra_quantity').value || 0;
                let tva_rate = document.getElementById('extra_tva_rate').value || 0;

                let extra_unit_price;
                if (document.getElementById('extra_unit_price').options) {
                    extra_unit_price = document.getElementById('extra_unit_price').options[document.getElementById('extra_unit_price').selectedIndex].text || 0;
                } else {
                    extra_unit_price = document.getElementById('extra_unit_price').value || 0;
                }
                let extra_total_gross = document.getElementById('extra_total_gross');
                let extra_total = document.getElementById('extra_total');

                let gross = (parseFloat(quantity) * parseFloat(extra_unit_price));
                let total = gross * (1 + (parseFloat(tva_rate) / 100));

                extra_total_gross.value = gross.toFixed(2);
                extra_total.value = total.toFixed(2);
            });
        $('#extra_edit_select').trigger('mouseover');

        //Auto select project
        if ($('#project-id').data('somedata')) {
            $("#extra_line_form_project").val($('#project-id').data('somedata'));
            $('select[id="extra_line_form_project"]').trigger('change');
        }

        //Auto change vat to 0
        if ($('#project-no-vat').data('somedata') === true) {
            $("#extra_tva_rate").val('0');
            $('select[id="extra_line_form_project"]').trigger('change');
        }

        function onFormOpen() {
            //Store the OG option (edit)
            let extraSelect = document.getElementById("project_extra_line_extra_id");
            let extra = extraSelect.options[extraSelect.selectedIndex].value;
            let categories = document.getElementById("project_extra_line_id");
            //check all extra options, hide ones not belonging to selected category
            let category = categories.options[categories.selectedIndex].text;
            $("#project_extra_line_extra_id > option").each(function () {
                if (this.getAttribute("category") === category) {
                    this.style.display = "block";
                } else {
                    this.style.display = "none";
                }
            });
            $('#project_extra_line_extra_id').val(extra);
        }
        if (document.getElementById("project_extra_line_extra_id")) {
            onFormOpen();
            if ( $('#form-title').html().indexOf("Ajout divers") >= 0) {
                $('#project_extra_line_id').trigger('change');
            }
        }

        //auto-calculate once
    $('#project_extra_line_extra_id option').each(function () {
        if ($(this).css('display') != 'none') {
            // $(this).prop("selected", true);
            return false;
        }
    });
        $('#project_extra_line_extra_id').trigger('change');
        $('#extra_total_gross').trigger('mouseover');
    }
);