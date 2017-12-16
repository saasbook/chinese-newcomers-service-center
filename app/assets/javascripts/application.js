// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

function ready() {
    function updateSum() {
        var b_total = 0;
        $(".B_sum:checked").each(function (i, n) {
            b_total += parseInt($(n).val());
        });
        $("#item_B_total").val(b_total);

        var k_total = 0;
        $(".K_sum:checked").each(function (i, n) {
            k_total += parseInt($(n).val());
        });
        $("#item_K_total").val(k_total);

    }

    // run the update on every checkbox change and on startup
    $("input.B_sum").change(updateSum);
    $("input.K_sum").change(updateSum);
    updateSum();
}

$(document).on('turbolinks:load', ready);
