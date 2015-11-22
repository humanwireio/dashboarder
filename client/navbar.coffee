Template.navbar.helpers
  isActive: (k)->
     out = false
     if _.contains(Session.get("cur_page"),k)
       out = true
     if out
      return 'active'
     else
      return ''

  fixIfFirst: (keys)->
    #to stop first navbar from affixing to top stop this function
    #from returning anything and remove body padding-top in dashboarder.css
    if (_.difference(keys,_.keys(Session.page_tree)).length == 0)
      "navbar-fixed-top"
    else
      ""


Template.navbar.events =
  'click .nav-link' : ->
    Session.set("cur_page", Session.find_elem(this.toString(), Session.page_tree))
