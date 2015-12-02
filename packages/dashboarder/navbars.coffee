Deps.autorun ->
  Template.navbars.helpers({
    level_list: ->
      if typeof(Session.tree_return(Session.get('cur_page'), Session.get("page_tree"))) == 'object'
        lvls = Session.get('cur_page').length
      else
        lvls = Session.get('cur_page').length - 1

      out = []

      for i in [0..lvls]
        if i==0
          i_keys = _.keys(Session.get("page_tree"))
        else
          i_keys = _.keys(Session.tree_return(Session.get("cur_page").slice(0,i),
                          Session.get("page_tree")))
        out.push("keys":i_keys)
      return out
  })
  return
