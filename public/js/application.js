$(document).ready(function() {

  var name = $('#tweet_content').attr("data-username");
  $.get("/stale", {username: name}, function(e){
    $('#tweet_content').html(e);
  }, "html");
});
