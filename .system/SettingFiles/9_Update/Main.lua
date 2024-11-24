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
local internet = require("Internet")

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


	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, "HillOS Updater"))

	local iconButton = addButton(window.contentLayout, 1, 36, "Update")
	local wallpaperSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, "Update Settings", false))
	local efiSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, "Update BIOS", false))

	local function replaceloader()
		GUI.alert("The Updater is being remade.")
	end

		window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, "Make a Backup"))
	iconButton.onTouch = function()
		replaceloader()
	end
	--space:draw()
	local iconButton2 = addButton(window.contentLayout, 1, 36, "Remove Backup")
	iconButton2.onTouch = function()
		if fs.exists("/Backup") then
			fs.remove("/Backup")
		else
			GUI.alert("No Backup Folder")
		end
	end
	local iconButton3 = addButton(window.contentLayout, 1, 36, "Restore past version")
	iconButton3.onTouch = function()
		if fs.exists("/Backup") then
			fs.remove("/.system/Libraries/")
			fs.copy("/Backup/", "/")
		else
			GUI.alert("No Backup Folder")
		end
	end

end

--------------------------------------------------------------------------------

return module

