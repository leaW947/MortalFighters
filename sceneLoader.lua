local SceneLoader={}

local sceneGame=require("sceneGame")
local sceneMenu=require("sceneMenu")
local scenePersoChoice=require("scenePersoChoice")

local GUI=require("GUI")
local sprite=require("sprite")
local assetManager=require("assetManager")
local gameplayService=require("gameplayService")

local gameState=""

function SceneLoader.load()

  
  ----------------BG-----------------------
  assetManager.addImage("images/backgrounds/BGFeiLongStage.png")
  assetManager.addImage("images/backgrounds/BGGuileStage.png")
  assetManager.addImage("images/backgrounds/BGMBisonStage.png")
  assetManager.addImage("images/backgrounds/BGRyuStage.png")
  assetManager.addImage("images/backgrounds/BGSagatStage.png")
  
  
  -----------RYU-----
  assetManager.addImage("images/characters/Ryu/idle.png")
  assetManager.addImage("images/characters/Ryu/walk.png")
  assetManager.addImage("images/characters/Ryu/punch.png")
  assetManager.addImage("images/characters/Ryu/punch2.png")
  assetManager.addImage("images/characters/Ryu/kick.png")
  assetManager.addImage("images/characters/Ryu/kick2.png")
  assetManager.addImage("images/characters/Ryu/ko.png")
  assetManager.addImage("images/characters/Ryu/faceHit.png")
  assetManager.addImage("images/characters/Ryu/victory1.png")
  assetManager.addImage("images/characters/Ryu/victory2.png")
  
  assetManager.addImage("images/characters/Ryu/imagesHits/punch.png")
  assetManager.addImage("images/characters/Ryu/imagesHits/punch2.png")
  assetManager.addImage("images/characters/Ryu/imagesHits/kick.png")
  assetManager.addImage("images/characters/Ryu/imagesHits/kick2.png")
  
  
  --------------BLANKA
  assetManager.addImage("images/characters/Blanka/idle.png")
  assetManager.addImage("images/characters/Blanka/walk.png")
  assetManager.addImage("images/characters/Blanka/punch.png")
  assetManager.addImage("images/characters/Blanka/punch2.png")
  assetManager.addImage("images/characters/Blanka/kick.png")
  assetManager.addImage("images/characters/Blanka/kick2.png")
  assetManager.addImage("images/characters/Blanka/ko.png")
  assetManager.addImage("images/characters/Blanka/faceHit.png")
  assetManager.addImage("images/characters/Blanka/victory1.png")
  assetManager.addImage("images/characters/Blanka/victory2.png")
  
  assetManager.addImage("images/characters/Blanka/imagesHits/punch.png")
  assetManager.addImage("images/characters/Blanka/imagesHits/punch2.png")
  assetManager.addImage("images/characters/Blanka/imagesHits/kick.png")
  assetManager.addImage("images/characters/Blanka/imagesHits/kick2.png")
  
  
  -------------CAMMY---------------
  assetManager.addImage("images/characters/Cammy/idle.png")
  assetManager.addImage("images/characters/Cammy/walk.png")
  assetManager.addImage("images/characters/Cammy/punch.png")
  assetManager.addImage("images/characters/Cammy/punch2.png")
  assetManager.addImage("images/characters/Cammy/kick.png")
  assetManager.addImage("images/characters/Cammy/kick2.png")
  assetManager.addImage("images/characters/Cammy/ko.png")
  assetManager.addImage("images/characters/Cammy/faceHit.png")
  assetManager.addImage("images/characters/Cammy/victory1.png")
  assetManager.addImage("images/characters/Cammy/victory2.png")
  
  assetManager.addImage("images/characters/Cammy/imagesHits/punch.png")
  assetManager.addImage("images/characters/Cammy/imagesHits/punch2.png")
  assetManager.addImage("images/characters/Cammy/imagesHits/kick.png")
  assetManager.addImage("images/characters/Cammy/imagesHits/kick2.png")
  
  
  
  
  ------------CHUN-LI---------------------
  assetManager.addImage("images/characters/Chun-Li/idle.png")
  assetManager.addImage("images/characters/Chun-Li/walk.png")
  assetManager.addImage("images/characters/Chun-Li/punch.png")
  assetManager.addImage("images/characters/Chun-Li/punch2.png")
  assetManager.addImage("images/characters/Chun-Li/kick.png")
  assetManager.addImage("images/characters/Chun-Li/kick2.png")
  assetManager.addImage("images/characters/Chun-Li/ko.png")
  assetManager.addImage("images/characters/Chun-Li/faceHit.png")
  assetManager.addImage("images/characters/Chun-Li/victory1.png")
  assetManager.addImage("images/characters/Chun-Li/victory2.png")
  
  assetManager.addImage("images/characters/Chun-Li/imagesHits/punch.png")
  assetManager.addImage("images/characters/Chun-Li/imagesHits/punch2.png")
  assetManager.addImage("images/characters/Chun-Li/imagesHits/kick.png")
  assetManager.addImage("images/characters/Chun-Li/imagesHits/kick2.png")
  
  
  ----------SAGAT-----------
  assetManager.addImage("images/characters/Sagat/idle.png")
  assetManager.addImage("images/characters/Sagat/walk.png")
  assetManager.addImage("images/characters/Sagat/punch.png")
  assetManager.addImage("images/characters/Sagat/punch2.png")
  assetManager.addImage("images/characters/Sagat/kick.png")
  assetManager.addImage("images/characters/Sagat/kick2.png")
  assetManager.addImage("images/characters/Sagat/ko.png")
  assetManager.addImage("images/characters/Sagat/faceHit.png")
  assetManager.addImage("images/characters/Sagat/victory1.png")
  assetManager.addImage("images/characters/Sagat/victory2.png")
  
  assetManager.addImage("images/characters/Sagat/imagesHits/punch.png")
  assetManager.addImage("images/characters/Sagat/imagesHits/punch2.png")
  assetManager.addImage("images/characters/Sagat/imagesHits/kick.png")
  assetManager.addImage("images/characters/Sagat/imagesHits/kick2.png")
  
  
  
  -------------------VEGA----------------------------
  assetManager.addImage("images/characters/Vega/idle.png")
  assetManager.addImage("images/characters/Vega/walk.png")
  assetManager.addImage("images/characters/Vega/punch.png")
  assetManager.addImage("images/characters/Vega/punch2.png")
  assetManager.addImage("images/characters/Vega/kick.png")
  assetManager.addImage("images/characters/Vega/kick2.png")
  assetManager.addImage("images/characters/Vega/ko.png")
  assetManager.addImage("images/characters/Vega/faceHit.png")
  assetManager.addImage("images/characters/Vega/victory1.png")
  assetManager.addImage("images/characters/Vega/victory2.png")
  
  assetManager.addImage("images/characters/Vega/imagesHits/punch.png")
  assetManager.addImage("images/characters/Vega/imagesHits/punch2.png")
  assetManager.addImage("images/characters/Vega/imagesHits/kick.png")
  assetManager.addImage("images/characters/Vega/imagesHits/kick2.png")
  
  
  --impact
  assetManager.addImage("images/impact.png")
  assetManager.addImage("images/portraits.png")
  assetManager.addImage("images/fight.png")
  
  ---------UI--------
  assetManager.addImage("images/GUI/progress_grey.png")
  assetManager.addImage("images/GUI/progress_red.png")
  
  assetManager.addImage("images/GUI/btnPlay.png")
  assetManager.addImage("images/GUI/btnPlayHover.png")
  assetManager.addImage("images/GUI/btnQuitter.png")
  assetManager.addImage("images/GUI/btnQuitterHover.png")
  
  assetManager.addImage("images/GUI/btnA.png")
  assetManager.addImage("images/GUI/ko.png")
  assetManager.addImage("images/GUI/combosPage.png")
  
  
  --sounds
  assetManager.addSound("sounds/bip.wav","sound")
  assetManager.addSound("sounds/fight.wav","sound")
  assetManager.addSound("sounds/finishRound.mp3","sound")
  assetManager.addSound("sounds/coupoing.wav","sound")
  
  assetManager.addSound("sounds/sonClique.wav","sound")
  assetManager.addSound("sounds/sonScroll.wav","sound")
  
  assetManager.addSound("musics/musicCombat.mp3","music")
  assetManager.addSound("musics/musicVictoire.mp3","music")
  

  --------gameplay service   
  gameplayService.setAssetManager(assetManager)
  gameplayService.setSizeScreen(screenWidth,screenHeight)
  
  gameplayService.setGUI(GUI)
  gameplayService.setSprite(sprite)

  gameplayService.setFont("fonts/Stranger back in the Night.ttf","fonts/Another Danger - Demo.otf",200,80)
  
  gameplayService.setSounds(gameplayService.assetManager.getSound("sounds/sonClique.wav"),gameplayService.assetManager.getSound("sounds/sonScroll.wav"))
  
