
--- TAP interactive
-- Simple logging module for testing and debugging
-- It uses three severity levels:
-- .info(message) - No problems, just information
-- .warning(message) - Warnings for potential problems
-- .error(message) - Fatal errors that should not occur
-- @author Simon Hellbe

log = {}

--- Writes log entries to file and console
-- @ param level The severity level
-- @ param message The log message
local function write(level,message)
  
  -- Check settings
  if not LOG_OUTPUT_CONSOLE then
    LOG_OUTPUT_CONSOLE = false
  end
  
  if not LOG_OUTPUT_FILE then
    LOG_OUTPUT_FILE = false
  end
    
  --Prepare severity level and message to be written
  if(type(message) =="table") then
    message = "got table data type"
  end
  local log_text = level..": "..message.."\n"

  -- Write the message
  if LOG_OUTPUT_FILE then 
    local file = io.open(PATH.."lib/log.txt","a+") --open file in append mode with read
    io.output(file)
    io.write(log_text)
    io.close()
    io.output(io.stdout)
  end
  
  if LOG_OUTPUT_CONSOLE then 
    io.write(log_text)
  end
end


--- 
-- Record information log message
-- @param message The log message
function log.info(message)
  write("INFO",message)
end

--- 
-- Record warning log message
-- @param message The log message
function log.warning(message)
  write("WARNING",message)
end

--- 
-- Record error log message
-- @param message The log message
function log.error(message)
  write("ERROR",message)
end

return log
