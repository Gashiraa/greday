$(document).on("turbolinks:load", function () {

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

        if (document.getElementById('service_id')) {
            if ($('#customer-rate').data('somedata')) {
                if (document.getElementById('service_id').value === "0") {
                    document.getElementById('hourly_rate').value = $('#customer-rate').data('somedata')
                }
            }
        }

        if ($('#project-id').data('somedata')) {
            $("#service_form_project").val($('#project-id').data('somedata'));
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

        //Auto-calculate duration if start_time and end_time are non-empty
        //Auto-lock duration fields if start_time or end_time are non-empty
        $('#service_start_time_4i, #service_start_time_5i, #service_end_time_4i, #service_end_time_5i')
            .on('keyup keypress change', function () {

                let startTime4 = document.getElementById('service_start_time_4i');
                let startTime5 = document.getElementById('service_start_time_5i');

                let endTime4 = document.getElementById('service_end_time_4i');
                let endTime5 = document.getElementById('service_end_time_5i');

                let duration4 = document.getElementById('service_duration_4i');
                let duration5 = document.getElementById('service_duration_5i');

                let totalMinutesStart = (parseInt(startTime4.options[startTime4.selectedIndex].value) * 60)
                    + parseInt(startTime5.options[startTime5.selectedIndex].value);
                let totalMinutesEnd = (parseInt(endTime4.options[endTime4.selectedIndex].value) * 60)
                    + parseInt(endTime5.options[endTime5.selectedIndex].value);

                if (totalMinutesStart !== 0 || totalMinutesEnd !== 0) {
                    duration4.value = "00";
                    duration5.value = "00";

                    let durationMinutes = totalMinutesEnd - totalMinutesStart;

                    console.log(pad2(durationMinutes % 60));

                    duration5.value = pad2((durationMinutes % 60));
                    duration4.value = pad2((Math.floor(durationMinutes / 60)));
                }
            });
    }
);

function changeStatusSelectService(status) {
    if (document.getElementById('service_id').value === "0") {
        $('#status_edit_select').val(status)
    }
}

function pad2(number) {
    return (number < 10 ? '0' : '') + number
}