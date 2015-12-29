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
//= require select2
//= require_tree .

line_id = function line_id() {
    return document.getElementById('line').options[document.getElementById('line').selectedIndex].value
};

origin_id = function origin_id() {
    return document.getElementById('origin').options[document.getElementById('origin').selectedIndex].value
};

destination_id = function destination_id() {
    return document.getElementById('destination').options[document.getElementById('destination').selectedIndex].value
};

$('.line-select').select2(
    {
        minimumResultsForSearch: Infinity,
        placeholder: "Select a state",
        width: '100%',
        ajax: {
            url: 'api/v1/lines',
            dataType: 'json',
            processResults: function (data, params) {
                params.page = params.page || 1;

                return {
                    results: data.lines,
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        }
    }
);

$('.day-select').select2(
    {
        minimumResultsForSearch: Infinity,
        placeholder: "Select a state",
        width: '100%',
    }
);

$('.origin-select').select2(
    {
        minimumResultsForSearch: Infinity,
        placeholder: "Select a state",
        width: '100%',
        ajax: {
            url: function() {
                return 'api/v1/lines/' + line_id() + '/origins';
            },
            dataType: 'json',
            processResults: function (data, params) {
                params.page = params.page || 1;

                return {
                    results: data.origins,
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        }
    }
);

$('.destination-select').select2(
    {
        minimumResultsForSearch: Infinity,
        placeholder: "Select a state",
        width: '100%',
        ajax: {
            url: function() {
                return 'api/v1/lines/' + line_id() + '/origins/' + origin_id() + '/destinations';
            },
            dataType: 'json',
            processResults: function (data, params) {
                params.page = params.page || 1;

                return {
                    results: data.destinations,
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        }
    }
);

$('.destination-select').on('select2:select', function() {
    var calculated_url = 'api/v1/lines/' + line_id() + '/origins/' + origin_id() + '/destinations/' + destination_id() + '/schedules';

    $.ajax({
        url: calculated_url
    }).done(function(data) {
        $('#records-table-1 tbody').html('');
        $('#records-table-2 tbody').html('');

        $.each(data.route.schedules, function (i, item) {
            if(i < data.route.schedules.length / 2) {
                $('#records-table-1 tbody').append('<tr><td>' + item.arrival + '</td><td>' + item.departure + '</td><td>' + item.path + '</td></tr>');
            } else {
                $('#records-table-2 tbody').append('<tr><td>' + item.arrival + '</td><td>' + item.departure + '</td><td>' + item.path + '</td></tr>');
            }
        });
    });
});
