$(".hptt ").css("display", "none");

$('.hptt > tbody  > tr').each(function (index, tr) {

    var swordsmen = ["Gashira", "Souledge", "Dicksa", " Nom", "Frostwhisper", "Yamadharma"];

    if (swordsmen.indexOf(tr.cells[1].innerText) > -1 ) {
        return true
    }
    else {
        tr.style.display = "none"
    }

});