## What is it?
The structure of this site is determined by a single hashmap defined as a javascript variable called Session.page_tree . The navbar as well as what views (html files) to associate with each nav selection is determined by the page_tree variable.

## What's it good for?
Because this format allows for easy creation of small tree pages, it is ideal for dashboards and personal sites since they will likely have a limited number of pages with a manually defined structure. You can define the `Session.page_tree` variable progromatically creating a deep, complex tree structure, but currently you are limited by the screen width to determine the number of nodes on a tree level.

[demo](dashboarder.meteor.com)
