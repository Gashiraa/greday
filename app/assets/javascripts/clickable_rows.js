$(document).on("turbolinks:load", function () {

    //clickable rows (remote true) Not used ATM
    $("tr[data-link]").click(function () {
        if (event.target.tagName === "IMG" || event.target.classList.contains('no-link')) {
            return;
        }
        $.ajax({
            url: this.getAttribute('data-link'),
            dataType: "script",
            type: "GET"
        });
        event.preventDefault();
    });

    //clickable project row
    $("tr[data-project]").click(function () {
        if (event.target.tagName === "A" || event.target.tagName === "IMG" || event.target.innerHTML === "Accepté") {
            return
        }
        window.location = $(this).data("project")
    });

    //clickable invoice row
    $("tr[data-invoice]").click(function () {
        let test = event;
        if (event.target.tagName === "A" || event.target.tagName === "IMG" || event.target.innerHTML === "Payé") {
            return
        }
        window.open($(this).data("invoice"), $(this).data("target"));
    });

    //clickable customer row
    $(".card[data-customer]").click(function () {
        if (event.target.tagName === "IMG") {
            return
        }
        window.location = $(this).data("customer")
    });

    //clickable machine row
    $(".card[data-machine],tr[data-machine] ").click(function () {
        if (event.target.tagName === "IMG") {
            return
        }
        window.location = $(this).data("machine")
    });

    //clickable machine row
    $("tr[data-oil] ").click(function () {
        if (event.target.tagName === "IMG") {
            return
        }
        $.ajax({
            url: this.getAttribute('data-oil'),
            dataType: "script",
            type: "GET"
        });
        event.preventDefault();
    });
});