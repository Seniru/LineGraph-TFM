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


--class Series
local Series = {}
Series.__index = Series

setmetatable(Series, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Series.new(dx, dy, name, col)
  assert(#dx == #dy, "Expected same number of data for both axis")
  local self = setmetatable({ }, Series)
  self.name = name
  self:setData(dx, dy)
  self.col = col or math.random(0x000000, 0xFFFFFF)
  return self
end

function Series:getName() return self.name end
function Series:getDX() return self.dx end
function Series:getDY() return self.dy end
function Series:getColor() return self.col end
function Series:getMinX() return self.minX end
function Series:getMinY() return self.minY end
function Series:getMaxX() return self.maxX end
function Series:getMaxY() return self.maxY end
function Series:getDataLength() return #self.dx end
function Series:getLineWidth() return self.lWidth or 3 end

function Series:setName(name)
  self.name = name
end

function Series:setData(dx, dy)
  self.dx = dx
  self.dy = dy
  self.minX = getMin(dx)
  self.minY = getMin(dy)
  self.maxX = getMax(dx)
  self.maxY = getMax(dy)
end

function Series:setColor(col)
  self.col = col
end

function Series:setLineWidth(w)
  self.lWidth = w
end

-- class LineChart
local LineChart = {}
LineChart.__index = LineChart
LineChart._joints = 10000

setmetatable(LineChart, {
	__call = function (cls, ...)
		return cls.new(...)
	end
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
function LineChart:getGraphColor() return { bgColor = self.bg or 0x324650, borderColor = self.border or 0x212F36 } end
function LineChart:getAlpha() return self.alpha or 1 end
function LineChart:isShowing() return self.showing end
function LineChart:getDataLength()
  local count = 0
  for _, s in next, self.series do
    count = count + s:getDataLength()
  end
  return count
end
	
function LineChart:show()
    self:refresh()
    local floor, ceil = math.floor, math.ceil
	--the graph plot
	ui.addTextArea(10000 + self.id, "", nil, self.x, self.y, self.w, self.h, self.bg, self.border, self.alpha or 0.5, true)
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
		tfm.exec.addJoint(self.id + joints ,-1,-1,{
			type=0,
			point1= floor(series:getDX()[d] * xRatio  + self.x - (self.minX * xRatio)) .. ",".. floor(invertY(series:getDY()[d] * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio)),
			point2=  floor((series:getDX()[d+1]  or series:getDX()[d]) * xRatio + self.x - (self.minX * xRatio)) .. "," .. floor(invertY((series:getDY()[d+1] or series:getDY()[d]) * yRatio) + self.y - invertY(self.h) + (self.minY * yRatio)),
			damping=0.2,
			line=series:getLineWidth(),
			color=series:getColor(),
			alpha=self.alpha or 1,
			foreground=true
		})
		joints = joints + 1
	  end
  end

	self.showing = true
end


function LineChart:setGraphColor(bg, border)
	self.bg = bg
	self.border = border
end

function LineChart:setAlpha(alpha)
	self.alpha = alpha
end

function LineChart:addSeries(series)
  table.insert(self.series, series)
  self:refresh()
end

function LineChart:removeSeries(name)
  for i=1, #series do
    if self.series[i]:getName() == name then
      table.remove(self.series, i)
      break
    end
  end
  self:refresh()
end

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

  print("New call: \n minX: " .. self.minX .. "\n minY: " .. self.minY .. "\n maxX: " .. self.maxX .. "\n maxY: " .. self.maxY)
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
	for id = 10000, 17000, 1000 do
		ui.removeTextArea(id + self.id) 
	end
	for d = self.joints, self.joints + self:getDataLength(), 1 do
		tfm.exec.removeJoint(d)
	end
	self.showing = false
end

--[[function LineChart:showLabels(show)
  local labels = ""
  for _, series in next, self.series do
    lables = labels .. "<font color='#" .. 
  end
  ui.addTextArea(16000 + self.id, )
end]]

x1 = range(-5, 5, 1)
y1 = map(x1, function(x) return math.tan(x) end)
LineChart.init()
series1 = Series(x1, x1, "s1")
chart = LineChart(1, 200, 50, 400, 200) --instantiation
chart:setGraphColor(0xFFFFFF, 0xFFFFFF) --sets graph color to white
chart:addSeries(series1)
chart:show()
i = -5
function eventLoop(tr, ti)
  i = i + 1
  local x = range(i, i+10, 0.5)
  local y = map(x, function(x) return math.tan(x) end)
  series1:setData(x, y)
  --chart:refresh()
  chart:show()

end

