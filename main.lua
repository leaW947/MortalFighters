--trace consol
io.stdout:setvbuf('no')

-- pixel art
love.graphics.setDefaultFilter("nearest")

--debug
if arg[#arg] == "-debug" then require("mobdebug").start() end

math.randomseed(love.timer.getTime())

local sceneLoader=require("sceneLoader")

function love.load()
  
  love.window.setMode(1000,600)
  
  screenWidth=love.graphics.getWidth()
  screenHeight=love.graphics.getHeight()
  
  sceneLoader.load()
  sceneLoader.init("menu")

end

function love.update(dt)
  sceneLoader.update(dt)
end

function love.draw()
  sceneLoader.draw()
end

function love.keypressed(key)
  
  if key=="escape" then
    love.event.quit()
  end
  
  sceneLoader.keypressed(key)
end