local sceneChoicePerso={}

local gameplayService=nil
local sceneLoader=nil

local selectPerso=1

local lstPerso={}

local portraits={}
portraits.list={}
portraits.img=nil
portraits.widthImg=0
portraits.heightImg=0

function sceneChoicePerso.load(pGameplayService,pSceneLoader)
  gameplayService=pGameplayService
  sceneLoader=pSceneLoader
  
  selectPerso=1
  gameplayService.myFighterName=""
  
  portraits.img=gameplayService.assetManager.getImage("images/portraits.png")
  portraits.list={}
  
  portraits.widthImg=portraits.img:getWidth()/8
  portraits.heightImg=portraits.img:getHeight()/16
  
  for i=1,8*16 do
    local nbCol=portraits.img:getWidth()/portraits.widthImg

    local l=math.floor(((i-1)/nbCol))+1
    local c=math.floor(i-((l-1)*nbCol))
    
    local x=(c-1)*portraits.widthImg
    local y=(l-1)*portraits.heightImg
   
    portraits.list[i]=love.graphics.newQuad(x,y,portraits.widthImg,portraits.heightImg,portraits.img:getWidth(), portraits.img:getHeight())
  end
  
  
  -----------portraits perso-------
  lstPerso={}
  
  lstPerso[1]={}
  lstPerso[1].name="Ryu"
  lstPerso[1].portrait=portraits.list[1]
  
  lstPerso[2]={}
  lstPerso[2].name="Blanka"
  lstPerso[2].portrait=portraits.list[17]
  
  lstPerso[3]={}
  lstPerso[3].name="Cammy"
  lstPerso[3].portrait=portraits.list[89]
  
  lstPerso[4]={}
  lstPerso[4].name="Chun-Li"
  lstPerso[4].portrait=portraits.list[41]
  
  lstPerso[5]={}
  lstPerso[5].name="Sagat"
  lstPerso[5].portrait=portraits.list[113]
  
  lstPerso[6]={}
  lstPerso[6].name="Vega"
  lstPerso[6].portrait=portraits.list[105]

  
end


function sceneChoicePerso.update(dt)
  
  if selectPerso<1 then
    selectPerso=#lstPerso
  end
  if selectPerso>#lstPerso then
    selectPerso=1
  end
  
end


function sceneChoicePerso.draw()
  love.graphics.setFont(gameplayService.fontGame)
  
  love.graphics.setColor(141/255,0,28/255)
  love.graphics.print("Choix du personnage",gameplayService.screenWidth/4,10,0,0.7,0.7)

  ------name myFighter is empty
  if gameplayService.myFighterName=="" then
    
    -------select perso
    love.graphics.rectangle("fill",gameplayService.screenWidth/5+(100*(selectPerso-1)),gameplayService.screenHeight/2.5,portraits.widthImg,portraits.heightImg)
    
    
    love.graphics.setColor(173/255,173/255,173/255)
    love.graphics.print("Bouton A",gameplayService.screenWidth-gameplayService.screenWidth/3.2,gameplayService.screenHeight/3-10,0,0.3,0.3)
    
    love.graphics.setColor(70/255,70/255,70/255)
    love.graphics.print(">- Bouton Entrée",10,gameplayService.screenHeight-50,0,0.25,0.25)
  end

  
  love.graphics.setColor(1,1,1)
  
  local x=gameplayService.screenWidth/5
  local y=gameplayService.screenHeight/2.5
  ---------display portraits------------
  for i=1,#lstPerso do
    
    love.graphics.draw(portraits.img,lstPerso[i].portrait,x,y)
    
    love.graphics.setColor(173/255,173/255,173/255)
    love.graphics.print(lstPerso[i].name,x+(portraits.widthImg/4),y+portraits.heightImg,0,0.2,0.2)
    
    love.graphics.setColor(1,1,1,1)
    
    x=x+100
  end
  
  -------name myFighter is not empty
  if gameplayService.myFighterName~="" then
    ------select perso
    love.graphics.setColor(0,0,0,0.5)
    love.graphics.rectangle("fill",gameplayService.screenWidth/5+(100*(selectPerso-1)),gameplayService.screenHeight/2.5,portraits.widthImg,portraits.heightImg)
    
    
    love.graphics.setColor(173/255,173/255,173/255)
    love.graphics.print("Bouton Espace",gameplayService.screenWidth-gameplayService.screenWidth/3,gameplayService.screenHeight/3-10,0,0.3,0.3)
    
    love.graphics.setColor(70/255,70/255,70/255)
    love.graphics.print("Bouton Entrée -<",gameplayService.screenWidth-170,gameplayService.screenHeight-50,0,0.25,0.25)
    
    love.graphics.setColor(1,1,1,1)
  end
  
  
end

function sceneChoicePerso.keypressed(key)
  
  if gameplayService.myFighterName=="" then
    
    if key=="right" then
      love.audio.play(gameplayService.sounds.scroll)
      selectPerso=selectPerso+1
      
    elseif key=="left" then
      love.audio.play(gameplayService.sounds.scroll)
      selectPerso=selectPerso-1
      
    elseif key=="a" then
      love.audio.play(gameplayService.sounds.click)
      gameplayService.myFighterName=lstPerso[selectPerso].name
    elseif key=="return" then
      love.audio.play(gameplayService.sounds.click)
      sceneLoader.init("menu")
    end
    
  else
    
    if key=="return" then
      love.audio.play(gameplayService.sounds.click)
      sceneLoader.init("game")
    elseif key=="space" then
      love.audio.play(gameplayService.sounds.click)
      gameplayService.myFighterName=""
    end
    
  end

  
end

return sceneChoicePerso