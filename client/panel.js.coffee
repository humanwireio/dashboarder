Deps.autorun ->
  Template.panel.helpers({
    getView: ()->
      sub = Session.tree_return(Session.get("cur_page"), Session.page_tree)
      if typeof(sub) == "string"
        return {"template": Template[sub]}
      else
        return {"template": Template["blank"]}

    doInPageNavbar: ()->
      $(".nav-heading").length>0
  })