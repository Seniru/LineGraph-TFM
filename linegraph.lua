tfm.exec.addPhysicObject(-1,400,-600,{type=0,width=10,height=10,foregfloor=true,friction=0.3,restitution=0,dynamic=false,miceCollision=true,gfloorCollision=true})

function getMin(tbl)
  local min = tbl[1]
  for k, v in ipairs(tbl) do
    if v < min then
      min = v
    end
  end
  return min
end

function getMax(tbl)
  local max = tbl[1]
  for k, v in ipairs(tbl) do
    if v > max then
      max = v
    end
  end
  return max
end

function map(tbl, f)
  local res = {}
  for k, v in pairs(tbl) do
    res[k] = f(v)
  end
  return res
end

function invertY(y)
  return 400 - y
end

local LineChart = {}
LineChart.__index = LineChart

setmetatable(LineChart, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function LineChart.new(id, x, y, w, h, dataX, dataY)
  local self = setmetatable({}, LineChart)
  self.id = id
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.dataX = dataX
  self.dataY = dataY
  self.minX = getMin(dataX)
  self.minY = getMin(self.dataY)
  self.maxX = getMax(dataX)
  self.maxY = getMax(dataY)
  self.xRange = self.maxX - self.minX
  self.yRange = self.maxY - self.minY
  return self
end

function LineChart:show(target)
  ui.addTextArea(10000 + self.id, "", target, self.x, self.y, self.w, self.h, nil, nil, 0.5, true)
  local joints = 1
  local xRatio = self.w / self.xRange
  local yRatio = self.h / self.yRange
  for d = 1, #self.dataX, 1 do
    tfm.exec.addJoint(10000 + joints ,-1,-1,{
      type=0,
      point1= math.floor(self.dataX[d] * xRatio  + self.x - (self.minX * xRatio)) .. ",".. math.floor(invertY(self.dataY[d] * yRatio) + self.y - self.h + (self.minY * yRatio)),
      point2=  math.floor((self.dataX[d+1]  or self.dataX[d]) * xRatio + self.x - (self.minX * xRatio)) .. "," .. math.floor(invertY((self.dataY[d+1] or self.dataY[d]) * yRatio) + self.y - self.h + (self.minY * yRatio)),
      damping=0.2,
      line=3,
      color=0xFF6600,
      alpha=1,
      foreground=true
    })
    joints = joints + 1
  end
end

function f(n)
  return math.sin(n)
end

local x = {-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5}
local y = map(x, f)

local chart = LineChart(1, 50, 50, 600, 200, x, y)
chart:show()
