# Documentation

## class `Series`
Defines methods and fields to create and update data series which hold data that could be inserted into any `LineChart` instance. 

### Class methods

**`Series.new(dx, dy, name, col)`**

- Creates a new instance of Series
- Parameters
 - **dx** *(number[])*: 'x' data
 - **dy** *(number[])*: 'y' data
 - **name** *(string)*: Name of the Series 
 - **col** *(integer)*: The color of the series. May specified using hexadecimal format

>You can also call Series (dx, dy, name, col) to create a new instance of this class 

### Instance methods

| Name | Parameters | Return value | Description |
| --- | --- | --- | --- |
| :getName() | | `string`<br>The name of this series | Returns the name of this graph. |
| :getDX() | | `number[]`<br>'x' data | Returns the 'x' data/values |
| :getDY() | | `number[]`<br>'y' data | Returns the 'y' data/values |
| :getColor() | | `integer`<br>The color of the series | | returns the color of this series |
| :getMinX() | | `number`<br>The least 'x' value | Returns the minimum 'x' value |
| : getMinY() | | `number`<br>The minimum 'y' value | Returns the minimum 'y' value |
| :getMaxX() | | `number`<br>The maximum 'y' value | Returns the maxumum 'y' value |
| :getMaxY() | | `number`<br>The maximum 'y' value | Returns the maximum 'y' value |
| :getDataLength() | | `integer`<br>Length of data | Returns the length of 'x' or 'y' data |
| :getLineWidth() | | `integer`<br>The width of the line | Returns the width of the line. Default is 3 |
| :setName(name) | name`string`:<br>The name to be set | `void` | Sets the name of the series to the name set |
| :setData(dx, dy) | dx`number[]`<br>'x' data<br><br>dy`number[]`<br>'y' data | `void` | Sets the values of the series according to the values specified. Would throw an error if the data are not of same length. |
| :setColor(color) | color`integer`<br>The new color. Could specified as a hexadecimal value | `void` | Srts the color if the series to the specified value |
| :setLineWidth(w) | w:`integer`The width of the line | `void` | Sets the width of the line of the series to the specified value |



## class `LineChart`
Defines fields and methods to create and deal with Line graphs 

### Class methods

**`LineChart.init()`**
 - Initializes the LineCharts and the library
> Note: You should call this method each time you play a new nap

**`LineChart.new(id, x, y, w, h)`**
 - Creates a new instance of a LineChart.
 - Parameters
   - **id** *(integer)*: The id of the LineChart
   - **x** *(integer)*:  'x' position of the chart. 
   - **y** *(integer)*:  'y' position of the chart
   - **w** *(integer)*:  width of the chart
   - **h** *(integer)*: height of the chart

> You can also call LineChart(id, x, y, w, h) to create a new instance of this class

### Instance methods

| Name | Parameters | Return values | Description |
| --- | --- | --- | --- |
| :getId() | | `integer`<br>The ID of the chart | Returns the ID of the chart |
| :getDimension() | |`number[]`<br>Returns a table of dimensions of the table containing x, y, width and height values. You can retrieve them by indexing `x`, `y`, `w`, or `h` after calling this method | Returns the dimenstions of the graph |
| :getMinX() | | `number`<br>The minimum X value | Returns the minimum X value |
| :getMinY() | | `number`<br>The minimum Y value | Returns the minimum Y value |
| :getMaxX() | | `number`<br>The maximum X value | Returns the maximum X value |
| :getMaxY() | | `number`<br>The maximum Y value | Returns the maximum Y value |
| :getXRange() | | `number`<br>The Range of X | Returns the range of X values |
| :getYRange() | | `number`<br>The range of Y | | Returns the range of Y values |
| :getDataLength() | |`number`The length of all data | Returns the length of the points of all series included in the instance |
| :getGraphColor() | | `number[]`<br>The graph background and the border color | Returns the background and the border color as a table. The values can be accessed using bgColor and borderColor indexes |
| :getAlpha() | | `number`<br>The alpha (transparency). Default is 
| :show() | | `void` | Shows the graph |
| :setLineColor(color) | color:`number`<br>The color to be set. A hexadecimal value (number) | `void` | Sets the line color |
| :setGraphColor(bg, border) | bg:`number`<br>The background color.<br><br>border:`number`<br>The border color. * Can be specified using hexadecimal values* | `void` |Sets the background and border color of the graph |
| :setAlpha(alpha) | alpha:`number`<br>The alpha/transparency of the chart. Should be between 0 to 1 | `void`| Sets the alpha of the graph |
| :resize(w, h) | w:`number`<br>The new width of the graph<br><br>h:`number`<br> The new height of the graph | `void` | Resizes the graph (changes the width and height). <br>**NOTE: You have to call :show() on the graph to resize the graph |
| :move(x, y) | x:`number`<br> The new 'x' coordinate of the graph<br><br>y:`number`<br>The new 'y' coordinate of the graph | `void` | Moves the graph to the specified coordinates (changes the x and y values of the graph) <br>**NOTE: You have to call :show() on the graph to move the graph to the new location |
| :setData(dx, dy) | dx:`number[]`<br>A table of new X values<br><br>dy:`number[]`<br>A table of new Y values | `void` | Sets new data to x and y axes |
| :hide() | | `void` | Hides the graph |
| :refresh() | | `void` | Refreshes all the data in the chart. This cause to synchronise the changes that have been occured in Series with the chart. <br>*You do not need to call this explicitly in your code as it is included show, addSeries and removeSeries method* |
| :addSeries(series) | series`Series`<br>The new series | `void` | Add the specified Series` instance into the chart |
| removeSeries(name) | name`string`<br>The name of the series | `void` | Removes the series specified by the name |

### Extra methods

`getMin(tbl)`: Returns the minimum value of the specified table `tbl`

`getMax(tbl)`: Returns the maximum value of the speicified table `tbl`

`map(tbl, f)`: Maps and returns the new table from specified table `tbl`, according to the function `f` provided

`range(from, to, step)` Returns a continuous list of numbers from `from` to `to` with an interval of `step`
