## class `Series`
This class is to hold data and methods that could be display in a line chart.


## class `LineChart`
Defines fields and methods to create and deal with Line graphs 

### Class methods

**`Series.new(dx, dy, name, col)`**
 - Creates a new instance of a Series
 - Parameters
  - **dx** *(number[])*: `x` data
  - **dy** *(number[])*: `y` data
  - **name** *(string)*: The name of the series
  - **col** *(number)*: The color of the Series. May specified as a hexadecimal value.

### Class methods

**`LineChart.new(id, x, y, w, h, dataX, dataY)`**
 - Creates a new instance of a LineChart.
 - Parameters
   - **id** *(integer)*: The id of the LineChart
   - **x** *(integer)*:  'x' position of the chart. 
   - **y** *(integer)*:  'y' position of the chart
   - **w** *(integer)*:  width of the chart
   - **h** *(integer)*: height of the chart
   - **dataX** *(integer[])*: a table of x data values
   - **dataY** *(integer[])*: a table of y data values
  
> You can also call LineChart(id, x, y, w, h, dataX, dataY) to create a new instance of this class

### Instance methods

| Name | Parameters | Return values | Description |
| --- | --- | --- | --- |
| :getId() | | `integer`<br>The ID of the chart | Returns the ID of the chart |
| :getDimension() | |`number[]`<br>Returns a table of dimensions of the table containing x, y, width and height values. You can retrieve them by indexing `x`, `y`, `w`, or `h` after calling this method | Returns the dimenstions of the graph |
| :getData(axis) | axis:`integer`<br>The axis that containing data | `integer[]`<br> The data in the specified axis. Axis could be either `"x"` or "y"` | Returns the data in the specified axis |
| :getMinX() | | `number`<br>The minimum X value | Returns the minimum X value |
| :getMinY() | | `number`<br>The minimum Y value | Returns the minimum Y value |
| :getMaxX() | | `number`<br>The maximum X value | Returns the maximum X value |
| :getMaxY() | | `number`<br>The maximum Y value | Returns the maximum Y value |
| :getXRange() | | `number`<br>The Range of X | Returns the range of X values |
| :getYRange() | | `number`<br>The range of Y | Returns the range of Y values |
| :getLineColor() | | `number`<br>The line color. The default values is 0xFF6600 | Returns the line color  |
| :getAlpha() | | `number`<br>The alpha (transparency). Default is 1 | Returns the alpha |
| :isFixed() | | `boolean`<br>The fixed position | Returns true if graph is fixed. Otherwise false |
| :getLineWidth() | | `number`<br>The line width. Default is 0.3 | Returns the line width |
| :show() | | `void` | Shows the graph |
| :setLineColor(color) | color:`number`<br>The color to be set. A hexadecimal value (number) | `void` | Sets the line color |
| :setGraphColor(bg, border) | bg:`number`<br>The background color.<br><br>border:`number`<br>The border color. * Can be specified using hexadecimal values* | `void` |Sets the background and border color of the graph |
| :setAlpha(alpha) | alpha:`number`<br>The alpha/transparency of the chart. Should be between 0 to 1 | `void`| Sets the alpha of the graph |
| :setFixedPosition(fixed) | fixed:`boolean`<br>The  fixed property of the graph | `void` | Sets the fixed position property of the graph |
| :setLineWidth(width) | width:`number` The width of the line | `void` | Sets the widht of the line |
| :resize(w, h) | w:`number`<br>The new width of the graph<br><br>h:`number`<br> The new height of the graph | `void` | Resizes the graph (changes the width and height). <br>**NOTE: You have to call :show() on the graph to resize the graph |
| :move(x, y) | x:`number`<br> The new 'x' coordinate of the graph<br><br>y:`number`<br>The new 'y' coordinate of the graph | `void` | Moves the graph to the specified coordinates (changes the x and y values of the graph) <br>**NOTE: You have to call :show() on the graph to move the graph to the new location |
| :setData(dx, dy) | dx:`number[]`<br>A table of new X values<br><br>dy:`number[]`<br>A table of new Y values | `void` | Sets new data to x and y axes |
| :hide() | | `void` | Hides the graph |

### Extra methods

`getMin(tbl)`: Returns the minimum value of the specified table `tbl`

`getMax(tbl)`: Returns the maximum value of the speicified table `tbl`

`map(tbl, f)`: Maps and returns the new table from specified table `tbl`, according to the function `f` provided

`range(from, to, step)`: Generates and returns a sequence of numbers from `from` to `to` with an interval of `step`
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTUxMTk5MjM4M119
-->