$(document).on("turbolinks:load", function () {

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
});

//switch mm/dd/yyyy to dd/mm/yyyy
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