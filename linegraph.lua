
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.newGame(7403725)

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
  print(self.dataY[1])
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
  for d = 1, #self.dataX, 1 do
    --local x1 = 
    tfm.exec.addJoint(10000 + joints ,-1,-1,{
      type=0,
      point1= math.floor(self.dataX[d] * self.w / self.xRange  - (self.minX )) .. ",".. math.floor(invertY(self.dataY[d] * self.h / self.yRange) - self.minY),
      point2=  math.floor((self.dataX[d+1]  or self.dataX[d]) * self.w / self.xRange - (self.minX)) .. "," .. math.floor(invertY((self.dataY[d+1] or self.dataY[d]) * self.h / self.yRange) - self.minY),
      print(((self.dataY[d+1] or self.dataY[d])) * self.h / self.yRange),      frequency=10,
      damping=0.2,
      line=3,
      color=0xFF6600,
      alpha=1,
      foreground=true
    })
    joints = joints + 1
  end
end

local chart = LineChart(1, 50, 50, 600, 200, {100, 200, 300, 400, 500}, {100, 200, 300, 400, 500})
chart:show()
print()
