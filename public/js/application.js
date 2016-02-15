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


  // if wedding site
  if($('.wedding_site').length != 0){
    weddingController = new WeddingController
    weddingController.initialize();
  }
});


function PortfolioController(view){
  this.view = view;
}

PortfolioController.prototype = {
  initialize: function(){
    $(".main").on("click", "img", this.showImageContainer);
    $(".imageContainer").on("click", this.clearImageContainer);
    $("aside a").on("click", this.navClick);
    $(".imageContainer").on("click", "#singleImage", this.imageClick)
  },
  navClick: function(e){
    e.preventDefault();
    var navLink = $(this)
    $.ajax({
      method: "get",
      url: "/portfolio/" + navLink.attr("id")
    }).done(function(){
      $("aside a").css("color", "black");
      navLink.css("color", "#29AAE1")
      $(".main")[0].innerHTML = arguments[0]
    })
  },
  imageClick: function(e){
    var image = $(this)
    window.location.replace("/portfolio/image/" + image.attr("alt"))
  },
  clearImageContainer: function(){
    $(".imageContainer").css("display", "none");
  },
  showImageContainer: function(){
    var imgSrc = "/img" + $(this).attr("src").slice(10);
    var imgID = $(this).attr("alt");
    $(".imageContainer").css("display", "block");
    $("#singleImage").attr("src", imgSrc)
    $("#singleImage").attr("alt", imgID)
  }
}



function WeddingController(){}

WeddingController.prototype = {
  initialize: function(){
    $('.nav a').click(function (e) {
      e.preventDefault()
      $(this).tab('show')
    });

    $('#party_count').on('change', this.loadGuests)

    $('#rsvp-form').on('submit', this.submitRsvp)

  },
  loadGuests: function(){
    var partyCount = $(this).val() - 1
    $('#guests').hide()
    $('#rsvp-submit').hide()
    $('.guest').not('#guest_0').remove()

    for (var i = 0; i <= partyCount; i++) {
      if (i === 0) { continue; }

      var guest = $( ".guest" ).first().clone()
      $(guest).attr('id', 'guest_' + i)

      $(guest).find('input[name*="0"]').each(function() {
        $(this).attr('name', $(this).attr('name').replace(/\d+/, i))
      });
      $(guest).find('label[for*="0"]').each(function() {
        $(this).attr('for', $(this).attr('for').replace(/\d+/, i))
      });

      $('#guests').append(guest)
    };

    $('#guests').removeClass('hidden')
    $('#rsvp-submit').removeClass('hidden')
    $('#guests').show()
    $('#rsvp-submit').show()
  },
  submitRsvp: function(){
    event.preventDefault();
    $.ajax({
      type: 'POST',
      url: $(this).attr('action'),
      data: $(this).serialize()
    })
    .done(function(data) {
      $('#rsvp h4').remove()
      $('form').hide()
      $($.parseJSON(data).response).each(function(){
        $('#rsvp').append('<h4>'+ this +'</h4>')
      })
    }).fail(function(){
      $('#rsvp h4').remove()
      $('#rsvp').append('<h4>An error occurred. Please email me at acreilly3@gmail.com.</h4>')
    })
  }
}