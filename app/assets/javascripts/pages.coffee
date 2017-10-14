ready = ->
  $('#owl-demo').owlCarousel
    autoPlay: 3000
    autoPlay: true
    items: 4
    itemsDesktop: [
      640
      5
    ]
    itemsDesktopSmall: [
      414
      4
    ]
  return

$(document).on 'turbolinks:load', ready