
--- Downloads module
-- Performs http file downloads with the LuaSocket API.
-- 
-- TAP interactive RSS files are found at http://pumi-1.ida.liu.se/news/
-- 
-- Example usage:
-- download = require("lib.download")
-- download.url_to_file("http://pumi-1.ida.liu.se/news/world.xml","data/world.xml")
-- @module download
-- @author Simon Hellbe

download = {}

--- 
-- Download url to a file 
-- @param download_url The url to download
-- @param file_path The file path to write 
function download.url_to_file(download_url, file_path)
  
  log.info("Attempting to download url: "..download_url.." to file: "..file_path)
  
  -- load the http module
  local http = require("socket.http")
  local ltn12 = require("ltn12")

  -- Make a HEAD request to check if download is available 
  local response = http.request {
    method = "HEAD",
    url = download_url
  }
  print(response)
  
  -- If download was available, download to file
  if response == 1 then
    
    --Open output file to write
    local output_file = io.open(file_path,"w")
    
    http.request { 
        url = download_url,
        sink = ltn12.sink.file(output_file)
    }
  end
  
end

return download

