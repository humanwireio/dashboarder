dashboarder
=======

a meteor template to make dashboards[Demo](http://dashboarder.meteor.com)

What is it
------

This repo is a meteor app on the way to being any dashboard you want.

How to use it
------

Essentially, you edit a hashmap that defines the page structure of the dashboard and the views associated with different states of the navbars. Practically,:

1. Fork this repo
2. Edit the js object Session.page_tree in [client/dashboarder.js.coffee](client/dashboarder.js.coffee).

This variable is treated like a hashmap using underscore. Keys are the titles shown in the navbar, properties are either another hashmap defining a subtree or a string with the name of the template associated with that title. Now you can add any content you want to the views as templates utilizing meteors real-time data syncing awesomeness.

Dependency
------
*meteor 0.9