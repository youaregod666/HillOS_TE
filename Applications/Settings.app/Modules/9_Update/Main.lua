
local GUI = require("GUI")
local text = require("Text")
local filesystem = require("Filesystem")
local paths = require("Paths")
local system = require("System")
local fs = require("Filesystem")
local image = require("Image")
local SHA = require("SHA-256")
local component = require("Component")
local EFI = component.eeprom
local internet = require("internet")

local module = {}

local workspace, window, localization = table.unpack({...})
local userSettings = system.getUserSettings()

--------------------------------------------------------------------------------

module.name = "Update"
module.margin = 3
module.onTouch = function()

    local function addButton(parent, x, width, ...)
        local button = parent:addChild(GUI.button(x, 1, width, 3, 0xE1E1E1, 0x696969, 0x696969, 0xE1E1E1, ...))
        button.colors.disabled = {
            background = 0xE1E1E1,
            text = 0xB4B4B4
        }

        return button
    end

    local function flashEFI(url)
        internet.download(url, "/tempEFI.lua")
        EFI.set(fs.read("/tempEFI.lua"))
        EFI.setLabel("IMineOS BIOS")
        fs.remove("/tempEFI.lua")
    end

    local ss = window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, "Update IMineOS"))
    --ss()
    local iconButton = addButton(window.contentLayout, 1, 36, "Update")
    local wallpaperSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, "Update Settings and Finder", false))
    local efiSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, "Update BIOS", false))
    local function checkLicense()

    end
    local function replaceloader()
        --internet.download(url, text)


        if fs.exists("/Backup") then
            fs.remove("/Backup")
            fs.makeDirectory("/Backup")
        else
            fs.makeDirectory("/Backup")
        end
        --ss.text = "Downloading and installing update"
        --wait(0.1)
        --if fs.exists("/.com.IMineOS.EFI") then
        --	fs.copy("/.com.IMineOS.EFI/", "/Backup/.com.IMineOS.EFI/")
        --	fs.remove("/.com.IMineOS.EFI")
        --elseif fs.exists("/OS.lua") then
        --	fs.copy("/OS.lua", "/Backup/OS.lua")
        --	fs.remove("/OS.lua")
        --end
        --fs.copy("/.com.IMineOS.EFI/", "/Backup/EFI-OLD/")
        ss.text = "Backing Up"
        fs.copy("/Libraries/", "/Backup/Libraries/")
        fs.remove("/Libraries/")
        fs.makeDirectory("/Libraries")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/BigLetters.lua", "/Libraries/BigLetters.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Bit32.lua", "/Libraries/Bit32.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Color.lua", "/Libraries/Color.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Component.lua", "/Libraries/Component.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Compressor.lua", "/Libraries/Compressor.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Event.lua", "/Libraries/Event.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Filesystem.lua", "/Libraries/Filesystem.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/GUI.lua", "/Libraries/GUI.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Image.lua", "/Libraries/Image.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Internet.lua", "/Libraries/Internet.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/JSON.lua", "/Libraries/JSON.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Keyboard.lua", "/Libraries/Keyboard.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Network.lua", "/Libraries/Network.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Number.lua", "/Libraries/Number.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Paths.lua", "/Libraries/Paths.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/SHA-256.lua", "/Libraries/SHA-256.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Screen.lua", "/Libraries/Screen.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/System.lua", "/Libraries/System.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Text.lua", "/Libraries/Text.lua")
        internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Vector.lua", "/Libraries/Vector.lua")
        if fs.exists("/Libraries/MeowEngine") then
            if fs.exists("/Libraries/OpenComputersGL") then
                internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/MeowEngine/Main.lua", "/Libraries/MeowEngine/Main.lua")
                internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/OpenComputersGL/Main.lua", "/Libraries/OpenComputersGL/Main.lua")
                internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/OpenComputersGL/Materials.lua", "/Libraries/OpenComputersGL/Materials.lua")
                internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/OpenComputersGL/Renderer.lua", "/Libraries/OpenComputersGL/Renderer.lua")
            end
        end
        if	wallpaperSwitch.switch.state == true then
            --internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Libraries/Vector.lua", "/f.lua")
            --end
            --if wallpaperSwitch.Switchstat == true then
            fs.makeDirectory("/Backup/Applications")
            fs.copy("/Applications/Finder.app", "/Backup/Applications/Finder.app")
            fs.copy("/Applications/Settings.app", "/Backup/Applications/Settings.app")
            internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Applications/Finder.app/Main.lua", "/Applications/Finder.app/Main.lua")
            internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Applications/Finder.app/Icon.pic", "/Applications/Finder.app/Icon.pic")
            --internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/https://github.com/youaregod666/IMineOS_TE/tree/main/Applications/Settings.app/Main.lua", "/Applications/Settings.app/Main.lua")
            internet.download("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/Applications/Settings.app/Icon.pic", "/Applications/Settings.app/Icon.pic")



        end
        if	efiSwitch.switch.state == true then
            flashEFI("https://raw.githubusercontent.com/youaregod666/IMineOS_TE/master/EFI/Minified.lua")
        end
        --fs.remove("/Libraries/" .. text .. ".lua")
        --fs.rename("/Libraries/" .. text ..".lua", "/OS.lua")

        computer.shutdown(true)
    end

    window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, "Backup"))
    iconButton.onTouch = function()
        replaceloader()
    end
    --space:draw()
    local iconButton2 = addButton(window.contentLayout, 1, 36, "Delete Old Version")
    iconButton2.onTouch = function()
        if fs.exists("/Backup") then
            fs.remove("/Backup")
        else
            GUI.alert("No Backup Folder")
        end
    end
    local iconButton3 = addButton(window.contentLayout, 1, 36, "Install Backup Files")
    iconButton3.onTouch = function()
        if fs.exists("/Backup") then
            fs.remove("/Libraries/")
            fs.copy("/Backup/", "/")
        else
            GUI.alert("No Backup Folder")
        end
    end




    --fs.remove("/Libraries/" .. text .. ".lua")
    --fs.rename("/Libraries/" .. text ..".lua", "/OS.lua")
end
--------------------------------------------------------------------------------

return module
