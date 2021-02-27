$(document).on("turbolinks:load", function () {

    //clickable rows (remote true)
    $("[data-link]").off();
    $("[data-link]").click(function (event) {
        console.log(event)
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
        console.log(event.target.innerHTML)
        if (event.target.tagName === "A" || event.target.tagName === "IMG" || event.target.innerHTML === "Accepté" ||
            event.target.innerHTML.indexOf("status_eq") >= 0) {
            return
        }
        window.location = $(this).data("project")
    });

    //clickable invoice row
    $("[data-invoice]").click(function () {
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
        if (event.target.tagName === "IMG" || event.target.tagName === "A")  {
            return
        }
        window.location = $(this).data("machine")
    });

    //clickable oil row
    $("tr[data-oil]").off();
    $("tr[data-oil] ").click(function (event) {
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