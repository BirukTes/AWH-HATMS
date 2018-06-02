// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
// Bootstrap tooltip
//= require tether
//= require rails-ujs
//= require turbolinks
//= require bootstrap
//= require jquery.easy-autocomplete
// Chart Js, from gem chartKick bundle
//= require Chart.bundle
//= require chartkick
// Nested fields
//= require cocoon
//= require DataTables
//= require print.min.js
//= require_tree .

$(document).ready(function () {
    // toggle sidebar when button clicked
    $(document).on('click', '.sidebar-toggle', function () {
        if ($(window).width() >= 768) {
            $('.sidebar').toggleClass('toggled');
            if ($('.sidebar').hasClass('toggled')) {
                $('a').find('label').hide();
            }
            else if (!$('.sidebar').hasClass('toggled')) {
                $('a').find('label').show();
            }
        }
    });

    // auto-expand submenu if an item is active
    var active = $('.sidebar .active');

    if (active.length && active.parent('.collapse').length) {
        var parent = active.parent('.collapse');

        parent.prev('a').attr('aria-expanded', true);
        parent.addClass('show');
    }


    // Bootstrap alert clear up, 20sc before removing
    $(".alert").fadeOut(20000, function () {
        $('#content').animate({inClass: "fade-in"}, 2000, 'linear');
        $(this).remove();
    }).call();

    // $(document).ajaxStop(function () {
    //
    //     $('[data-toggle="collapse"]').popover({
    //         trigger: 'hover',
    //         html: true,
    //         'placement': 'top'
    //     });
    // });

    // $(document).on('', function () {
    //
    //
    // });

    //  Hide remove button on nested fields on load
    if ($(".nested_fields").length === 1) {
        $(".remove_fields").eq(0).hide();
    }

    // Enables form submit on page, now it is on all forms but can be
    $.rails.enableElement($('#enable_form_submit'));

    // $(document).on('turbolinks:load', function(){
    //     $("table[role='datatable']").each(function(){
    //         $(this).DataTable({
    //             processing: true,
    //             serverSide: true,
    //             ajax: $(this).data('url')
    //         });
    //     });
    // });
    // $("table[role='datatable']").on('xhr.dt', function (e, settings, json, xhr) {
    //     $('#status').html(json.status);
    // }).DataTable({
    //     ajax: "data.json"
    // });

    // $('#datepicker').datepicker({
    //     format: 'dd-mm-yyyy'
    // });
    //
    // $('.input-daterange').datepicker({
    //     format: 'dd-mm-yyyy'
    // });

    // Allows to consistently use html 5 feature across browsers
    // webshim.polyfill('forms forms-ext');
    functionTwo();

    function functionTwo() {
        console.log("Hello!");
    }

    setDateRange();


    // Prevent date overlap, range in a way
    $('#from_date, #to_date').on('change', function () {
        setDateRange();
    });

    function setDateRange() {
        console.log('entered date');
        $('#to_date').attr('min', $('#from_date').val());
    }

    window.onbeforeunload = function () {
        return "Do you really want to leave our brilliant application?";
        //if we return nothing here (just calling return;) then there will be no pop-up question at all
        //return;
    };

    // Could be considered, html method is also possible
    // $("a[href*='" + location.pathname + "']").addClass("current");
    $item = $('.li-with-a a').filter(function () {
        return $(this).prop('href').indexOf(location.pathname) != -1;
    });
    $item.addClass("current");
});