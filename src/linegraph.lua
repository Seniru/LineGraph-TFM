local Series, LineChart, getMin, getMax, map, range

--credits: https://snipplr.com/view/13086/number-to-hex/
--modified by me
local hexstr = '0123456789abcdef'
function num2hex(num)
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    return string.upper(s == '' and '0' or s)
end

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end


--[====[
    @type func
    @name getMin(tbl)
    @param tbl:number[] Input table
    @return number Minimum value
    @brief Returns the minimum value of the passed table
--]====]
function getMin(tbl)
	local min = tbl[1]
	for v = 1, #tbl do
		v = tbl[v]
		if v < min then
			min = v
		end
	end
	return min
end

--[====[
    @type func
    @name getMax(tbl)
    @param tbl:number[] Input table
    @return number Maximum value
    @brief Returns the maximum value of the passed table
--]====]
function getMax(tbl)
	local max = tbl[1]
	for v = 1, #tbl do
		v = tbl[v]
		if v > max then
			max = v
		end
	end
	return max
end

--[====[
    @type func
    @name map(tbl, f)
    @param tbl:any[] Input tble
    @param f:function Input function
    @return any[] A new table mapped according to the function
    @brief Returns a new table mapped according to the function
--]====]
function map(tbl, f)
	local res = {}
	for k, v in next, tbl do
		res[k] = f(v)
	end
	return res
end

--[====[
    @type func
    @name range(from, to, step)
    @param from:number The starting number
    @param to:number The end number
    @param step:number The step value
    @return number[] A table within the range of 'from' and 'to' with a 'step' interval
    @brief Returns a new table within the range of 'from' and 'to' with a 'step' interval
    @description This method is similar to the range method in python. You can use this method inside loops or for any other action
--]====]
function range(from, to, step)
    local insert = table.insert
	local res = { }
	for i = from, to, step do
		insert(res, i)
	end
	return res
end


local function invertY(y)
	return 400 - y
end


--class Series
--[====[
    @type class
    @name Series
    @brief A data series
    @description [
        Data series can be used to store X and Y data of something. This can be also used inside a #LineChart instance to output the data as a chart
    ]
--]====]
Series = {}
Series.__index = Series

