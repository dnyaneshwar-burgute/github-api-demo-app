
$(document).on('click', '.show_graph', function () {

  var repo = $(this).attr('data-repo');
  $("#repo"+repo).html("");
  var parent_div = $(this).parent();
  var start_date = $(parent_div).children('input#start_date').val();
  var start_date = $(parent_div).children('input#end_date').val();
  if (start_date == "" || end_date == "") {
    alert("Please select the dates...");
    return;
  }
  console.log("Start Date : " + start_date + ", End Date: " + end_date);
  var data = getData({repo: repo, start_date: start_date, end_date: end_date});
  drawChart(repo, data);
});

function drawChart(repo, data) {

  var margin = {top: 20, right: 20, bottom: 70, left: 40},
      width = 600 - margin.left - margin.right,
      height = 300 - margin.top - margin.bottom;

  // Parse the date / time
  var parseDate = d3.time.format("%d-%m-%Y").parse;

  data.forEach(function(d) {
    d.date = parseDate(d.date);
  });

  debugger;

  var x = d3.scale.ordinal().rangeRoundBands([0, width], .05);

  var y = d3.scale.linear().range([height, 0]);

  var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .tickFormat(d3.time.format("%d-%m-%Y"));

  var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(10);

  var svg = d3.select("div#repo"+repo).append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

  x.domain(data.map(function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.total; })]);

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
    .selectAll("text")
    .style("text-anchor", "end")
    .attr("dx", "-.8em")
    .attr("dy", "-.55em")
    .attr("transform", "rotate(-90)" );

  svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Commit(Count)");

  svg.selectAll("bar")
    .data(data)
    .enter().append("rect")
    .style("fill", "steelblue")
    .attr("x", function(d) { return x(d.date); })
    .attr("width", x.rangeBand())
    .attr("y", function(d) { return y(d.total); })
    .attr("height", function(d) { return height - y(d.total); });

}

function getData(params) {
  // var result = $.ajax({
  //   url: '/repo_commmits',
  //   async: false,
  //   dataType: 'json',
  //   data: { repo: repo, start_date: start_date, end_date: end_date }
  // }).responseJSON;
  return [
    {
      date: '10-10-2016',
      total: 5
    },{
      date: '10-11-2016',
      total: 10
    },{
      date: '11-10-2017',
      total: 20
    }
  ]
}