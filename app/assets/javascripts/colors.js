$(document).on("turbolinks:load", function () {

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

});

//Color lines status
function colorTable() {
    $('.status-cell').each(function () {
        this.firstElementChild.classList.add("ui");
        if ((this.getAttribute('status') === "created")
            && (window.location.pathname === "/projects"
                || window.location.pathname === "/invoices"
                || window.location.pathname === "/")) {
            this.firstElementChild.classList.add("animated");
        }
        this.firstElementChild.classList.add(assignColor(this.getAttribute('status')));
        this.firstElementChild.classList.add("compact");
        this.firstElementChild.classList.add("button");
    });
}

//Color picker based on status enum
function assignColor(status) {
    let company = $('#company-id').data('somedata');

    if (company === 'Plusview') {
        switch (status) {
            case 'created' :
                return "red"; //RED
            case 'accepted' :
            case 'sent' :
                return "yellow"; //YELLOW
            case 'invoiced' :
            case 'paid' :
                return "green"; //GREEN
            default:
        }
    } else {
        switch (status) {
            case 'done' :
            case 'not_assigned' :
                return "red"; //RED
            case 'in_progress' :
            case 'assigned' :
            case 'assigned_project' :
            case 'assigned_customer' :
                return "orange"; //ORANGE
            case 'sent' :
            case 'created' :
            case 'invoiced' :
                return "yellow"; //YELLOW
            case 'paid' :
                return "green"; //GREEN
            case 'quotation' :
                return "teal"; //TEAL
            case 'emailed' :
            case 'mailed' :
            case 'accepted' :
                return "olive"; //OLIVE
            case 'verified' :
                return "violet"
            default:
        }
    }
}