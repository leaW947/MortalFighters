local Sprite={}

Sprite.list={}

function Sprite.init(pImg,pX,pY)
  local mySprite={}
  
  mySprite.image=pImg
  
  mySprite.x=pX
  mySprite.y=pY
  
  mySprite.timerFrame=0
  
  mySprite.bIsTilesheet=false
  
  mySprite.tileSize={x=0,y=0}
  mySprite.scale={x=1,y=1}
  mySprite.lstAnimations={}
  
  mySprite.currentAnimation=nil
  mySprite.currentFrame=1
  mySprite.currentFrameInAnimation=0
  
  mySprite.offsetX=1
  
  function mySprite.setScale(pX,pY)
    mySprite.scale.x=pX
    mySprite.scale.y=pY
  end
  
  function mySprite.addAnimation(pName,pImage,pWframe,pHframe,pLstFrames,pSpeed,pbLoop)
    
    local lstImages={}
    local image
    
    if pImage~=nil then
      image=pImage
      
    else
      image=mySprite.image
    end
   
    local wFrame=pWframe
    local hFrame=pHframe
        
    mySprite.bIsTilesheet=true
    
    for i=1,#pLstFrames do
      
      local nFrame=pLstFrames[i]
      
      local nbCol=math.floor(image:getWidth()/wFrame)
      
      local l=math.floor((nFrame-1)/nbCol)+1
      local c=math.floor(nFrame-((l-1)*nbCol))
      
      local x=(c-1)*wFrame
      local y=(l-1)*hFrame
      
      lstImages[nFrame]=love.graphics.newQuad(x,y,wFrame,hFrame,
        image:getWidth(),image:getHeight())
      
    end
    
    local animation={
      name=pName,
      lstFrames=pLstFrames,
      speed=pSpeed,
      image=image,
      lstImages=lstImages,
      wFrame=wFrame,
      hFrame=hFrame,
      bIsFinish=false,
      bLoop=pbLoop
    }
    
    table.insert(mySprite.lstAnimations,animation)
  end
  
  function mySprite.startAnimation(pName)
    
    if mySprite.currentAnimation~=nil then
      if mySprite.currentAnimation.name==pName then
        return
      end
    end
    
    for i=1,#mySprite.lstAnimations do
      local animation=mySprite.lstAnimations[i]
      
      if animation.name==pName then
        
        mySprite.currentAnimation=animation
        mySprite.currentFrameInAnimation=1
        mySprite.currentFrame=mySprite.currentAnimation.lstFrames[mySprite.currentFrameInAnimation]
        mySprite.currentAnimation.bIsFinish=false
        
      end
    end
  end
  
  function mySprite.draw()
    
    if not mySprite.bIsTilesheet then
      love.graphics.draw(mySprite.image,mySprite.x,mySprite.y,0,mySprite.scale.x*mySprite.offsetX,mySprite.scale.y)
    else
      
      local image=mySprite.currentAnimation.lstImages[mySprite.currentFrame]
      
      love.graphics.draw(mySprite.currentAnimation.image,image,mySprite.x,mySprite.y,0,
        mySprite.scale.x*mySprite.offsetX,mySprite.scale.y,mySprite.currentAnimation.wFrame/2,mySprite.currentAnimation.hFrame/2)
    end
    
  end
  
  table.insert(Sprite.list,mySprite)
  
  return mySprite
end

function Sprite.totalDelete()
  for i=#Sprite.list,1,-1 do
    local sprite=Sprite.list[i]
    
    table.remove(Sprite.list,i)
  end
end

function Sprite.update(dt)
  
  for i=1,#Sprite.list do
    local sprite=Sprite.list[i]
    
    if sprite.currentAnimation~=nil then
      sprite.timerFrame=sprite.timerFrame+dt
      
      if sprite.timerFrame>=sprite.currentAnimation.speed then
        sprite.timerFrame=0
        sprite.currentFrameInAnimation=sprite.currentFrameInAnimation+1
        
        if sprite.currentFrameInAnimation>#sprite.currentAnimation.lstFrames then
          
          if sprite.currentAnimation.bLoop then
            sprite.currentFrameInAnimation=1
          else
            sprite.currentFrameInAnimation=#sprite.currentAnimation.lstFrames
            sprite.currentAnimation.bIsFinish=true
          end
        end
        
        sprite.currentFrame=sprite.currentAnimation.lstFrames[sprite.currentFrameInAnimation]
      
      end
    
    end
  
  end
  
end

return Sprite