end

function SceneLoader.init(pGameState)
  gameState=pGameState
  
  gameplayService.GUI.totalDelete()
  gameplayService.sprite.totalDelete()
  
  if gameState=="game" then
    sceneGame.load(gameplayService,SceneLoader)
    
  elseif gameState=="menu" then
    sceneMenu.load(gameplayService,SceneLoader)
    
  elseif gameState=="persoChoice" then
    scenePersoChoice.load(gameplayService,SceneLoader)
  end
  
end

function SceneLoader.update(dt)
  
  if gameState=="game" then
    sceneGame.update(dt)
     
  elseif gameState=="menu" then
    sceneMenu.update(dt)
  elseif gameState=="persoChoice" then
    scenePersoChoice.update(dt)
  end
  
  GUI.update(dt)
  
end


function SceneLoader.draw()
  
 
  if gameState=="game" then
    sceneGame.draw()
  elseif gameState=="menu" then
    GUI.draw()
    sceneMenu.draw()
  elseif gameState=="persoChoice" then
    GUI.draw()
    scenePersoChoice.draw()
  end
  
end

function SceneLoader.keypressed(key)
  
  if gameState=="game" then
    sceneGame.keypressed(key)
  elseif gameState=="menu" then
    sceneMenu.keypressed(key)
  elseif gameState=="persoChoice" then
    scenePersoChoice.keypressed(key)
  end
  
end

return SceneLoader