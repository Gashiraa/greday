document.addEventListener('turbolinks:before-cache', function () {
    $('.select2-hidden-accessible').select2('destroy');
});

$(document).on("turbolinks:load", function () {

// SELECT2 INITIALISATIONS

    //SORTING BY PROJECT NAME IN LISTINGS
    $("#project_sort").select2({
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    //SORTING BY CUSTOMER NAME IN LISTINGS
    $("#customer_sort").select2({
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale'),
        matcher: matchStart
    });

    $("#customer_form_name").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    $("#customer_form_locality").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    $("#extra_form_category").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

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

    //PICKING A CATEGORY IN EXTRA FORM
    $("#machine_form_category").select2({
        theme: "bootstrap",
        width: '100%',
        tags: true,
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    $("#extra_line_form_project").select2({
        theme: "bootstrap",
        width: '100%',
        sselectOnClose: true,
        language: $('.locale').data('locale')
    });

    //PICKING A CUSTOMER IN PROJECT FORM
    $("#project_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    //PICKING A CUSTOMER IN QUOTATION FORM
    $("#quotation_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    //PICKING A PROJECT IN SERVICE FORM
    $("#service_form_project").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    //PICKING A PROJECT IN WARE FORM
    $("#ware_form_project").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    //PICKING A CUSTOMER IN WARE FORM
    $("#ware_form_customer").select2({
        theme: "bootstrap",
        width: '100%',
        selectOnClose: true,
        language: $('.locale').data('locale')
    });

    function matchStart(params, data) {
        params.term = params.term || '';
        table = data.text.split(" ");

        for (var i = 0; i < table.length; i++) {
            if (table[i].toUpperCase().indexOf(params.term.toUpperCase()) == 0) {
                return data;
            }
        }
        return false;
    }
});
