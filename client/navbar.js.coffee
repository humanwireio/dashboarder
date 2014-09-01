Template.navbar.isActive = (k)->
   out = false
   if _.contains(Session.get("cur_page"),k)
     out = true
   if out
    return 'active'
   else
    return ''

Template.navbar.events =
  'click .nav-link' : ->
    Session.set("cur_page", Session.find_elem(this.toString(), Session.page_tree))
