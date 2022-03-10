local SceneMenu={}

local gameplayService=nil
local sceneLoader=nil

local lstBtn={}

local btnSelect=1

function SceneMenu.load(pGameplayService,pSceneLoader)
  gameplayService=pGameplayService
  sceneLoader=pSceneLoader
  
  gameplayService.fighterName=""
  ---button play--------
  lstBtn[1]=gameplayService.GUI.newButton(gameplayService.screenWidth/2,gameplayService.screenHeight/2)
  
  lstBtn[1].setImages(gameplayService.assetManager.getImage("images/GUI/btnPlay.png"),gameplayService.assetManager.getImage("images/GUI/btnPlayHover.png"),gameplayService.assetManager.getImage("images/GUI/btnPlayHover.png"))
  
  
  -------button quit
  lstBtn[2]=gameplayService.GUI.newButton(gameplayService.screenWidth/2,gameplayService.screenHeight/2+lstBtn[1].height)
  
  lstBtn[2].setImages(gameplayService.assetManager.getImage("images/GUI/btnQuitter.png"),gameplayService.assetManager.getImage("images/GUI/btnQuitterHover.png"),gameplayService.assetManager.getImage("images/GUI/btnQuitterHover.png"))
  
end


function SceneMenu.update(dt)
  
  -----limit btnSelect-------
  if btnSelect>=#lstBtn then
    btnSelect=#lstBtn
  
  elseif btnSelect<=1 then
    btnSelect=1
  end
  
  
  for i=1,#lstBtn do
    
    if btnSelect==i then
      
      lstBtn[btnSelect].bIsSelect=true
    else
      lstBtn[i].bIsSelect=false
    end
  end
  
end


function SceneMenu.draw()
  love.graphics.setFont(gameplayService.fontMenu)
  
  love.graphics.setColor(141/255,0,28/255)
  love.graphics.print("Mortal  Fighters",gameplayService.screenWidth/4,50,0)
  
  love.graphics.setColor(70/255,70/255,70/255)
  love.graphics.setFont(gameplayService.fontGame)
  love.graphics.print("Bouton Entrée -<",gameplayService.screenWidth-170,gameplayService.screenHeight-50,0,0.25,0.25)
  
  love.graphics.setColor(1,1,1)
end

function SceneMenu.keypressed(key)
  
  if key=="up" then
    love.audio.play(gameplayService.sounds.scroll)
    btnSelect=btnSelect-1
    
  elseif key=="down" then
    love.audio.play(gameplayService.sounds.scroll)
    btnSelect=btnSelect+1
  end
  
  
  if key=="return" then
    
    love.audio.play(gameplayService.sounds.click)
    
    if btnSelect==1 then
      sceneLoader.init("persoChoice")
    elseif btnSelect==2 then
      love.event.quit()
    end
  
  end

end

return SceneMenu