$(document).on("turbolinks:load", function () {
    $('#customer_tva_record')
        .on('keypress', function () {
            let input = this.value;
            input = input.toUpperCase();
            if (input.substring(0, 2) === "BE") {
                if ((input[2]) !== ' ' && input[2]) {
                    input = input.substr(0,2)+' '+input.substr(2);
                }
                if ((input[7]) !== ' '&& input[7]) {
                    input = input.substr(0,7)+' '+input.substr(7);
                }
                if ((input[11]) !== ' '&& input[11]) {
                    input = input.substr(0,11)+' '+input.substr(11);
                }
            }
            this.value = input;
        });
        $('#customer_tva_record').trigger('change');
    }
);