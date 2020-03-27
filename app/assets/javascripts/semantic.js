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
        .popup();

});