setmetatable(Series, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

--[====[
    @type func
    @name Series.new(dx, dy, name, col)
    @param dx:number[] The <code>x</code> data
    @param dy:number[] The <code>y</code> data
    @param name:string The name of the series.
    @param col:number|nil The color of the series. If <code>nil</code> or nothing is provided assigns a random color.
    @return A new Series instance
    @brief Creates a new Series instance
    @description [
        Creates a new series instance. Note that you can also Series(dx, dy, name, col) for the same purpose.
    ]
--]====]
function Series.new(dx, dy, name, col)
  assert(#dx == #dy, "Expected same number of data for both axis")
  local self = setmetatable({ }, Series)
  self.name = name
  self:setData(dx, dy)
  self.col = col or math.random(0x000000, 0xFFFFFF)
  return self
end

--[====[
    @type func
    @name Series:getName()
    @return string The name of the series
    @brief Returns the name of the series
--]====]
function Series:getName() return self.name end

--[====[
    @type func
    @name Series:getDX()
    @return number[] The X data
    @brief Returns the data X
--]====]
function Series:getDX() return self.dx end

--[====[
    @type func
    @name Series:getDX()
    @return number[] The Y data
    @brief Returns the data Y
--]====]
function Series:getDY() return self.dy end

--[====[
    @type func
    @name Series:getColor()
    @return number the color of the series
    @brief Returns the color of the series
--]====]
function Series:getColor() return self.col end

--[====[
    @type func
    @name Series:getMinX()
    @return number Minimum X value
    @brief Returns the miminum X value of the series
--]====]
function Series:getMinX() return self.minX end

--[====[
    @type func
    @name Series:getMinY()
    @return number Minimum Y value
    @brief Returns the minimum Y value of the series
--]====]
function Series:getMinY() return self.minY end

--[====[
    @type func
    @name Series:getMaxX()
    @return number Maximum X value
    @brief Returns the maximum X value of the series
--]====]
function Series:getMaxX() return self.maxX end

--[====[
    @type func
    @name Series:getMaxY()
    @return number Maximum Y value
    @brief Returns the maximum Y value of the series
--]====]
function Series:getMaxY() return self.maxY end

--[====[
    @type func
    @name Series:getDataLength()
    @return number The length of the data
    @brief Returns the length of data. (This is the length of 'x' or 'y' values provided)
--]====]
function Series:getDataLength() return #self.dx end

--[====[
    @type func
    @name Series:getLineWidth()
    @return integer The width of the line
    @brief Returns the length of the line
    @description [
        The line width is the width of the line that is displayed in the chart. The default line width is 3. You can change the width by using Series:setLineWidth method
    ]
--]====]
function Series:getLineWidth() return self.lWidth or 3 end

--[====[
    @type func
    @name Series:setName(name)
    @param name:string The new name
    @brief Sets the name of the series
    @description [
        Calling this method would alter the name of the series. This would also change the name in labels of the chart if labels are enabled
    ]
--]====]
function Series:setName(name)
  self.name = name
end

--[====[
    @type func
    @name Series:setData(dx, dy)
    @param dx:number[] New x data
    @param dy:number[] New y data
    @brief Sets the new x and y data
    @description [
        Calling this method would change the x and y data in the series. This would throw an error if <b> the lengths are not equal.</b>
        <b>NOTE: You must call :show() method of the relevant linechart to get the updated results</b>
    ]
--]====]
function Series:setData(dx, dy)
  self.dx = dx
  self.dy = dy
  self.minX = getMin(dx)
  self.minY = getMin(dy)
  self.maxX = getMax(dx)
  self.maxY = getMax(dy)
end

--[====[
    @type func
    @name Series:setColor(col)
    @param col:number The new color
    @brief Sets the color of the series
    @description [
        Changes the line color of the series with the given color. The color should be a number and not a string. However you can use hexadecimal values like 0xFFFFFF (white color) (and without quotation marks) to improve readability of your code
    ]
--]====]
function Series:setColor(col)
  self.col = col
end

--[====[
    @type func
    @name Series:setLineWidth(w)
    @param w:number The width of the series
    @brief Sets the width of the line of the series
--]====]
function Series:setLineWidth(w)
  self.lWidth = w
end

-- class LineChart

--[====[
    @type class
    @name LineChart
    @brief LineChart class defines fields and methods to deal with Series and other LineChart properties
--]====]
LineChart = {}
LineChart.__index = LineChart
LineChart._joints = 10000

setmetatable(LineChart, {
	__call = function (cls, ...)
		return cls.new(...)
	end
})

--[====[
    @type func
    @name LineChart.init()
    @brief Initializes all the line charts
    @description [
        Here initializing means adding a physical object away from the visible area of the map. This is to ensure all the joints are working properly.
        <b>NOTE: You must call this method in each new game</b>
    ]
--]====]
function LineChart.init()
    tfm.exec.addPhysicObject(-1, 0, 0, { type = 14, miceCollision = false, groundCollision = false })
end

--[====[
    @type func
    @name LineChart.handleClick(id, n, call)
    @param id:integer The ID of the data point (text area)
    @param n:string The name of the player
    @param call:string Event callback
    @brief This method handles click events to display data labels
    @description [
        There is no need to manually call this method inside your code. You need to just insert this inside the eventTextAreaCallback method
        <b><i>Example</i></b>
        <pre><code>
            ...

            function eventTextAreaCallback(id, n, call)
                LineChart.handleclicks(id, n, call)
            end

            ...
        </code></pre>

        This method usually triggers when a player click a data label
    ]
--]====]
function LineChart.handleClick(id, n, call)
    if call:sub(0, ("lchart:data:["):len()) == 'lchart:data:[' then
        local cdata = split(call:sub(("lchart:data:["):len() + 1, -2), ",")
        local cx, cy, cdx, cdy = split(cdata[1], ":")[2], split(cdata[2], ":")[2], split(cdata[3], ":")[2], split(cdata[4], ":")[2]
        ui.addTextArea(18000, "<a href='event:close'>X: " .. cdx .. "<br>Y: " ..cdy .. "</a>", n, cx, cy, 80, 30, nil, nil, 0.5, true)
    elseif call == "close" then
        ui.removeTextArea(id)
    end
end

--[====[
    @type func
    @name LineChart.new(id, x, y, w, h)
    @param id:any The unique ID of the LineChart
    @param x:integer The x position of the chart
    @param y:integer The y position of the chart
    @param w:integer The width of the chart
    @param h:integer The height of th chart
    @return LineChart A new LineChart instance
    @brief Returns a new LineChart instance with the provided configuration
--]====]
function LineChart.new(id, x, y, w, h)
	local self = setmetatable({ }, LineChart)
	self.id = id
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.showing = false
	self.joints = LineChart._joints
	LineChart._joints = LineChart._joints + 10000
    self.series = { }
	return self
end

--getters

--[====[
    @type func
    @name LineChart:getID()
    @return The ID of the chart
    @brief any Returns the ID of the chart
--]====]
function LineChart:getId() return self.id end

--[====[
    @type func
    @name LineChart:getDimension()
    @return table The dimension of the chart
    @brief Returns the x,y,w,h properties / dimensions of the chart
    @description [
        Return the dimension of the chart as a table. The dimensions of the chart can be accessed by the following keys
        <ul>
            <li>x</li>
            <li>y</li>
            <li>w</li>
            <li>h</li>
        </ul>
        The above keys are relevant to the x position, y position, width and height of the chart respectively.
    ]
--]====]
function LineChart:getDimension() return { x = self.x, y = self.y, w = self.w, h = self.h } end

--[====[
    @type func
    @name LineChart:getMinX()
    @return integer The minimum X value
    @brief Returns the minimum X value of all the series
--]====]
function LineChart:getMinX() return self.minX end

--[====[
    @type func
    @name LineChart:getMaxX()
    @return integer The maximum X value
    @brief Returns the maximum X value of all the series
--]====]
function LineChart:getMaxX() return self.maxX end

--[====[
    @type func
    @name LineChart:getMinY()
    @return number The minimum Y value of all the series
    @brief Return the minimum Y value of all the series
--]====]
function LineChart:getMinY() return self.minY end

--[====[
    @type func
    @name LineChart:getMaxX()
    @return number The maximum X value of all the series
    @brief Returns the maximum X value of all the series
--]====]
function LineChart:getMaxY() return self.maxY end

--[====[
    @type func
    @name LineChart:getXRange()
    @return number The X range of all the series
    @brief Returns the X range of all the series
    @description [
        The X range is calculated as follows
        <pre>
            x range = maxX() - minX()
        </pre>
    ]
--]====]
function LineChart:getXRange() return self.xRange end

--[====[
    @type func
    @name LineChart:getYRange()
    @return number The Y range of all the series
    @brief Returns the Y range of all the series
    @description [
        The Y range is calculated as follows
        <pre>
            y range = maxY() - minY()
        </pre>
    ]
--]====]
function LineChart:getYRange() return self.yRange end

--[====[
    @type func
    @name LineChart:getGraphColor()
    @return table A table containing colors of the graph
    @brief Returns A table containing colors of the graph
    @description [
        Return a table which contains the background and the border color of the graph
        <br>
        The keys and values relevant to those field are as follows
        <br>
        <b>bgColor</b>: (default 0x324650) - The background color<br>
        <b>borderColor</b>: (default 0x212F36) - The border color<br>
    ]
--]====]
function LineChart:getGraphColor() return { bgColor = self.bg or 0x324650, borderColor = self.border or 0x212F36 } end

--[====[
    @type func
    @name LineChart:getAlpha()
    @return number Opacity of the graph
    @brief Returns the opacity of the graph. Default is 0.5
--]====]

function LineChart:getAlpha() return self.alpha or 0.5 end

--[====[
    @type func
    @name LineChart:isShowing()
    @return boolean The showing state of the graph
    @brief Returns true if the graph is visible and otherwise false
--]====]
function LineChart:isShowing() return self.showing end

--[====[
    @type func
    @name LineChart:getDataLength()
    @return integer Totl number of data
    @brief Returns the total number of data in all series
--]====]
function LineChart:getDataLength()
  local count = 0
  for _, s in next, self.series do
    count = count + s:getDataLength()
  end
  return count
end

--[====[
    @type func
    @name LineChart:show()
    @brief Shows the linechart
    @description [
        Shows the linechart. You must call this at every new round or after updating the linechart
    ]
--]====]
function LineChart:show()
    self:refresh()
    local floor, ceil = math.floor, math.ceil
	--the graph plot
	ui.addTextArea(10000 + self.id, "", nil, self.x, self.y, self.w, self.h, self.bg, self.border, self:getAlpha(), true)
	--label of the origin
	ui.addTextArea(11000 + self.id, "<b>[" .. floor(self.minX) .. ", "  .. floor(self.minY) .. "]</b>", nil, self.x - 15, self.y + self.h + 5, 50, 50, nil, nil, 0, true)
	--label of the x max
	ui.addTextArea(12000 + self.id, "<b>" .. ceil(self.maxX) .. "</b>", nil, self.x + self.w + 10, self.y + self.h + 5, 50, 50, nil, nil, 0, true)
	--label of the y max
	ui.addTextArea(13000 + self.id, "<b>" .. ceil(self.maxY) .. "</b>", nil, self.x - 15, self.y - 10, 50, 50, nil, nil, 0, true)
	--label x median
	ui.addTextArea(14000 + self.id, "<b>" .. ceil((self.maxX + self.minX) / 2) .. "</b>", nil, self.x + self.w / 2, self.y + self.h + 5, 50, 50, nil, nil, 0, true)
	--label y median
	ui.addTextArea(15000 + self.id, "<br><br><b>" .. ceil((self.maxY + self.minY) / 2) .. "</b>", nil, self.x - 15, self.y + (self.h - self.y) / 2, 50, 50, nil, nil, 0, true)

	local joints = self.joints
	local xRatio = self.w / self.xRange
	local yRatio = self.h / self.yRange
  for id, series in next, self.series do
    for d = 1, series:getDataLength(), 1 do
        local x1 = floor(series:getDX()[d] * xRatio  + self.x - (self.minX * xRatio))
        local y1 = floor(invertY(series:getDY()[d] * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio))
        local x2 = floor((series:getDX()[d+1]  or series:getDX()[d]) * xRatio + self.x - (self.minX * xRatio))
        local y2 = floor(invertY((series:getDY()[d+1] or series:getDY()[d]) * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio))
		tfm.exec.addJoint(self.id + 6 + joints ,-1,-1,{
			type=0,
			point1= x1 .. ",".. y1,
			point2=  x2 .. "," .. y2,
			damping=0.2,
			line=series:getLineWidth(),
			color=series:getColor(),
			alpha=1,
			foreground=true
        })
        if self.showDPoints then
            ui.addTextArea(16000 + self.id + joints, "<font color='#" .. num2hex(series:getColor()) .."'><a href='event:lchart:data:[x:" .. x1 .. ",y:" .. y1 .. ",dx:" .. series:getDX()[d] .. ",dy:" .. series:getDY()[d] .. "]'>█</a></font>", nil, x1, y1, 10, 10, nil, nil, 0, true)
        end
		joints = joints + 1
	  end
  end

	self.showing = true
end

--[====[
    @type func
    @name LineChart:setGraphColor(bg, border)
    @param bg:number The color of the background
    @param border:number The color of the border
    @brief Sets the color of the grph
--]====]
function LineChart:setGraphColor(bg, border)
	self.bg = bg
	self.border = border
end

--[====[
    @type func
    @name LineChart:setShowDataPoints(show)
    @param show:boolean The status of showing data points
    @brief Shows data points if true
--]====]
function LineChart:setShowDataPoints(show)
    self.showDPoints = show
end

--[====[
    @type func
    @name LineChart:setAlpha(alpha)
    @param alpha:number The opacity
    @brief Sets the opacity of the graph
--]====]
function LineChart:setAlpha(alpha)
	self.alpha = alpha
end

--[====[
    @type func
    @name LineChart:addSeries(series)
    @param series:Series The new series
    @brief Adds a new series to the graph
    @description [
        You can use this method to add new series and even support multi series graphs! <br>
        <b>NOTE: You must call show() method on self to display the updated data</b>
    ]
--]====]
function LineChart:addSeries(series)
  table.insert(self.series, series)
  self:refresh()
end

--[====[
    @type func
    @name LineChart:removeSeries(name)
    @param name:string The name of the series
    @brief Removes a series by name
    @description [
        Call this method to remove a series from the graph. The <i>name</i> argument is the ID of the series. <br>
        <b>NOTE: You must call show() method on self to display the updated data</b>
    ]
--]====]
function LineChart:removeSeries(name)
  for i=1, #self.series do
    if self.series[i]:getName() == name then
      table.remove(self.series, i)
      break
    end
  end
  self:refresh()
end

--[====[
    @type func
    @name LineChart:refresh()
    @brief Refreshes the graph
    @description [
        Causes the graph to refresh all of it's values. Useful when a new series is added, removed or altered it's data.
        The actions happen with this method can be listed as follows<br>
        <ul>
            <li>Updating minX</li>
            <li>Updating maxX</li>
            <li>Updating minY</li>
            <li>Updating minX</li>
            <li>Updating x range</li>
            <li>Updating y range</li>
        </ul>
        You don't need to call this method explicitly as this method is included in related methods
    ]
--]====]
function LineChart:refresh()
  self.minX, self.minY, self.maxX, self.maxY = nil
  for k, s in next, self.series do
    self.minX = math.min(s:getMinX(), self.minX or s:getMinX())
    self.minY = math.min(s:getMinY(), self.minY or s:getMinY())
    self.maxX = math.max(s:getMaxX(), self.maxX or s:getMaxX())
    self.maxY = math.max(s:getMaxY(), self.maxY or s:getMaxY())
  end
    self.xRange = self.maxX - self.minX
    self.yRange = self.maxY - self.minY
end

--[====[
    @type func
    @name LineChart:resize(w, h)
    @param w:integer New width
    @param h:integer New height
    @brief Resizes the graph
--]====]
function LineChart:resize(w, h)
	self.w = w
	self.h = h
end

--[====[
    @type func
    @name LineChart:move(x, y)
    @param x:integer New x position
    @param y:integer New y position
    @brief Moves the graph
--]====]
function LineChart:move(x, y)
	self.x = x
	self.y = y
end

--[====[
    @type func
    @name LineChart:hide()
    @brief Hides the graph and all it's series
--]====]
function LineChart:hide()
	for id = 10000, 17000, 1000 do
		ui.removeTextArea(id + self.id)
    end
    for id = self.id + 16000, self.joints, 1 do
        ui.removeTextArea(id + self.id)
    end
	for d = self.joints, self.joints + self:getDataLength() + 5, 1 do
		tfm.exec.removeJoint(d)
	end
	self.showing = false
end

--[====[
    @type func
    @name LineChart:showLabels(show)
    @param show:boolean The show state of the labels
    @brief Shows or hide the labels
    @description [
        This method shows the names and colors of the series at the right side of the chart. This method is very useful when dealing with multi-series graphs
    ]
--]====]
function LineChart:showLabels(show)
  if show or show == nil then
  local labels = ""
    for _, series in next, self.series do
      labels = labels .. "<font color='#" .. num2hex(series:getColor()) .. "'> ▉<b> " .. series:getName() .. "</b></font><br>"
    end
    ui.addTextArea(16000 + self.id, labels, nil, self.x + self.w + 15, self.y, 80, 18 * #self.series, self:getGraphColor().bgColor, self:getGraphColor().borderColor, self:getAlpha(), true )
  else
    ui.removeTextArea(16000 + self.id, nil)
  end
end

--[====[
    @type func
    @name LineChart:displayGrids(show)
    @param show:boolean The show state of the grids
    @brief Shows or hide the grids
    @description [
        Calling this method with true for the show parameter would add grids to the graph.
    ]
--]====]
function LineChart:displayGrids(show)
    if show or show == nil then
        local interval = self.h / 5
        for id, y in next, range(self.y + interval, self.y + self.h - interval, interval) do
            --Adds joints in the mid 4 positions of the graph
            tfm.exec.addJoint(self.id + id ,-1,-1,{
			    type=0,
			    point1= self.x .. "," .. y,
			    point2=  self.x + self.w .. "," .. y,
			    damping=0.2,
			    line=1,
			    alpha=1,
                foreground=true,
                color=0xFFFFFF
		    })
        end
        --Adds a joint near the median x value of the graph
        tfm.exec.addJoint(self.id + 5 ,-1,-1,{
			    type=0,
			    point1= self.x + self.w / 2 .. "," .. self.y,
			    point2=  self.x + self.w / 2 .. "," .. self.y + self.h,
			    damping=0.2,
			    line=2,
			    alpha=1,
                foreground=true,
                color=0xFFFFFF
        })
        --Adds a joint near the median y value of the graph
        tfm.exec.addJoint(self.id + 6 ,-1,-1,{
			    type=0,
			    point1= self.x  .. "," .. self.y + self.h / 2,
			    point2=  self.x + self.w .. "," .. self.y + self.h / 2,
			    damping=0.2,
			    line=2,
			    alpha=1,
                foreground=true,
                color=0xFFFFFF
		})
    end
end
