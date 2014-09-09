$(document).ready(function() {
  $(".emailButton").on("click", function(){
    $(".emailForm").css("display", "block")
  })
  $("#closeForm").on("click", function(){
    $(".emailForm").css("display", "none")
  })
  portfolioController = new PortfolioController
  portfolioController.initialize()

  $("#slideshow > div:gt(0)").hide();

  setInterval(function() {
    $('#slideshow > div:first')
    .fadeOut(1000)
    .next()
    .fadeIn(1000)
    .end()
    .appendTo('#slideshow');
  },  6000);

});


function PortfolioController(view){
  this.view = view;
}

PortfolioController.prototype = {
  initialize: function(){
    $("img").on("click", this.showImageContainer);
    $(".imageContainer").on("click", this.clearImageContainer);
    $("aside a").on("click", this.navClick)
  },
  navClick: function(e){
    e.preventDefault();
    var navLink = $(this)
    $.ajax({
      method: "get",
      url: "/portfolio/" + navLink.attr("id")
    }).done(function(){
      $("aside a").css("color", "black")
      navLink.css("color", "#29AAE1")
      $(".main")[0].innerHTML = arguments[0]
    })
  },
  clearImageContainer: function(){
    $(".imageContainer").css("display", "none");
  },
  showImageContainer: function(){
    var imgSrc = $(this).attr("src")
    $(".imageContainer").css("display", "block");
    $("#singleImage").attr("src", imgSrc)
  }
}

