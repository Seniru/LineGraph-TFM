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
LineChart.__joints = 10000

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
  self:setData(dataX, dataY)
  self.joints = LineChart.__joints
  LineChart.__joints = LineChart.__joints + 10000
  print(LineChart.joints)
  return self
end

function LineChart:show(target)
  --the graph plot
  ui.addTextArea(10000 + self.id, "", target, self.x, self.y, self.w, self.h, self.bg, self.border, self.alpha or 0.5, self.fixed)
  --label of the origin
  ui.addTextArea(11000 + self.id, "<b>[" .. math.floor(self.minX) .. ", "  .. math.floor(self.minY) .. "]</b>", target, self.x - 15, self.y + self.h + 5, 50, 50, nil, nil, 0, self.fixed)
  --label of the x max
  ui.addTextArea(12000 + self.id, "<b>" .. math.ceil(self.maxX) .. "</b>", target, self.x + self.w + 10, self.y + self.h + 5, 50, 50, nil, nil, 0, self.fixed)
  --label of the y max
  ui.addTextArea(13000 + self.id, "<b>" .. math.ceil(self.maxY) .. "</b>", target, self.x - 15, self.y - 10, 50, 50, nil, nil, 0, self.fixed)
  --label x median
  ui.addTextArea(14000 + self.id, "<b>" .. math.ceil((self.maxX + self.minX) / 2) .. "</b>", target, self.x + (self.w - self.x) / 2, self.y + self.h + 5, 50, 50, nil, nil, 0, self.fixed)
  --label y median
  ui.addTextArea(15000 + self.id, "<br><br><b>" .. math.ceil((self.maxY + self.minY) / 2) .. "</b>", target, self.x - 15, self.y + (self.h - self.y) / 2, 50, 50, nil, nil, 0, self.fixed)

  local joints = self.__joints
  local xRatio = self.w / self.xRange
  local yRatio = self.h / self.yRange
  for d = 1, #self.dataX, 1 do
    tfm.exec.addJoint(10000 + self.id + joints ,-1,-1,{
      type=0,
      point1= math.floor(self.dataX[d] * xRatio  + self.x - (self.minX * xRatio)) .. ",".. math.floor(invertY(self.dataY[d] * yRatio) + self.y - self.h + (self.minY * yRatio)),
      point2=  math.floor((self.dataX[d+1]  or self.dataX[d]) * xRatio + self.x - (self.minX * xRatio)) .. "," .. math.floor(invertY((self.dataY[d+1] or self.dataY[d]) * yRatio) + self.y - self.h + (self.minY * yRatio)),
      damping=0.2,
      line=self.lWidth or 3,
      color=self.lineColor or 0xFF6600,
      alpha=self.alpha or 1,
      foreground=true
    })
    joints = joints + 1
  end
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

function LineChart:resize(w, h)
  self.w = w
  self.h = h
end

function LineChart:move(x, y)
  self.x = x
  self.y = y
end

function LineChart:setData(dx, dy)
  if #dx ~= #dy then error("Ex[ected same number of data for both axis") end
  self.dataX = dx
  self.dataY = dy
  self.minX = getMin(self.dataX)
  self.minY = getMin(self.dataY)
  self.maxX = getMax(self.dataX)
  self.maxY = getMax(self.dataY)
  self.xRange = self.maxX - self.minX
  self.yRange = self.maxY - self.minY
end

function LineChart:hide(target)
  for id = 10000, 16000, 1000 do
    ui.removeTextArea(id + self.id, target)
  end
end
