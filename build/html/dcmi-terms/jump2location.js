//jump2location.js

$(document).ready(function () {
  var vocab = getParameterByName("v");
  var hash = window.location.hash;
  if (vocab && hash) {
    var jump = "#" + vocab + "-" + hash.replace(/^#/, '');
    var new_position = $(jump).offset();
    window.scrollTo(new_position.left, new_position.top);
  }
});
function getParameterByName (name) {
  var match = RegExp('[?&]' + name + '=([^&]*)')
      .exec(window.location.search);
  return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}