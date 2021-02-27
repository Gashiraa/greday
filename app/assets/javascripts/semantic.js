$(document).on("turbolinks:load", function () {

    //SEMANTIC-UI INITIALISATIONS
    $('.ui.checkbox').checkbox();
    $('.ui.dropdown').dropdown({
        on: 'hover'
    })
    ;

    $('.ui.sticky')
        .sticky({
            context: '#example1'
        });

    $('.description-cell')
        .popup({
            position: 'left center',
            hoverable  : true,
        });

    var text = {
        days: ['D', 'L', 'M', 'M', 'J', 'V', 'S'],
        months: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Decembre'],
        monthsShort: ['Jan', 'Fev', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aou', 'Sep', 'Oct', 'Nov', 'Dec'],
        today: 'Aujourd\'hui',
        now: 'Maintenant',
        am: 'AM',
        pm: 'PM'
    }

    $('#rangestart').calendar({
        type: 'date',
        firstDayOfWeek: 1,
        monthFirst: false,
        text: text,
        formatter: {
            date: function (date, settings) {
                if (!date) return '';
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                return ('0' + day).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
            }
        },
        onChange: function(date, text, mode) {
            $('#project_search').submit();
        }
    });

    $('#rangeend').calendar({
        type: 'date',
        firstDayOfWeek: 1,
        monthFirst: false,
        text: text,
        formatter: {
            date: function (date, settings) {
                if (!date) return '';
                var day = date.getDate();
                var month = date.getMonth() + 1;
                var year = date.getFullYear();
                return ('0' + day).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
            }
        },
        onChange: function(date, text, mode) {
            $('#project_search').submit();
        }
    });
});

