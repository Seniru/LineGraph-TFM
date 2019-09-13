local function getMin(tbl)
	local min = tbl[1]
	for v = 1, #tbl do
		v = tbl[v]
		if v < min then
			min = v
		end
	end
	return min
end

local function getMax(tbl)
	local max = tbl[1]
	for v = 1, #tbl do
		v = tbl[v]
		if v > max then
			max = v
		end
	end
	return max
end

local function map(tbl, f)
	local res = {}
	for k, v in next, tbl do
		res[k] = f(v)
	end
	return res
end

local function range(from, to, step)
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

local LineChart = {}
LineChart.__index = LineChart
LineChart._joints = 10000

setmetatable(LineChart, {
	__call = function (cls, ...)
		return cls.new(...)
	end,
})

function LineChart.init()
    tfm.exec.addPhysicObject(-1, 0, 0, { type = 14, miceCollision = false, groundCollision = false })
end

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
function LineChart:getId() return self.id end
function LineChart:getDimension() return { x = self.x, y = self.y, w = self.w, h = self.h } end
function LineChart:getData(axis) if axis == "x" then return self.dataX else return self.dataY end end
function LineChart:getMinX() return self.minX end
function LineChart:getMaxX() return self.maxX end
function LineChart:getMinY() return self.minY end
function LineChart:getMaxY() return self.maxY end
function LineChart:getXRange() return self.xRange end
function LineChart:getYRange() return self.yRange end
function LineChart:getLineColor() return self.lineColor or 0xFF6600 end
function LineChart:getGraphColor() return { bgColor = self.bg or 0x324650, borderColor = self.border or 0x212F36 } end
function LineChart:getAlpha() return self.alpha or 1 end
function LineChart:isFixed() return not not self.fixed end
function LineChart:getLineWidth() return self.lWidth or 0.3 end
function LineChart:isShowing() return self.showing end
	
function LineChart:show()
    local floor, ceil = math.floor, math.ceil
	--the graph plot
	ui.addTextArea(10000 + self.id, "", nil, self.x, self.y, self.w, self.h, self.bg, self.border, self.alpha or 0.5, self.fixed)
	--label of the origin
	ui.addTextArea(11000 + self.id, "<b>[" .. floor(self.minX) .. ", "  .. floor(self.minY) .. "]</b>", nil, self.x - 15, self.y + self.h + 5, 50, 50, nil, nil, 0, self.fixed)
	--label of the x max
	ui.addTextArea(12000 + self.id, "<b>" .. ceil(self.maxX) .. "</b>", nil, self.x + self.w + 10, self.y + self.h + 5, 50, 50, nil, nil, 0, self.fixed)
	--label of the y max
	ui.addTextArea(13000 + self.id, "<b>" .. ceil(self.maxY) .. "</b>", nil, self.x - 15, self.y - 10, 50, 50, nil, nil, 0, self.fixed)
	--label x median
	ui.addTextArea(14000 + self.id, "<b>" .. ceil((self.maxX + self.minX) / 2) .. "</b>", nil, self.x + self.w / 2, self.y + self.h + 5, 50, 50, nil, nil, 0, self.fixed)
	--label y median
	ui.addTextArea(15000 + self.id, "<br><br><b>" .. ceil((self.maxY + self.minY) / 2) .. "</b>", nil, self.x - 15, self.y + (self.h - self.y) / 2, 50, 50, nil, nil, 0, self.fixed)

	local joints = self.joints
	local xRatio = self.w / self.xRange
	local yRatio = self.h / self.yRange
	--[[for d = 1, #self.dataX, 1 do
		tfm.exec.addJoint(self.id + joints ,-1,-1,{
			type=0,
			point1= floor(self.dataX[d] * xRatio  + self.x - (self.minX * xRatio)) .. ",".. floor(invertY(self.dataY[d] * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio)),
			point2=  floor((self.dataX[d+1]  or self.dataX[d]) * xRatio + self.x - (self.minX * xRatio)) .. "," .. floor(invertY((self.dataY[d+1] or self.dataY[d]) * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio)),
			damping=0.2,
			line=self.lWidth or 3,
			color=self.lineColor or 0xFF6600,
			alpha=self.alpha or 1,
			foreground=true
		})
		joints = joints + 1
	end]]

  for id, series in next, self.series do
    for d = 1, #series[1], 1 do
		tfm.exec.addJoint(self.id + joints ,-1,-1,{
			type=0,
			point1= floor(series[1][d] * xRatio  + self.x - (self.minX * xRatio)) .. ",".. floor(invertY(series[2][d] * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio)),
			point2=  floor((series[1][d+1]  or series[1][d]) * xRatio + self.x - (self.minX * xRatio)) .. "," .. floor(invertY((series[2][d+1] or series[2][d]) * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio)),
			damping=0.2,
			line=self.lWidth or 3,
			color=self.lineColor or 0xFF6600,
			alpha=self.alpha or 1,
			foreground=true
		})
		joints = joints + 1
	  end
  end

	self.showing = true
end

function LineChart:setLineColor(color)
	self.lineColor = color
end

function LineChart:setGraphColor(bg, border)
	self.bg = bg
	self.border = border
end

function LineChart:setAlpha(alpha)
	self.alpha = alpha
end

function LineChart:setFixedPosition(fixed)
	self.fixed = fixed
end

function LineChart:setLineWidth(width)
	self.lWidth = width
end

function LineChart:addSeries(dx, dy)
  assert(#dx == #dy, "Expected same number of data for both axis")
  table.insert(self.series, {dx, dy})
  self.minX = getMin(dx) < (self.minX or 0) and getMin(dx) or self.minX
  self.minY = getMin(dy) < (self.minY or 0) and getMin(dy) or self.minY
  self.maxX = getMax(dx) > (self.maxX or 0) and getMax(dx) or self.maxX
  self.maxY = getMax(dy) > (self.maxY or 0) and getMax(dy) or self.maxY
  self.xRange = self.maxX - self.minX
  self.yRange = self.maxY - self.minY
end

function LineChart:resize(w, h)
	self.w = w
	self.h = h
end

function LineChart:move(x, y)
	self.x = x
	self.y = y
end


function LineChart:hide()
	for id = 10000, 16000, 1000 do
		ui.removeTextArea(id + self.id)
	end

	for d = self.joints, self.joints + #self.dataX, 1 do
		tfm.exec.removeJoint(d)
	end
	self.showing = false
end

x = range(-5, 5, 0.5)
y = map(x, function(x) return math.tan(x) end)
x1 = range(-5, 5, 0.5)
y1 = map(x, function(x) return 2 * x * x end)
x3 = range(currX, currX + 10, 0.1) --creates the x coordinates
y3 = map(x, function(x) return  math.sin(x) * x * x * math.tanh(x) end ) --maps x values to the specified function

LineChart.init()

chart = LineChart(1, 200, 50, 400, 200) --instantiation
chart:setLineColor(0xFFCC00) --sets the line color to yellowish-orange
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:addSeries(x, y)
chart:addSeries(x1, y1)
chart:addSeries(x3, y3)
chart:show() --display the chart
print("new version")
