$(document).ready(function() {
  $(".emailButton").on("click", function(){
  $(".emailForm").css("display", "block")
})
  $("#closeForm").on("click", function(){
  $(".emailForm").css("display", "none")
  })
});
