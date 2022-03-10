local GameplayService={}

GameplayService.screenWidth=0
GameplayService.screenHeight=0

GameplayService.fontGame=nil
GameplayService.fontMenu=nil

GameplayService.assetManager=nil

GameplayService.myFighterName=""
GameplayService.GUI=nil
GameplayService.sprite=nil

GameplayService.sounds={click=nil, scroll=nil}

function GameplayService.setSizeScreen(pWidth,pHeight)
  GameplayService.screenWidth=pWidth
  GameplayService.screenHeight=pHeight
end

function GameplayService.setFont(pFontGame,pFontMenu,pSizeFontGame,pSizeFontMenu)
  GameplayService.fontGame=love.graphics.newFont(pFontGame,pSizeFontGame)
  GameplayService.fontMenu=love.graphics.newFont(pFontMenu,pSizeFontMenu)
end

function GameplayService.setAssetManager(pManager)
  GameplayService.assetManager=pManager
end

function GameplayService.setGUI(pGui)
  GameplayService.GUI=pGui
end

function GameplayService.setSprite(pSprite)
  GameplayService.sprite=pSprite
end

function GameplayService.setSounds(pSoundClick,pSoundScroll)
  GameplayService.sounds.scroll=pSoundScroll
  GameplayService.sounds.click=pSoundClick
end


return GameplayService