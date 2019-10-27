

<h1 align='center'>LineGraph-TFM</h1>
<p align='center'><a href="https://ibb.co/d2vWYHC"><img src="https://i.ibb.co/cF9gnsf/graph.png" alt="graph" border="0" width="90%" height="250"></a></p>
<p align='center'> 
 Lite, Reusable and customizable line charts for Transformice!
 <br> 
   <a href='https://github.com/Seniru/LineGraph-TFM/actions'><img alt='Build status' src='https://github.com/Seniru/LineGraph-TFM/workflows/Build%20and%20Deploy/badge.svg'></a>
   <a href='#contributors'><img src='https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square' alt='All Contributors'></a>
  <img alt="GitHub file size in bytes" src="https://img.shields.io/github/size/Seniru/LineGraph-TFM/src/linegraph.min.lua?label=Code%20size%20%28min%29">
  <img alt="GitHub tag (latest SemVer)" src="https://img.shields.io/github/v/tag/Seniru/LineGraph-TFM?sort=semver">
  <a href='https://opensource.org/licenses/MIT'><img src='https://img.shields.io/badge/License-MIT-yellow.svg' alt='License'></a><br> 
</p>

### Features
- Reusable
- Lightweight
- Customizable
- Real time!
- Class based
- Easy

### What's new! :fireworks: :fireworks: :fireworks:

- Now you can add multiple Series to the same graph. Check out the 
[documentation](https://github.com/Seniru/LineGraph-TFM/blob/master/documentation.md) for more information!
### Usage
```lua
--insert the library code before the script
--then call LineChart.init()
LineChart.init()
--then call LineChart(id, x, y, w, h) to create a new chart
chart = LineChart(1, 200, 50, 400, 200)
--create a new series to insert into the created chart.
series1 = Series({1,2,3}, {1,2,3}, "series1")
--add it to the chart
chart:addSeries(series1)
--set the labels to display (optional)
chart:showLabels()
--display the chart
chart:show()
-- this should show a linear chart ...
```
Check the [documentation](https://github.com/Seniru/LineGraph-TFM/blob/master/documentation.md) for more

### Demos


<a href="https://www.codecogs.com/eqnedit.php?latex=y&space;=&space;tan\&space;x" target="_blank"><img src="https://latex.codecogs.com/gif.latex?y&space;=&space;tan\&space;x" title="y = tan\ x" /></a>

```lua
LineChart.init() --initialzing

x = range(-5, 5, 0.5)
y = map(x, function(x) return math.tan(x) end)

chart = LineChart(1, 200, 50, 400, 200) --instantiation
series1 = Series(x, y, "y = tan x", 0xFFCC00) -- creates a new series with yellowish-orange color
chart:addSeries(series1)
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:show() --display the chart

```
<p align='center'>
<a href="https://ibb.co/609mvks"><img src="https://i.ibb.co/1GyLsk2/graph2.png" alt="graph2" border="0" width=95% height=250></a>
</p>
<hr>

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;y&space;=&space;2x^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;2x^2" title="y = 2x^2" /></a>

```lua
LineChart.init() --initializing

x = range(-5, 5, 0.5)
y = map(x, function(x) return 2 * x * x end)

chart = LineChart(1, 200, 50, 400, 200) --instantiation
chart:addSeries(Series(x, y, "y = 2x^2", 0xCC89FF)) --adds a new series with color purple
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:show() --display the chart
```
<p align='center'><img src='https://i.imgur.com/TulCY9W.png' width=95% height=250></p>
<hr>

Real time Graphs! <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;sin(x)&space;\times&space;x&space;^2&space;\times&space;tanh(x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;sin(x)&space;\times&space;x&space;^2&space;\times&space;tanh(x)" title="sin(x) \times x ^2 \times tanh(x)" /></a>
```lua
LineChart.init()

chart = LineChart(1, 200, 50, 400, 200) --instantiation
series1 = Series({0}, {0}, "Real time", 0xDD32CC) --creates a new series
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:addSeries(series1) --adds the new series

currX = 0
--the real time mageic is here!
function eventLoop(l, r)
	local x = range(currX, currX + 10, 0.1) --creates the x coordinates
	local y = map(x, function(x) return  math.sin(x) * x * x * math.tanh(x) end ) --maps x values to the specified function
	series1:setData(x, y) --set new data to the series
	chart:show() --displays it
	currX = currX + 0.5 --this cause x coordinate to move by 0.5 every 500ms
end
```
<p align='center'>
	<img src='https://media.giphy.com/media/ZbSt4f4p32yU0est9S/giphy.gif' width=95% height=250>
</p>

Multi-Series Graphs! 

```lua
LineChart.init()

chart = LineChart(1, 200, 50, 400, 200) --creates the chart (container for the series)
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
xData = range(0, 20, 1)  --creates a list of numbers from 0 to 20

series1 = Series(xData, xData, "linear") --creates a linear series
series2 = Series(xData, map(xData, function(x) return math.cos(x) end), "y = cos x") --creates a series which maps 'y' values to the 'tan x' value
series3 = Series(xData, map(xData, function(x) return math.random(x) end), "random") --creates a series which maps 'y' values randomly to 'x'

--add all the series
chart:addSeries(series1)
chart:addSeries(series2)
chart:addSeries(series3)

chart:showLabels() --show the labels
chart:show() --show the plots!
```
<p align='center'>
	<img src='https://i.ibb.co/F7w6sFp/Capt32ure.png' width=95% height=250>
</p>


## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/Seniru"><img src="https://avatars2.githubusercontent.com/u/34127015?v=4" width="100px;" alt="Seniru Pasan Indira"/><br /><sub><b>Seniru Pasan Indira</b></sub></a><br /><a href="https://github.com/Seniru/LineGraph-TFM/commits?author=Seniru" title="Code">💻</a> <a href="https://github.com/Seniru/LineGraph-TFM/commits?author=Seniru" title="Documentation">📖</a> <a href="#design-Seniru" title="Design">🎨</a></td>
    <td align="center"><a href="http://bit.ly/laut-id"><img src="https://avatars2.githubusercontent.com/u/26045253?v=4" width="100px;" alt="Lautenschlager"/><br /><sub><b>Lautenschlager</b></sub></a><br /><a href="https://github.com/Seniru/LineGraph-TFM/commits?author=Lautenschlager-id" title="Code">💻</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTA5ODM5NzldfQ==
-->
