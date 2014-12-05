Timer = {}

function Timer:new(interval_millisec, callback)
  object = {}
  setmetatable(object,self)
  self.__index = Surface;
	self.interval = interval_millisec 
	self.callback = callback
	return self
end

function Timer:stop()
	self.cron = nil
end

function Timer:start()
	self.cron = cron.every(self.interval, self.callback)
end


function Timer:update(dt)
	self.cron:update(dt)
end

return Timer
