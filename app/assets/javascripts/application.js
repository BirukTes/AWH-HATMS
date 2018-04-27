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
//= require tether
//= require rails-ujs
//= require turbolinks
//= require bootstrap
//= require datetimepicker
//= require_tree .
// /* off-canvas sidebar toggle */
// $('[data-toggle=offcanvas]').click(function() {
//     $('.row-offcanvas').toggleClass('active');
//     $('.collapse').toggleClass('in').toggleClass('hidden-xs').toggleClass('visible-xs');
// });

// toggle sidebar when button clicked
$('.sidebar-toggle').on('click', function () {
    $('.sidebar').toggleClass('toggled');
});

// auto-expand submenu if an item is active
var active = $('.sidebar .active');

if (active.length && active.parent('.collapse').length) {
    var parent = active.parent('.collapse');

    parent.prev('a').attr('aria-expanded', true);
    parent.addClass('show');
}
