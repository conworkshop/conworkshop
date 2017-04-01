$(document).on('turbolinks:click', function (event) {
    if (event.target.getAttribute('href').charAt(0) === '#') {
        return event.preventDefault();
    }
});
