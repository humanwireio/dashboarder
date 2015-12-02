Template.graph.onCreated ->
  this.id = Math.random().toString(36).substr(2, 5)

Template.graph.onRendered ->
  console.log("rendering graph-"+this.id.toString())

Template.graph.helpers
  id: -> Template.instance().id

  render: ->
    reactD3 = Browserify["react-d3"];
    data_name = Session.get("cur_page").pop()
    panel = document.getElementById("panel")
    if panel
      width = panel.offsetWidth

      graphEl = document.getElementById('graph-'+Template.instance().id.toString())

      rawData = Data.findOne({name:data_name})
      formattedData = _.map _.keys(rawData.data), (k)->
        values = rawData.data[k]
        values = _.map(values, (v)->
          dateObj = new Date(v.x)
          {x:dateObj, y:v.y})
        {name: k, values: values}

      ReactDOM.render(
        React.createElement(reactD3.LineChart,
          {
            legend: true,
            data: formattedData
            width: width,
            height: 500
          }
        ),
        graphEl
      )
      true
