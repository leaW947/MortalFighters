local AssetManager={}

AssetManager.listImages={}
AssetManager.listSounds={}

function AssetManager.addImage(pPath)
  local myImage=love.graphics.newImage(pPath)
  
  AssetManager.listImages[pPath]=myImage
end

function AssetManager.addSound(pPath,pType)
  local mySound
  
  if pType=="sound" then
    mySound=love.audio.newSource(pPath,"static")
  elseif pType=="music" then
    mySound=love.audio.newSource(pPath,"stream")
  end
  
  AssetManager.listSounds[pPath]=mySound
end

function AssetManager.getImage(pPath)
  return AssetManager.listImages[pPath]
end

function AssetManager.getSound(pPath)
  return AssetManager.listSounds[pPath]
end

return AssetManager