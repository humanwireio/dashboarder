Template.status.helpers
  cur_page: -> return Session.get("cur_page").join()
  page_tree: -> return _.keys(Session.page_tree)
