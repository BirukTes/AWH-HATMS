document.addEventListener("turbolinks:load", function () {
    $input = $("#global_search_input");

    var options = {
        getValue: "name",
        url: function (phrase) {
            return "/search/search.json?q=" + phrase;
        },
        categories: [
            {
                listLocation: "patients",
                header: "<strong>Patients</strong>"
            },
            {
                listLocation: "wards",
                header: "<strong>Wards</strong>"
            }
        ],
        list: {
            onChooseEvent: function () {
                var url = $input.getSelectedItemData().url;
                $input.val("");
                Turbolinks.visit(url);
            }
        }
    };

    $input.easyAutocomplete(options);
});