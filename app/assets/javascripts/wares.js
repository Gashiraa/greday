$(document).on("turbolinks:load", function () {

        //Disabling dropdowns for ware forms
        $('select[id="ware_form_project"]').on('focus trigger mouseover change', function () {
            if ($(this).val()) {
                $('#ware_form_customer').prop("disabled", true);
                changeStatusSelect("assigned_project")
            } else {
                $('#ware_form_customer').prop("disabled", false);
                changeStatusSelect(0)
            }
        });
        $('select[id="ware_form_project"]').trigger('change');

        $('select[id="ware_form_customer"]').on('focus trigger mouseover change', function () {
            if ($(this).val()) {
                $('#ware_form_project').prop("disabled", true);
                changeStatusSelect("assigned_customer")
            } else {
                $('#ware_form_project').prop("disabled", false);
                changeStatusSelect(0)
            }
        });
        $('select[id="ware_form_customer"]').trigger('change');

        //WARES PROVIDER PRICES auto-complete
        $('#provider_discount,#provider_price,#new_ware,#total_cost,#total_gross,#quantity,#bought_price,#tva_rate,#margin')
            .on('keyup keypress mouseover change', function () {
                let provider_price = document.getElementById('provider_price').value || 0;
                let provider_discount = document.getElementById('provider_discount').value || 0;
                let bought_price = document.getElementById('bought_price');

                let total = parseFloat(provider_price) - ((parseFloat(provider_price) / 100) * parseFloat(provider_discount));

                bought_price.value = total.toFixed(3);
            });
        $('#provider_price').trigger('mouseover');

        //WARES TOTAL auto-complete
    $('#provider_discount,#provider_price,#new_ware,#sell_price,#total_cost,#total_gross,#quantity,#bought_price,#tva_rate,#margin')
        .on('keyup keypress mouseover change', function () {
            let total_cost = document.getElementById('total_cost');
            let total_gross = document.getElementById('total_gross');
            let sell_price = document.getElementById('sell_price');
            let bought_price = document.getElementById('bought_price');
            let margin = document.getElementById('margin');
            let quantity = document.getElementById('quantity').value || 0;
            let tva_rate = document.getElementById('tva_rate').value || 0;

            let bought_price_value = bought_price.value || 0;
            let sell_price_value = sell_price.value || 0;
            let margin_value = margin.value || 0;
            let sell = parseFloat(sell_price_value);

            if (margin.getAttribute("readonly") === 'readonly') {
                margin.value = (((sell_price_value - bought_price_value) / bought_price_value) * 100).toFixed(2);
            } else {
                sell = parseFloat(bought_price_value) + ((parseFloat(bought_price_value) / 100) * parseFloat(margin_value));
                sell_price.value = sell.toFixed(3);
            }

            let gross = (parseFloat(quantity) * parseFloat(sell));
            let total = gross * (1 + parseFloat(tva_rate) / 100);
            total_gross.value = (Math.round(gross * 100) / 100).toFixed(2);
            total_cost.value = (Math.round(total * 100) / 100).toFixed(2);
        });
    $('#waresForm').trigger('mouseover');

        if ($('#project-id').data('somedata')) {
            $("#ware_form_project").val($('#project-id').data('somedata'));
            $('select[id="ware_form_project"]').trigger('change');
        }
    $('#ware_comment')
        .on('keyup keypress change', function () {
            if ($('#ware_comment').val() !== '') {
                $('.trigger-check').checkbox('check');
            }
            else {
                $('.trigger-check').checkbox('uncheck');
            }
        });
    }
);

function changeStatusSelect(status) {
    if (document.getElementById('ware_id').value === "0") {
        $('#status_edit_select').val(status)
    }
}

function flipWareInputMethod() {
    let margin = $("#margin")
    let sell_price = $("#sell_price")
    let sell_label = $("#sell_label")
    let margin_label = $("#margin_label")


    if (margin.attr("readonly") !== 'readonly') {
        margin.attr("readonly",'readonly');
        sell_price.removeAttr("readonly");
        sell_label.removeClass('red')
        margin_label.addClass('red')
    }
    else {
        margin.removeAttr("readonly");
        sell_price.attr("readonly",'readonly');
        margin_label.removeClass('red')
        sell_label.addClass('red')
    }
}