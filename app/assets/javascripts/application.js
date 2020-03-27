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

$(document).on("turbolinks:load", function () {

        //navbar active (also handling locale)
        $.each($('.ui.menu').find('a'), function () {
            $(this).toggleClass('active',
                ((window.location.pathname.indexOf($(this).attr('href')) > -1) ||
                    $('.locale').data('locale') === this.text.toLowerCase() ||
                    (window.location.pathname === "/" && $(this).attr('href') === "/projects")) &&
                $(this).attr('id') !== "logo"
            )
        });

        //notification fader
        setTimeout(function () {
            $('#notice').fadeOut();
        }, 3000);
    }
);

//hide/show some divs
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

//autocapitalize field input
function capitalize(textboxid, str) {
    // string with alteast one character
    if (str && str.length >= 1) {
        var firstChar = str.charAt(0);
        var remainingStr = str.slice(1);
        str = firstChar.toUpperCase() + remainingStr;
    }
    document.getElementById(textboxid).value = str;
}