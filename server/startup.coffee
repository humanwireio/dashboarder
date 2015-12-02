Meteor.startup ->
  Data.remove({})
  Data.insert
    name: 'test'
    data: {series1: [{x:'2010-01-01',y:1},{x:'2011-01-01',y:2},{x:'2012-01-01',y:3}]}  
  true
