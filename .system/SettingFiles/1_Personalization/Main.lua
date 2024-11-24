
local GUI = require("GUI")
local paths = require("Paths")
local system = require("System")

local module = {}

local workspace, window, localization = table.unpack({...})
local userSettings = system.getUserSettings()

--------------------------------------------------------------------------------

module.name = localization.personalization
if system.tabletmode == true then
	module.margin = 12
else
	module.margin = 20
end
module.onTouch = function()
-- 1
	if system.tabletmode == true then
	else
		window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.wallpaperWallpaper))

		local wallpaperChooser = window.contentLayout:addChild(GUI.filesystemChooser(1, 1, 36, 3, 0xE1E1E1, 0x696969, 0xD2D2D2, 0xA5A5A5, userSettings.interfaceWallpaperPath, localization.open, localization.cancel, localization.wallpaperPath, "/"))
		wallpaperChooser:setMode(GUI.IO_MODE_OPEN, GUI.IO_MODE_FILE)
		wallpaperChooser:addExtensionFilter(".pic")
		wallpaperChooser:addExtensionFilter(".lua")
		wallpaperChooser.onSubmit = function(path)
			userSettings.interfaceWallpaperPath = path
			system.updateWallpaper()
			workspace:draw()

			system.saveUserSettings()
		end

		local comboBox = window.contentLayout:addChild(GUI.comboBox(1, 1, 36, 3, 0xE1E1E1, 0x696969, 0xD2D2D2, 0xA5A5A5))
		comboBox.selectedItem = userSettings.interfaceWallpaperMode or 1
		comboBox:addItem(localization.wallpaperStretch)
		comboBox:addItem(localization.wallpaperCenter)

		local wallpaperSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.wallpaperEnabled .. ":", userSettings.interfaceWallpaperEnabled)).switch
		wallpaperSwitch.onStateChanged = function()
			userSettings.interfaceWallpaperEnabled = wallpaperSwitch.state
			system.updateWallpaper()
			workspace:draw()

			system.saveUserSettings()
		end

		window.contentLayout:addChild(GUI.textBox(1, 1, 36, 1, nil, 0xA5A5A5, {localization.wallpaperInfo}, 1, 0, 0, true, true))

		local wallpaperSlider = window.contentLayout:addChild(GUI.slider(1, 1, 36, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, 0, 100, userSettings.interfaceWallpaperBrightness * 100, false, localization.wallpaperBrightness .. ": ", "%"))
		wallpaperSlider.height = 2
		wallpaperSlider.roundValues = true
		wallpaperSlider.onValueChanged = function()
			userSettings.interfaceWallpaperBrightness = wallpaperSlider.value / 100
			system.updateWallpaper()
			workspace:draw()

			system.saveUserSettings()
		end

		comboBox.onItemSelected = function()
			userSettings.interfaceWallpaperMode = comboBox.selectedItem
			system.updateWallpaper()
			workspace:draw()

			system.saveUserSettings()
		end
	end

	-- 2

	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.appearanceFiles))

	local showExtensionSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.appearanceExtensions .. ":", userSettings.filesShowExtension)).switch
	--local showHiddenFilesSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.appearanceHidden .. ":", userSettings.filesShowHidden)).switch
	local showApplicationIconsSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.appearanceApplications .. ":", userSettings.filesShowApplicationIcon)).switch
	local transparencySwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0xFF4940, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.appearanceTransparencyEnabled .. ":", userSettings.interfaceTransparencyEnabled)).switch
	local blurSwitch = window.contentLayout:addChild(GUI.switchAndLabel(1, 1, 36, 8, 0xFF4940, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, localization.appearanceBlurEnabled .. ":", userSettings.interfaceBlurEnabled)).switch
	
	window.contentLayout:addChild(GUI.textBox(1, 1, 36, 1, nil, 0xA5A5A5, {localization.appearanceTransparencyInfo}, 1, 0, 0, true, true))

	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.appearanceColorScheme))

	local function addColorSelector(key, ...)
		local c = window.contentLayout:addChild(GUI.colorSelector(1, 1, 36, 1, userSettings[key], ...))
		c.onColorSelected = function()
			userSettings[key] = c.color

			system.updateColorScheme()
			workspace:draw()
			system.saveUserSettings()
		end
	end

	addColorSelector("interfaceColorDesktopBackground", localization.appearanceDesktopBackground)
	addColorSelector("interfaceColorMenu", localization.appearanceMenu)
	addColorSelector("interfaceColorDock", localization.appearanceDock)
	addColorSelector("interfaceColorDropDownMenuDefaultBackground", localization.appearanceDropDownDefaultBackground)
	addColorSelector("interfaceColorDropDownMenuDefaultText", localization.appearanceDropDownDefaultText)
	addColorSelector("interfaceColorDropDownMenuSeparator", localization.appearanceDropDownSeparator)

	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.appearanceSize))

	local iconWidthSlider = window.contentLayout:addChild(GUI.slider(1, 1, 36, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, 8, 16, userSettings.iconWidth, false, localization.appearanceHorizontal .. ": ", ""))
	local iconHeightSlider = window.contentLayout:addChild(GUI.slider(1, 1, 36, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, 6, 16, userSettings.iconHeight, false, localization.appearanceVertical .. ": ", ""))
	iconHeightSlider.height = 2

	window.contentLayout:addChild(GUI.text(1, 1, 0x2D2D2D, localization.appearanceSpace))

	local iconHorizontalSpaceBetweenSlider = window.contentLayout:addChild(GUI.slider(1, 1, 36, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, 0, 5, userSettings.iconHorizontalSpace, false, localization.appearanceHorizontal .. ": ", ""))
	local iconVerticalSpaceBetweenSlider = window.contentLayout:addChild(GUI.slider(1, 1, 36, 0x66DB80, 0xE1E1E1, 0xFFFFFF, 0xA5A5A5, 0, 5, userSettings.iconVerticalSpace, false, localization.appearanceVertical .. ": ", ""))
	iconVerticalSpaceBetweenSlider.height = 2

	iconHorizontalSpaceBetweenSlider.roundValues, iconVerticalSpaceBetweenSlider.roundValues = true, true
	iconWidthSlider.roundValues, iconHeightSlider.roundValues = true, true

	local function setIconProperties(width, height, horizontalSpace, verticalSpace)
		userSettings.iconWidth, userSettings.iconHeight, userSettings.iconHorizontalSpace, userSettings.iconVerticalSpace = width, height, horizontalSpace, verticalSpace
		system.saveUserSettings()
		
		system.calculateIconProperties()
		system.updateIconProperties()
	end

	iconWidthSlider.onValueChanged = function()
		setIconProperties(math.floor(iconWidthSlider.value), math.floor(iconHeightSlider.value), userSettings.iconHorizontalSpace, userSettings.iconVerticalSpace)
	end
	iconHeightSlider.onValueChanged = iconWidthSlider.onValueChanged

	iconHorizontalSpaceBetweenSlider.onValueChanged = function()
		setIconProperties(userSettings.iconWidth, userSettings.iconHeight, math.floor(iconHorizontalSpaceBetweenSlider.value), math.floor(iconVerticalSpaceBetweenSlider.value))
	end
	iconVerticalSpaceBetweenSlider.onValueChanged = iconHorizontalSpaceBetweenSlider.onValueChanged

	showExtensionSwitch.onStateChanged = function()
		userSettings.filesShowExtension = showExtensionSwitch.state
		--userSettings.filesShowHidden = showHiddenFilesSwitch.state
		userSettings.filesShowApplicationIcon = showApplicationIconsSwitch.state
		userSettings.interfaceTransparencyEnabled = transparencySwitch.state
		userSettings.interfaceBlurEnabled = blurSwitch.state
		
		system.updateColorScheme()
		system.saveUserSettings()

		computer.pushSignal("system", "updateFileList")
	end

	 showApplicationIconsSwitch.onStateChanged, transparencySwitch.onStateChanged, blurSwitch.onStateChanged = showExtensionSwitch.onStateChanged, showExtensionSwitch.onStateChanged, showExtensionSwitch.onStateChanged
	--showHiddenFilesSwitch.onStateChanged, = showExtensionSwitch.onStateChanged,
end

--------------------------------------------------------------------------------

return module

