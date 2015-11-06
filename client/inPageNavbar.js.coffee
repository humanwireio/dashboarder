Session.set("cur_pos", "")

Template.inPageNavbar.scroll_to_elem = (elem) ->
  $('html, body').animate {
    scrollTop: $(elem).offset().top
  }, 2000
  true

Template.inPageNavbar.headings = ->
  _.collect($(".nav-heading"), (nh) ->
    {'title':nh.getAttribute("data-title")})

Template.inPageNavbar.events =
  'click .nav-link' : ->
    Template.inPageNavbar.scroll_to_elem(
      Template.inPageNavbar.getElem(this.getAttribute("data-title"))
    )
    false

Template.inPageNavbar.getElem = (title)->
  _.find($("div.nav-heading"),(d) ->
    d.getAttribute("data-title")==title)