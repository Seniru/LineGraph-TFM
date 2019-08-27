
<h1 align='center'>LineGraph-TFM</h1>
<p align='center'><a href="https://ibb.co/d2vWYHC"><img src="https://i.ibb.co/cF9gnsf/graph.png" alt="graph" border="0" width="90%" height="250"></a></p>
<p align='center'> 
 Lite, Reusable and customizable line charts for Transformice!
 <br> <a href='#contributors'><img src='https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square' alt='All Contributors'></a>
  <img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/Seniru/LineGraph-TFM">
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

### Usage
```lua
--insert the library code before the script
--then just call LineChart(id, x, y, w, h, dataX, dataY) to create a new chart
chart = LineChart(1, 200, 50, 400, 200, {-3, -2, -1, 0, 1, 2, 3}, {-3, -2, -1, 0, 1, 2, 3})
--display the chart
chart:show()
-- this should show a linear chart ...
```
Check the [documentation](https://github.com/Seniru/LineGraph-TFM/blob/master/documentation.md) for more

### Demos


<a href="https://www.codecogs.com/eqnedit.php?latex=y&space;=&space;tan\&space;x" target="_blank"><img src="https://latex.codecogs.com/gif.latex?y&space;=&space;tan\&space;x" title="y = tan\ x" /></a>

```lua
x = range(-5, 5, 0.5)
y = map(x, function(x) return math.tan(x) end)

chart = LineChart(1, 200, 50, 400, 200, x, y) --instantiation
chart:setLineColor(0xFFCC00) --sets the line color to yellowish-orange
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:show() --display the chart
```
<p align='center'>
<a href="https://ibb.co/609mvks"><img src="https://i.ibb.co/1GyLsk2/graph2.png" alt="graph2" border="0" width=95% height=250></a>
</p>
<hr>

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;y&space;=&space;2x^2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;2x^2" title="y = 2x^2" /></a>

```lua
x = range(-5, 5, 0.5)
y = map(x, function(x) return 2 * x * x end)

chart = LineChart(1, 200, 50, 400, 200, x, y) --instantiation
chart:setLineColor(0xCC89FF) --sets the line color to purple
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:show() --display the chart
```
<p align='center'><img src='https://i.imgur.com/TulCY9W.png' width=95% height=250></p>
<hr>

Real time Graphs! <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;sin(x)&space;\times&space;x&space;^2&space;\times&space;tanh(x)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;sin(x)&space;\times&space;x&space;^2&space;\times&space;tanh(x)" title="sin(x) \times x ^2 \times tanh(x)" /></a>
```lua
chart = LineChart(1, 200, 50, 400, 200, {0}, {0}) --instantiation
chart:setLineColor(0xDD32CC) --sets the line color to pink
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white

currX = 0
--the real time mageic is here!
function eventLoop(l, r)
	local x = range(currX, currX + 10, 0.1) --creates the x coordinates
	local y = map(x, function(x) return  math.sin(x) * x * x * math.tanh(x) end ) --maps x values to the specified function
	chart:setData(x,y) -- sets the new data to the graph
	chart:show() --displays it
	currX = currX + 0.5 --this cause x coordinate to move by 0.5 every 500ms
end
```
<p align='center'>
	<img src='https://media.giphy.com/media/ZbSt4f4p32yU0est9S/giphy.gif' width=95% height=250>
</p>

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/Seniru"><img src="https://avatars2.githubusercontent.com/u/34127015?v=4" width="100px;" alt="Seniru Pasan Indira"/><br /><sub><b>Seniru Pasan Indira</b></sub></a><br /><a href="https://github.com/Seniru/LineGraph-TFM/commits?author=Seniru" title="Code">💻</a> <a href="https://github.com/Seniru/LineGraph-TFM/commits?author=Seniru" title="Documentation">📖</a> <a href="#design-Seniru" title="Design">🎨</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
