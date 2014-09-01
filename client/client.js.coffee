if Session.get("cur_page")==undefined
  Session.set("cur_page", ["TEST1","Test11"])

Session.page_tree =
                    "TEST1":
                         "Test11":"status"
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

#returns value of page in tree
Session.tree_return = (page, tree)->
  cur = tree
  i=0
  while i<page.length
    cur = cur[page[i]]
    i++
  return cur

#TODO: fix the following
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
  
