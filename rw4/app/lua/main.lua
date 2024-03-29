local lvgl = require("lvgl")
local dataman = require("dataman")

require "image"
require "root"

local function createCounterWidget(root, imgName, pos, buttonLeft, buttonRight)
    local counterValue = 0
    local totalImages = 9 -- Total number of images in the counter set
    
    local watchface = {}
    watchface.counter = Image(root, imgName .. "_0.png", pos.counter)
    watchface.buttonLeft = Image(root, buttonLeft, pos.buttonL)
    watchface.buttonRight = Image(root, buttonRight, pos.buttonR)
    
    watchface.buttonLeft.widget:add_flag(lvgl.FLAG.CLICKABLE)
    watchface.buttonLeft.widget:onevent(lvgl.EVENT.PRESSED, function(obj, code)
        counterValue = counterValue - 1
        if counterValue < 0 then
            counterValue = totalImages - 1
        end
        local src = string.format("%s_%d.png", imgName, counterValue)
        watchface.counter.widget:set { src = imgPath(src) }
    end)
    
    watchface.buttonRight.widget:add_flag(lvgl.FLAG.CLICKABLE)
    watchface.buttonRight.widget:onevent(lvgl.EVENT.PRESSED, function(obj, code)
        counterValue = counterValue + 1
        if counterValue >= totalImages then
            counterValue = 0
        end
        local src = string.format("%s_%d.png", imgName, counterValue)
        watchface.counter.widget:set { src = imgPath(src) }
    end)
end

local function root()
    local root = createRoot()
    
    local function createEntry(imgName, pos, buttonLeft, buttonRight)
        createCounterWidget(root, imgName, pos, buttonLeft, buttonRight)
    end
    
    local itemsPosition = {
        entry1 = {
            counter = { 0, 0 },
            buttonR = { 260, 383 },
            buttonL = { 0, 383 },
        },
        entry2 = {
            counter = { 0, 21 },
            buttonR = { 260, 200 },
            buttonL = { 0, 200 },
        }
    }
    
    createEntry("num", itemsPosition.entry1, "buttonL.png", "buttonR.png")
    createEntry("chak", itemsPosition.entry2, "buttonL_alt.png", "buttonR_alt.png")
end

root()