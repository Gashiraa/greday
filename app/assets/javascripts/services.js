$(document).on("turbolinks:load", function () {

        $("#service_form_project").select2({
            theme: "bootstrap",
            width: '100%',
            selectOnClose: true,
            language: $('.locale').data('locale')
        }); //PICKING A PROJECT IN SERVICE FORM

        //SERVICES TOTAL auto-complete
        $('#servicesForm, #total_cost_s, #total_gross_s, #hourly_rate, #tva_rate_s, #coefficient, #_duration_4i, #_duration_5i, #service_duration_4i, #service_duration_5i')
            .on('keyup keypress mouseover change', function () {
                    let total_cost = document.getElementById('total_cost_s');
                    let total_gross = document.getElementById('total_gross_s');
                    let hourly_rate = document.getElementById('hourly_rate').value || 0;
                    let tva_rate = document.getElementById('tva_rate_s').value || 0;
                    let hours;
                    let minutes;

                    if (document.getElementById('_duration_4i')) {
                        hours = document.getElementById('_duration_4i').value || 0;
                        minutes = document.getElementById('_duration_5i').value || 0;
                    } else {
                        hours = document.getElementById('service_duration_4i').value || 0;
                        minutes = document.getElementById('service_duration_5i').value || 0;
                    }

                    let gross = (((parseInt(hours) + parseFloat(minutes) / 60) * parseFloat(hourly_rate)));
                    let total = gross * (1 + parseFloat(tva_rate) / 100);

                    total_gross.value = gross.toFixed(2);
                    total_cost.value = total.toFixed(2);

                }
            );
        $('#servicesForm').trigger('mouseover');

        if ($('#project-id').data('somedata')) {
            $("#service_form_project").val($('#project-id').data('somedata'));
        }

        if (document.getElementById('service_id')) {
            if ($('#customer-rate').data('somedata')) {
                if (document.getElementById('service_id').value === "0") {
                    document.getElementById('hourly_rate').value = $('#customer-rate').data('somedata')
                }
            }
        }

        //Disabling dropdowns for ware forms
        $('select[id="service_form_project"]').on('focus trigger mouseover change', function () {
            if ($(this).val()) {
                changeStatusSelectService('assigned')
            } else {
                changeStatusSelectService(0)
            }
        });
        $('select[id="service_form_project"]').trigger('change');
    }
);

function changeStatusSelectService(status) {
    if (document.getElementById('service_id').value === "0") {
        $('#status_edit_select').val(status)
    }
}