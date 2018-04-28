//= require jquery.timeago

$(function() {
  $.timeago.settings.localeTitle = true;
  $('time.timeago').timeago();

  $('#search-form').submit(function() {
    var searchTerm = $('#search').val();
    if (!searchTerm) {
      return false;
    }
    var searchUrl = '/search/' + encodeURI(searchTerm);
    window.location = searchUrl;

    return false;
  });
});
