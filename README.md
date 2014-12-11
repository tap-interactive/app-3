# TAP Interactive App 3 - Feedme

## Run the app on the box
1. Copy the following files to a USB stick: app.lua, lib and src
2. Insert the USB on the STB and connect according to LuaEngine instructions
3. Using a text editor on the box, change row 5 in app.lua and set the PATH variable to the app location (the path will change when the USB stick is mounted between sessions)
4. Run file app.lua according to the LuaEngine instructions

## Run the app on emulator
1. Install the LOVE (love2d.org) graphics library on your computer. Windows and Mac can use zipped executables placed in the parent folder of the app folder, and use the start scripts in the app folder.
2. If not using start script, run the app with the following command (or corresponding for Mac/Linux): love.exe c:\path\to\app-3\

## License
The source code for the application is licensed under the GPL v3 license, http://www.gnu.org/copyleft/gpl.html

External contents included in the project which are **NOT** covered by the app license:
- src/data/articles Text contents from Yahoo News (news.yahoo.com)
- src/data/rss Text contents from Yahoo News (news.yahoo.com)
- src/data/img Images from Yahoo News (news.yahoo.com)
- src/data/fonts Fonts from Google Fonts (google.com/fonts)
- test/luaunit.lua LuaUnit unit testing frameowrk (BSC License, see file)
