$(document).ready(function() {
  $(".emailButton").on("click", function(){
  $(".emailForm").css("display", "block")
})
  $("#closeForm").on("click", function(){
  $(".emailForm").css("display", "none")
  })
  portfolioView = new PortfolioView
  portfolioController = new PortfolioController(portfolioView)
  portfolioController.initialize()


});


function PortfolioController(view){
  this.view = view;
}

PortfolioController.prototype = {
  initialize: function(){
    $("img").on("click", this.showImageContainer)
    $(".imageContainer").on("click", this.clearImageContainer)
  },
  navClick: function(){

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

function PortfolioView(){}