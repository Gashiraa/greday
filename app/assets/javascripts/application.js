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

        noticeFader();

        $('.sortable').sortable({
            update: function (e, ui) {
                Rails.ajax({
                        url: $(this).data("url"),
                        type: "PATCH",
                        data: $(this).sortable('serialize'),
                    }
                )
            }
        });
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

function copyStringToClipboard(string) {
    // Create new element
    var element = document.createElement('textarea');
    // Set value (string to be copied)
    element.value = string;
    // Set non-editable to avoid focus and move outside of view
    element.setAttribute('readonly', '');
    element.style = {position: 'absolute', left: '-9999px'};
    document.body.appendChild(element);
    // Select text inside element
    element.select();
    // Copy text to clipboard
    document.execCommand('copy');
    // Remove temporary element
    document.body.removeChild(element);
    $('#notice').text("Référence copiée!").css("display", "block");
    //notification fader
    noticeFader();
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

function noticeFader() {
    //notification fader
    setTimeout(function () {
        $('#notice').fadeOut();
    }, 3000);
}