//= require jquery3
//= require jquery
//= require select2-full
//= require rails-ujs
//= require jquery-ui
//= require semantic-ui
//= require activestorage
//= require turbolinks
//= require select2_locale_fr
//= require_tree .


document.addEventListener('turbolinks:before-cache', function () {
    $('.select2-hidden-accessible').select2('destroy');
});

$(document).on("turbolinks:load", function () {


        $('.ui.checkbox').checkbox();
        $('.ui.dropdown').dropdown({
            on: 'hover'
        })
        ;

        $('.ui.sticky')
            .sticky({
                context: '#example1'
            });

        {
            // SELECT2 INITIALISATIONS
            $("#project_sort").select2({
                width: '100%',
                selectOnClose: true,
                language: $('.locale').data('locale')
            }); //SORTING BY PROJECT NAME IN LISTINGS

            $("#customer_sort").select2({
                width: '100%',
                selectOnClose: true,
                language: $('.locale').data('locale'),
                matcher: matchStart
            }); //SORTING BY CUSTOMER NAME IN LISTINGS

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
        }

        {  // DATEPICKER SECTION
            //Datepickers initilization
            autoFormatDatePicker("sortProjectFrom");
            autoFormatDatePicker("sortProjectTo");

            // Datepicker formatting
            if ($('.locale').data('locale') !== 'fr') {
                $("#sortProjectFrom,#sortProjectTo,#dateProject").datepicker();
            } else {
                $("#sortProjectFrom,#sortProjectTo,#dateProject").datepicker({
                    altField: "#datepicker",
                    closeText: 'Fermer',
                    firstDay: 1,
                    prevText: 'Précédent',
                    nextText: 'Suivant',
                    currentText: 'Aujourd\'hui',
                    monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
                    monthNamesShort: ['Janv.', 'Févr.', 'Mars', 'Avril', 'Mai', 'Juin', 'Juil.', 'Août', 'Sept.', 'Oct.', 'Nov.', 'Déc.'],
                    dayNames: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
                    dayNamesShort: ['Dim.', 'Lun.', 'Mar.', 'Mer.', 'Jeu.', 'Ven.', 'Sam.'],
                    dayNamesMin: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
                    weekHeader: 'Sem.',
                    dateFormat: 'dd/mm/yy'
                });
            }
        }

        //Clickable rows (remote true) Not used ATM
        $("tr[data-link]").click(function () {
            if (event.target.tagName === "IMG") {
                return
            }
            $.ajax({
                url: this.getAttribute('data-link'),
                dataType: "script",
                type: "GET"
            });
            event.preventDefault();
        });

        $("tr[data-project]").click(function () {
            if (event.target.tagName === "IMG") {
                return
            }
            window.location = $(this).data("project")
        });

        $("tr[data-invoice]").click(function () {
            if (event.target.tagName === "IMG") {
                return
            }
            window.open($(this).data("invoice"), $(this).data("target"));
        });

        $(".card[data-customer]").click(function () {
            if (event.target.tagName === "IMG") {
                return
            }
            window.location = $(this).data("customer")
        });

        $(".card[data-machine]").click(function () {
            if (event.target.tagName === "IMG") {
                return
            }
            window.location = $(this).data("machine")
        });

        //Navbar active (also handling locale)
        $.each($('.ui.menu').find('a'), function () {
            $(this).toggleClass('active',
                ((window.location.pathname.indexOf($(this).attr('href')) > -1) ||
                    $('.locale').data('locale') === this.text.toLowerCase() ||
                    (window.location.pathname === "/" && $(this).attr('href') === "/projects")) &&
                $(this).attr('id') !== "logo"
            )
        });

        //Notification fader
        setTimeout(function () {
            $('#notice').fadeOut();
        }, 3000);

        // //Color lines from a table
        $('.table-to-color').each(function () {
            colorTable();
        });

        // Color status in project dashboard
        $('#status-project').each(function () {
            this.style.backgroundColor = assignColor(this.getAttribute('status'));
        });

        //Color status in selects
        $('#status_sort_select > option').each(function () {
            this.style.backgroundColor = assignColor(this.getAttribute('status'));
        });
    }
);

function showHidden() {
    let element = document.getElementById("hideable-field");
    if (element) {
        if (element.style.display === "none" || element.style.display === "") {
            element.style.display = "block"
        } else {
            element.style.display = "none"
        }
    }
}


function autoFormatDatePicker(picker) {
    if (document.getElementById(picker)) {
        let element = document.getElementById(picker);
        let oldDate = element.value;
        if (oldDate.length > 0) {
            let yyyy = oldDate.substring(0, 4);
            let mm = oldDate.substring(5, 7);
            let dd = oldDate.substring(8, 10);
            element.value = dd + "/" + mm + "/" + yyyy;
        }
    }
}

//Color lines status
function colorTable() {
    $('.status-cell').each(function () {
        this.firstElementChild.classList.add("ui");
        if ((this.getAttribute('status') === "created") && (window.location.pathname === "/projects" || window.location.pathname === "/invoices" || window.location.pathname === "/")) {
            this.firstElementChild.classList.add("animated");
        }
        this.firstElementChild.classList.add(assignColor(this.getAttribute('status')));
        this.firstElementChild.classList.add("button");
    });
}

//Color picker based on status enum
function assignColor(status) {
    switch (status) {
        case 'done' :
        case 'not_assigned' :
            return "red"; //RED
        case 'in_progress' :
        case 'assigned' :
        case 'assigned_project' :
        case 'assigned_customer' :
            return "orange"; //ORANGE
        case 'accepted' :
        case 'sent' :
        case 'created' :
        case 'invoiced' :
            return "yellow"; //YELLOW
        case 'paid' :
            return "green"; //GREEN
        case 'quotation' :
            return "teal"; //BLUE
        default:
    }
}

function capitalize(textboxid, str) {
    // string with alteast one character
    if (str && str.length >= 1) {
        var firstChar = str.charAt(0);
        var remainingStr = str.slice(1);
        str = firstChar.toUpperCase() + remainingStr;
    }
    document.getElementById(textboxid).value = str;
}