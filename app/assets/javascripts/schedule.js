var map = new google.maps.Map(document.getElementById('map'), {
    center: { lat: -23.3044524, lng: -51.1695824 },
    zoom: 13
});
var lines = [];
var markers = [];

line_id = function line_id() {
    if(document.getElementById('line').options[document.getElementById('line').selectedIndex] !== undefined) {
        return document.getElementById('line').options[document.getElementById('line').selectedIndex].value
    }
};

day_id = function day_id() {
    if(document.getElementById('day').options[document.getElementById('day').selectedIndex] !== undefined) {
        return document.getElementById('day').options[document.getElementById('day').selectedIndex].value
    }
};

origin_id = function origin_id() {
    if(document.getElementById('origin').options[document.getElementById('origin').selectedIndex] !== undefined) {
        return document.getElementById('origin').options[document.getElementById('origin').selectedIndex].value
    }
};

destination_id = function destination_id() {
    if(document.getElementById('destination').options[document.getElementById('destination').selectedIndex] !== undefined) {
        return document.getElementById('destination').options[document.getElementById('destination').selectedIndex].value
    }
};

reloadLine = function reloadLine() {
    var calculated_url = 'api/v1/lines/';

    $.ajax({
        url: calculated_url
    }).done(function(data) {
        lineElement = document.getElementById('line');
        lineElement.innerHTML = '';

        $.each(data.lines, function(i, item) {
            var option = document.createElement('option');
            option.value = item.id;
            option.innerHTML = item.text;
            lineElement.appendChild(option);
        });

        reloadItinerary();
        reloadOrigin();
    });
};

reloadOrigin = function reloadOrigin() {
    if(line_id() !== undefined) {
        var calculated_url = 'api/v1/lines/' + line_id() + '/origins?day_id=' + day_id();

        $.ajax({
            url: calculated_url
        }).done(function(data) {
            originElement = document.getElementById('origin');
            originElement.innerHTML = '';

            $.each(data.origins, function(i, item) {
                var option = document.createElement('option');
                option.value = item.id;
                option.innerHTML = item.text;
                originElement.appendChild(option);
            });

            reloadDestination();
        });
    }
};

reloadDestination = function reloadDestination() {
    if(line_id() !== undefined && origin_id() !== undefined) {
        var calculated_url = 'api/v1/lines/' + line_id() + '/origins/' + origin_id() + '/destinations?day_id=' + day_id();

        $.ajax({
            url: calculated_url
        }).done(function(data) {
            destinationElement = document.getElementById('destination');
            destinationElement.innerHTML = '';

            $.each(data.destinations, function(i, item) {
                var option = document.createElement('option');
                option.value = item.id;
                option.innerHTML = item.text;
                destinationElement.appendChild(option);
            });

            reloadSchedule();
        });
    }
};

reloadSchedule = function reloadSchedule() {
    if(line_id() !== undefined && origin_id() !== undefined && destination_id() !== undefined) {
        var calculated_url = 'api/v1/lines/' + line_id() + '/origins/' + origin_id() + '/destinations/' + destination_id() + '/schedules?day_id=' + day_id();

        $.ajax({
            url: calculated_url
        }).done(function(data) {
            $('#records-table-1 tbody').html('');
            $('#records-table-2 tbody').html('');

            $.each(data.route.schedules, function (i, item) {
                if(i < data.route.schedules.length / 2) {
                    $('#records-table-1 tbody').append('<tr><td>' + item.departure + '</td><td>' + item.arrival + '</td><td>' + item.path + '</td></tr>');
                } else {
                    $('#records-table-2 tbody').append('<tr><td>' + item.departure + '</td><td>' + item.arrival + '</td><td>' + item.path + '</td></tr>');
                }
            });
        });
    }
};

clearPaths = function clearPaths() {
    $.each(lines, function clear(i, line) {
        line.setMap(null);
    });

    lines = [];
};

clearMarkers = function clearMarkers() {
    $.each(markers, function clear(i, marker) {
        marker.setMap(null);
    });

    markers = [];
};

reloadPosition = function reloadPosition() {
    window.setInterval(function () {
        if(line_id() !== undefined) {
            var calculated_url = 'api/v1/lines/' + line_id() + '/positions';

            $.ajax({
                url: calculated_url
            }).done(function(data) {
                clearMarkers();

                $.each(data, function mark(i, raw_marker) {
                    var latlng = new google.maps.LatLng(raw_marker.lat, raw_marker.lng);

                    text = raw_marker.extra.replace(/(\r\n|\n|\r)/g, '<br />');

                    var marker = new MarkerWithLabel({
                        position: latlng,
                        map: map,
                        icon: 'bus.png',
                        labelContent: text,
                        labelAnchor: new google.maps.Point(30, 0),
                        labelClass: "marker-label", // the CSS class for the label
                        labelStyle: {opacity: 0.75}
                    });

                    markers.push(marker);
                    //marker.setMap(map);
                });
            });
        }
    }, 5000);
};

reloadItinerary = function reloadItinerary() {
    if(line_id() !== undefined) {
        var calculated_url = 'api/v1/lines/' + line_id() + '/itineraries';

        $.ajax({
            url: calculated_url
        }).done(function(data) {
            clearPaths();

            goingItinerary = [];

            $.each(data.itineraries, function(i, item) {
                goingItinerary.push({ lat: item.lat, lng: item.lng })
            });

            var goingPath = new google.maps.Polyline({
                path: goingItinerary,
                geodesic: true,
                strokeColor: '#0000FF',
                strokeOpacity: 1.0,
                strokeWeight: 2
            });

            lines.push(goingPath);
            goingPath.setMap(map);
        });
    }
};

$(document).ready(function() {
    reloadLine();

    $('.line-select').on('change', function() {
        reloadOrigin();
        reloadItinerary();
    });

    $('.day-select').on('change', function() {
        reloadOrigin();
    });

    $('.origin-select').on('change', function() {
        reloadDestination();
    });

    $('.destination-select').on('change', function() {
        reloadSchedule();
    });

    reloadPosition();
});
