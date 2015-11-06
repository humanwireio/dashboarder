Session.page_tree =
                    "TEST1":
                         "Test11":"self_generating_sites"
                    "TEST2":
                         "Test21": 
                               "test211":"status",
                         "Test22":
                               "test221":"status"
                    "TEST3":
                         "Test31":
                               "test311":"status"
                         "Test32":
                               "test321":"status"
                    "TEST4":
                         "Test41":
                               "test411":"status"
                               "test412":"status",
                               "test413":"status",
                               "test414":"status",
                               "test415":"status"  
                    "TEST5": 
                         "Test51":"status"
                         "Test52":"status"

#Manage URL
if Session.get("cur_page")==undefined
  start_url = window.location.href
  Meteor.testURL = start_url
  unformatted_page = start_url.split("#")
  Meteor.baseUrl = unformatted_page[0]
  if unformatted_page.length > 1
    #analytics.page(unformatted_page[1])
    formatted_page = unformatted_page[1].split('/').map((e)->e.split("_").join(" "))
    Session.set("cur_page", formatted_page)
  else
    #analytics.page("About")
    Session.set("cur_page", [_.keys(Session.page_tree)[0]])

#returns value of page in tree
Session.tree_return = (page, tree)->
  cur = tree
  i=0
  while i<page.length
    cur = cur[page[i]]
    i++
  return cur

#TODO: fix the following, currnetly all names must be unique
Session.find_elem = (elem, tree) ->
  out = false
  if _.contains(_.keys(tree), elem)
    out = [elem]
  else
    subtrees = _.filter(_.keys(tree), (k) -> return typeof(tree[k])=="object")
    _.each(subtrees,
             (k) ->
               temp = Session.find_elem(elem, tree[k])
               if _.isArray(temp)
                 temp.unshift(k)
                 out = temp
             )
  return out

if Session.get("cur_data")==undefined
  Session.set("cur_data", "")

#cascade down page tree when cur_page is set, always fall to a leaf
Tracker.autorun ->
  cur_page = Session.get("cur_page")
  sub_tree = Session.tree_return(cur_page, Session.page_tree)
  switch typeof(sub_tree)
    when 'object'
      first_child = _.keys(sub_tree)[0]
      Session.set("cur_page", cur_page.concat([first_child]))


if Session.get("cur_page")==undefined
  Session.set("cur_page", ["TEST1","Test11"])
  pathname =  _.chain(window.location.pathname.split('/')).filter((tok)->tok not in [undefined, '', false])
  if Session.tree_return(pathname, Session.page_tree)
    Session.set "cur_age", pathname
