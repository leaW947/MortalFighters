local GUI={}

GUI.list={}

function GUI.newButton(pX,pY)
  local myButton={}
  
  myButton.x=pX
  myButton.y=pY
  
  myButton.width=0
  myButton.height=0
  
  myButton.bIsSelect=false
  myButton.bIsPressed=false
  
  myButton.imgPressed=nil
  myButton.imgSelect=nil
  myButton.imgNormal=nil
  
  function myButton.setImages(pImgNormal,pImgSelect,pImgPressed)
    myButton.imgNormal=pImgNormal
    myButton.imgSelect=pImgSelect
    myButton.imgPressed=pImgPressed
    
    myButton.width=myButton.imgNormal:getWidth()
    myButton.height=myButton.imgNormal:getHeight()
  end
  
  function myButton.update(dt)
  end

  function myButton.draw()
    
    if not myButton.bIsSelect and not myButton.bIsPressed then
      love.graphics.draw(myButton.imgNormal,myButton.x,myButton.y)
      
    elseif myButton.bIsSelect and not myButton.bIsPressed then
      love.graphics.draw(myButton.imgSelect,myButton.x,myButton.y)
      
    elseif not myButton.bIsSelect and myButton.bIsPressed then
       love.graphics.draw(myButton.imgPressed,myButton.x,myButton.y)
    end
    
  end
  
  table.insert(GUI.list,myButton)
  return myButton
end

function GUI.newProgressBar(pImg,pImgProgress,pX,pY,pValue,pMaxValue,pOffsetX)
  local myProgressBar={}
  
  myProgressBar.x=pX
  myProgressBar.y=pY
  
  myProgressBar.img=pImg
  myProgressBar.imgProgress=pImgProgress
  
  myProgressBar.maxValue=pMaxValue
  myProgressBar.value=pValue
  
  myProgressBar.scaleX=1
  myProgressBar.scaleY=1
  
  myProgressBar.coef=0
  
  local offsetX=pOffsetX
  
  function myProgressBar.setScale(pScaleX,pScaleY)
    myProgressBar.scaleX=pScaleX
    myProgressBar.scaleY=pScaleY
  end
  
  function myProgressBar.setValue(pValue)
    myProgressBar.coef=pValue/myProgressBar.maxValue
  end
  
  function myProgressBar.update(dt)
    
  end
  
  function myProgressBar.draw()
    love.graphics.draw(myProgressBar.img,myProgressBar.x,myProgressBar.y,0,myProgressBar.scaleX*offsetX,myProgressBar.scaleY)
    love.graphics.draw(myProgressBar.imgProgress,myProgressBar.x,myProgressBar.y,0,(myProgressBar.scaleX*myProgressBar.coef)*offsetX,myProgressBar.scaleY)
  end
  
  table.insert(GUI.list,myProgressBar)
  
  return myProgressBar
end

function GUI.totalDelete()
  
  for i=#GUI.list,1,-1 do
    table.remove(GUI.list,i)
  end
  
end

function GUI.update(dt)

  for k,v in pairs(GUI.list) do
    v.update(dt)
  end
  
end


function GUI.draw()
  
  for k,v in pairs(GUI.list) do
    v.draw()
  end
  
end



return GUI