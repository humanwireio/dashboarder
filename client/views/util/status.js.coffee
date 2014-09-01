Template.status.cur_page = () -> return Session.get("cur_page").join()
Template.status.page_tree = () -> return _.keys(Session.page_tree)