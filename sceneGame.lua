local SceneGame={}

local assetManager=nil
local gameplayService=nil
local sceneLoader=nil

local GUI=require("GUI")
local AIFighter=require("AIFighter")

local lstFighters={}

local speedTimer=3
local timerGame=speedTimer

local camera={}
camera.x=0

local btnA={}
btnA.bIsClick=false
btnA.imgPage=nil
btnA.sprite=nil

local ko={}
ko.sprite=nil

local bStartRound=false
local soundHit=nil

local round={}
round.speed=1.3
round.timer=round.speed
round.currentNum=0
round.count=3
round.bFinishAnim=false
round.bOnFight=false
round.imgFight=nil
round.winner=""
round.loser=""
round.winnerGame=""
round.soundBip=nil
round.soundFight=nil
round.soundEnd=nil
round.music=nil
round.musicVictory=nil


local sequence=""
local previousKey=""

local resetSpeed=0.5
local resetTimer=resetSpeed

ActionsList={}
ActionsList["z"]="-Z"
ActionsList["s"]="-S"
ActionsList["d"]="-D"
--ActionsList["z-d"]="-ZD"
--ActionsList["s-d"]="-SD"


local myFighter={}

myFighter.lives=0
myFighter.nbVictory=0
myFighter.progressBar=nil
myFighter.name=""

myFighter.sprite=nil
myFighter.lstImagesHits={}
myFighter.lstHitCollide={}
myFighter.lstBodyCollide={}

myFighter.lstAnimations={}

myFighter.lstAnimations[1]={}
myFighter.lstAnimations[1].name="punch"
myFighter.lstAnimations[1].sequence="-Z-D-D"

myFighter.lstAnimations[2]={}
myFighter.lstAnimations[2].name="punch2"
myFighter.lstAnimations[2].sequence="-S-D-D"

myFighter.lstAnimations[3]={}
myFighter.lstAnimations[3].name="kick"
myFighter.lstAnimations[3].sequence="-Z-D-S"

myFighter.lstAnimations[4]={}
myFighter.lstAnimations[4].name="kick2"
myFighter.lstAnimations[4].sequence="-S-D-Z"

myFighter.bHit=false
myFighter.bIsFalse3DPos=false



local myOpponent={}
myOpponent.lives=0
myOpponent.nbVictory=0
myOpponent.name=""
myOpponent.progressBar=nil

myOpponent.sprite=nil
myOpponent.lstHitCollide={}
myFighter.lstBodyCollide={}

myOpponent.bHit=false

local impact=nil
local imgBG
local lstBackgrounds={}

function checkCollision(pX1,pY1,pW1,pH1,pX2,pY2,pW2,pH2)

  if pX1+pW1>=pX2 and pX1<=pX2+pW2 and 
      pY1+pH1>=pY2 and pY1<=pY2+pH2 then
        
    return true
  else
    return false
  end
end

function initBackgrounds()
  lstBackgrounds={}
  
  lstBackgrounds[1]="images/backgrounds/BGFeiLongStage.png"
  lstBackgrounds[2]="images/backgrounds/BGGuileStage.png"
  lstBackgrounds[3]="images/backgrounds/BGRyuStage.png"
  lstBackgrounds[4]="images/backgrounds/BGMBisonStage.png"
  lstBackgrounds[5]="images/backgrounds/BGSagatStage.png"
end

function rndBackground()
  local indexBG=math.floor(math.random(1,#lstBackgrounds))
  
  return indexBG
end

function initFighters()
  
  
local myFighter={}
  
  myFighter={}
  myFighter.lives=0
  myFighter.nbVictory=0
  myFighter.progressBar=nil
  myFighter.name=""

  myFighter.sprite=nil
  myFighter.lstImagesHits={}
  myFighter.lstHitCollide={}
  myFighter.lstBodyCollide={}

  myFighter.bHit=false
  myFighter.bIsFalse3DPos=false


  myOpponent={}
  myOpponent.lives=0
  myOpponent.nbVictory=0
  myOpponent.name=""
  myOpponent.progressBar=nil

  myOpponent.sprite=nil
  myOpponent.lstHitCollide={}
  myFighter.lstBodyCollide={}

  myOpponent.bHit=false
  
  
  lstFighters={}
  
  --------------Ryu------------
  lstFighters[1]={}
  lstFighters[1].name="Ryu"
  
  lstFighters[1].scale=4
  
  lstFighters[1].lstImagesHits={}
  lstFighters[1].lstImagesHits[1]="images/characters/Ryu/imagesHits/punch.png"
  lstFighters[1].lstImagesHits[2]="images/characters/Ryu/imagesHits/punch2.png"
  lstFighters[1].lstImagesHits[3]="images/characters/Ryu/imagesHits/kick.png"
  lstFighters[1].lstImagesHits[4]="images/characters/Ryu/imagesHits/kick2.png"

  lstFighters[1].lstAnimations={}

  lstFighters[1].lstAnimations[1]={name="idle",stringImg="images/characters/Ryu/idle.png",wFrame=43,hFrame=82,lstFrames={1,2,3,4},speed=0.2,bLoop=true}

  lstFighters[1].lstAnimations[2]={name="walk",stringImg="images/characters/Ryu/walk.png",wFrame=43,hFrame=81,lstFrames={1,2,3,4,5},speed=0.1,bLoop=true}

  lstFighters[1].lstAnimations[3]={name="punch",stringImg="images/characters/Ryu/punch.png",wFrame=72,hFrame=85,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}

  lstFighters[1].lstAnimations[4]={name="punch2",stringImg="images/characters/Ryu/punch2.png",wFrame=57,hFrame=81,lstFrames={1,2,3},speed=0.1,bLoop=false}

  lstFighters[1].lstAnimations[5]={name="kick",stringImg="images/characters/Ryu/kick.png",wFrame=67,hFrame=87,lstFrames={1,2,3},speed=0.1,bLoop=false}

  lstFighters[1].lstAnimations[6]={name="kick2",stringImg="images/characters/Ryu/kick2.png",wFrame=69,hFrame=84,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}

  lstFighters[1].lstAnimations[7]={name="ko",stringImg="images/characters/Ryu/ko.png",wFrame=74,hFrame=59,lstFrames={1,2,3},speed=0.2,bLoop=false}

  lstFighters[1].lstAnimations[8]={name="victory1",stringImg="images/characters/Ryu/victory1.png",wFrame=43,hFrame=107,lstFrames={1,2,3},speed=0.2,bLoop=false}

  lstFighters[1].lstAnimations[9]={name="victory2",stringImg="images/characters/Ryu/victory2.png",wFrame=43,hFrame=87,lstFrames={1,2,3,4,5,6,7},speed=0.2,bLoop=false}

  lstFighters[1].lstAnimations[10]={name="faceHit",stringImg="images/characters/Ryu/faceHit.png",wFrame=58,hFrame=83,lstFrames={1,2,3,4},speed=0.1,bLoop=false}


  lstFighters[1].lstHitCollide={}
  lstFighters[1].lstHitCollide["punch"]={x=62,y=13,w=10,h=10}
  lstFighters[1].lstHitCollide["punc2"]={x=47,y=13,w=10,h=10}
  lstFighters[1].lstHitCollide["kick"]={x=55,y=0,w=12,h=12}
  lstFighters[1].lstHitCollide["kick2"]={x=59,y=0,w=10,h=13}

  lstFighters[1].lstBodyCollide={}
  lstFighters[1].lstBodyCollide["idle"]={x=3,y=0,w=35,h=80}
  lstFighters[1].lstBodyCollide["walk"]={x=6,y=1,w=31,h=79}
  lstFighters[1].lstBodyCollide["punch"]={x=4,y=2,w=35,h=81}
  lstFighters[1].lstBodyCollide["punch2"]={x=0,y=0,w=35,h=79}
  lstFighters[1].lstBodyCollide["kick"]={x=0,y=2,w=39,h=81}
  lstFighters[1].lstBodyCollide["kick2"]={x=0,y=9,w=34,h=73}
  
  lstFighters[1].lstBodyCollide["faceHit"]={x=2,y=1,w=35,h=79}



  ----------------Blanka-----------------
  lstFighters[2]={}
  lstFighters[2].name="Blanka"
  
  lstFighters[2].scale=4
  
  lstFighters[2].lstImagesHits={}
  lstFighters[2].lstImagesHits[1]="images/characters/Blanka/imagesHits/punch.png"
  lstFighters[2].lstImagesHits[2]="images/characters/Blanka/imagesHits/punch2.png"
  lstFighters[2].lstImagesHits[3]="images/characters/Blanka/imagesHits/kick.png"
  lstFighters[2].lstImagesHits[4]="images/characters/Blanka/imagesHits/kick2.png"

  lstFighters[2].lstAnimations={}
  lstFighters[2].lstAnimations[1]={name="idle",stringImg="images/characters/Blanka/idle.png",wFrame=64,hFrame=88,lstFrames={1,2,3,4},speed=0.2,bLoop=true}
  lstFighters[2].lstAnimations[2]={name="walk",stringImg="images/characters/Blanka/walk.png",wFrame=64,hFrame=88,lstFrames={1,2,3,4,5},speed=0.1,bLoop=true}

  lstFighters[2].lstAnimations[3]={name="punch",stringImg="images/characters/Blanka/punch.png",wFrame=87,hFrame=87,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[2].lstAnimations[4]={name="punch2",stringImg="images/characters/Blanka/punch2.png",wFrame=89,hFrame=91,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[2].lstAnimations[5]={name="kick",stringImg="images/characters/Blanka/kick.png",wFrame=93,hFrame=89,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[2].lstAnimations[6]={name="kick2",stringImg="images/characters/Blanka/kick2.png",wFrame=89,hFrame=82,lstFrames={1,2,3},speed=0.1,bLoop=false}

  lstFighters[2].lstAnimations[7]={name="ko",stringImg="images/characters/Blanka/ko.png",wFrame=105,hFrame=76,lstFrames={1,2,3,5},speed=0.2,bLoop=false}
  lstFighters[2].lstAnimations[8]={name="victory1",stringImg="images/characters/Blanka/victory1.png",wFrame=68,hFrame=133,lstFrames={1,2,3,4,5},speed=0.2,bLoop=false}
  lstFighters[2].lstAnimations[9]={name="victory2",stringImg="images/characters/Blanka/victory2.png",wFrame=80,hFrame=106,lstFrames={1,2,3,4,5,6,7,8,9,10},speed=0.2,bLoop=false}

  lstFighters[2].lstAnimations[10]={name="faceHit",stringImg="images/characters/Blanka/faceHit.png",wFrame=79,hFrame=88,lstFrames={4,3},speed=0.1,bLoop=false}

  lstFighters[2].lstHitCollide={}
  lstFighters[2].lstHitCollide["punch"]={x=72,y=22,w=15,h=11}
  lstFighters[2].lstHitCollide["punch2"]={x=74,y=34,w=15,h=12}
  lstFighters[2].lstHitCollide["kick"]={x=73,y=1,w=13,h=15}
  lstFighters[2].lstHitCollide["kick2"]={x=76,y=20,w=13,h=16}

  lstFighters[2].lstBodyCollide={}
  lstFighters[2].lstBodyCollide["idle"]={x=7,y=0,w=49,h=87}
  lstFighters[2].lstBodyCollide["walk"]={x=12,y=15,w=52,h=72}
  lstFighters[2].lstBodyCollide["punch"]={x=7,y=0,w=48,h=86}
  lstFighters[2].lstBodyCollide["punch2"]={x=8,y=3,w=55,h=87}
  lstFighters[2].lstBodyCollide["kick"]={x=11,y=2,w=44,h=86}
  lstFighters[2].lstBodyCollide["kick2"]={x=9,y=0,w=50,h=81}
  
  lstFighters[2].lstBodyCollide["faceHit"]={x=3,y=8,w=51,h=79}
  
  
  
  
  ------------Cammy---------
  lstFighters[3]={}
  lstFighters[3].name="Cammy"
  
  lstFighters[3].scale=4
  
  lstFighters[3].lstImagesHits={}
  lstFighters[3].lstImagesHits[1]="images/characters/Cammy/imagesHits/punch.png"
  lstFighters[3].lstImagesHits[2]="images/characters/Cammy/imagesHits/punch2.png"
  lstFighters[3].lstImagesHits[3]="images/characters/Cammy/imagesHits/kick.png"
  lstFighters[3].lstImagesHits[4]="images/characters/Cammy/imagesHits/kick2.png"
  
  lstFighters[3].lstAnimations={}
  lstFighters[3].lstAnimations[1]={name="idle",stringImg="images/characters/Cammy/idle.png",wFrame=47,hFrame=84,lstFrames={1,2,3,4,5},speed=0.2,bLoop=true}
  lstFighters[3].lstAnimations[2]={name="walk",stringImg="images/characters/Cammy/walk.png",wFrame=45,hFrame=87,lstFrames={1,2,3,4,5,6},speed=0.1,bLoop=true}
  lstFighters[3].lstAnimations[3]={name="punch",stringImg="images/characters/Cammy/punch.png",wFrame=75,hFrame=84,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[3].lstAnimations[4]={name="punch2",stringImg="images/characters/Cammy/punch2.png",wFrame=70,hFrame=84,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[3].lstAnimations[5]={name="kick",stringImg="images/characters/Cammy/kick.png",wFrame=60,hFrame=82,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[3].lstAnimations[6]={name="kick2",stringImg="images/characters/Cammy/kick2.png",wFrame=77,hFrame=84,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[3].lstAnimations[7]={name="faceHit",stringImg="images/characters/Cammy/faceHit.png",wFrame=55,hFrame=81,lstFrames={1,2,3,4},speed=0.1,bLoop=false}
  lstFighters[3].lstAnimations[8]={name="victory1",stringImg="images/characters/Cammy/victory1.png",wFrame=47,hFrame=94,lstFrames={1,2,3,4,5},speed=0.2,bLoop=false}
  lstFighters[3].lstAnimations[9]={name="victory2",stringImg="images/characters/Cammy/victory2.png",wFrame=47,hFrame=88,lstFrames={1,2,3,4,5},speed=0.2,bLoop=false}
  lstFighters[3].lstAnimations[10]={name="ko",stringImg="images/characters/Cammy/ko.png",wFrame=75,hFrame=75,lstFrames={1,2,3},speed=0.2,bLoop=false}
  
  lstFighters[3].lstBodyCollide={}
  lstFighters[3].lstBodyCollide["idle"]={x=6,y=0,w=30,h=82}
  lstFighters[3].lstBodyCollide["walk"]={x=11,y=0,w=25,h=85}
  lstFighters[3].lstBodyCollide["punch"]={x=12,y=0,w=33,h=83}
  lstFighters[3].lstBodyCollide["punch2"]={x=12,y=0,w=32,h=83}
  lstFighters[3].lstBodyCollide["kick"]={x=0,y=0,w=30,h=81}
  lstFighters[3].lstBodyCollide["kick2"]={x=6,y=34,w=39,h=49}
  lstFighters[3].lstBodyCollide["faceHit"]={x=0,y=0,w=34,h=80}
  
  lstFighters[3].lstHitCollide={}
  lstFighters[3].lstHitCollide["punch"]={x=67,y=15,w=8,h=9}
  lstFighters[3].lstHitCollide["punch2"]={x=61,y=11,w=9,h=10}
  lstFighters[3].lstHitCollide["kick"]={x=50,y=9,w=10,h=8}
  lstFighters[3].lstHitCollide["kick2"]={x=66,y=21,w=11,h=10}
  
  
  
  ---------------Chun-Li----
  lstFighters[4]={}
  lstFighters[4].name="Chun-Li"
  
  lstFighters[4].scale=4
  
  lstFighters[4].lstImagesHits={}
  
  lstFighters[4].lstImagesHits[1]="images/characters/Chun-Li/imagesHits/punch.png"
  lstFighters[4].lstImagesHits[2]="images/characters/Chun-Li/imagesHits/punch2.png"
  lstFighters[4].lstImagesHits[3]="images/characters/Chun-Li/imagesHits/kick.png"
  lstFighters[4].lstImagesHits[4]="images/characters/Chun-Li/imagesHits/kick2.png"
  
  lstFighters[4].lstAnimations={}
  lstFighters[4].lstAnimations[1]={name="idle",stringImg="images/characters/Chun-Li/idle.png",wFrame=46,hFrame=79,lstFrames={1,2,3,4},speed=0.2,bLoop=true}
  lstFighters[4].lstAnimations[2]={name="walk",stringImg="images/characters/Chun-Li/walk.png",wFrame=51,hFrame=80,lstFrames={1,2,3,4,5,6,7,8},speed=0.1,bLoop=true}
  lstFighters[4].lstAnimations[3]={name="punch",stringImg="images/characters/Chun-Li/punch.png",wFrame=86,hFrame=76,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[4].lstAnimations[4]={name="punch2",stringImg="images/characters/Chun-Li/punch2.png",wFrame=78,hFrame=77,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[4].lstAnimations[5]={name="kick",stringImg="images/characters/Chun-Li/kick.png",wFrame=82,hFrame=87,lstFrames={1,2,4},speed=0.1,bLoop=false}
  lstFighters[4].lstAnimations[6]={name="kick2",stringImg="images/characters/Chun-Li/kick2.png",wFrame=76,hFrame=88,lstFrames={1,2,3,4},speed=0.1,bLoop=false}
  lstFighters[4].lstAnimations[7]={name="victory1",stringImg="images/characters/Chun-Li/victory1.png",wFrame=46,hFrame=86,lstFrames={1,2,3},speed=0.2,bLoop=false}
  lstFighters[4].lstAnimations[8]={name="victory2",stringImg="images/characters/Chun-Li/victory2.png",wFrame=48,hFrame=145,lstFrames={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18},speed=0.2,bLoop=false}
  lstFighters[4].lstAnimations[9]={name="ko",stringImg="images/characters/Chun-Li/ko.png",wFrame=80,hFrame=70,lstFrames={1,2,4},speed=0.2,bLoop=false}
  lstFighters[4].lstAnimations[10]={name="faceHit",stringImg="images/characters/Chun-Li/faceHit.png",wFrame=59,hFrame=83,lstFrames={1,2},speed=0.1,bLoop=false}
  
  lstFighters[4].lstBodyCollide={}
  lstFighters[4].lstBodyCollide["idle"]={x=4,y=0,w=34,h=77}
  lstFighters[4].lstBodyCollide["walk"]={x=7,y=0,w=42,h=78}
  lstFighters[4].lstBodyCollide["punch"]={x=12,y=0,w=42,h=74}
  lstFighters[4].lstBodyCollide["punch2"]={x=11,y=0,w=39,h=75}
  lstFighters[4].lstBodyCollide["kick"]={x=10,y=3,w=40,h=81}
  lstFighters[4].lstBodyCollide["kick2"]={x=4,y=12,w=38,h=74}
  lstFighters[4].lstBodyCollide["faceHit"]={x=9,y=3,w=38,h=79}
  
  lstFighters[4].lstHitCollide={}
  lstFighters[4].lstHitCollide["punch"]={x=74,y=19,w=12,h=10}
  lstFighters[4].lstHitCollide["punch2"]={x=65,y=10,w=13,h=12}
  lstFighters[4].lstHitCollide["kick"]={x=57,y=9,w=12,h=11}
  lstFighters[4].lstHitCollide["kick2"]={x=64,y=0,w=12,h=10}
  
  
  ---------Sagats--------
  lstFighters[5]={}
  lstFighters[5].name="Sagat"
  
  lstFighters[5].scale=3.2
  
  lstFighters[5].lstImagesHits={}
  
  lstFighters[5].lstImagesHits[1]="images/characters/Sagat/imagesHits/punch.png"
  lstFighters[5].lstImagesHits[2]="images/characters/Sagat/imagesHits/punch2.png"
  lstFighters[5].lstImagesHits[3]="images/characters/Sagat/imagesHits/kick.png"
  lstFighters[5].lstImagesHits[4]="images/characters/Sagat/imagesHits/kick2.png"
  
  lstFighters[5].lstAnimations={}
  lstFighters[5].lstAnimations[1]={name="idle",stringImg="images/characters/Sagat/idle.png",wFrame=52,hFrame=106,lstFrames={1,2,3,4},speed=0.2,bLoop=true}
  lstFighters[5].lstAnimations[2]={name="walk",stringImg="images/characters/Sagat/walk.png",wFrame=53,hFrame=109,lstFrames={1,2,3,4,5,6},speed=0.1,bLoop=true}
  lstFighters[5].lstAnimations[3]={name="punch",stringImg="images/characters/Sagat/punch.png",wFrame=103,hFrame=108,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[5].lstAnimations[4]={name="punch2",stringImg="images/characters/Sagat/punch2.png",wFrame=96,hFrame=109,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[5].lstAnimations[5]={name="kick",stringImg="images/characters/Sagat/kick.png",wFrame=93,hFrame=111,lstFrames={1,2,3,4},speed=0.1,bLoop=false}
  lstFighters[5].lstAnimations[6]={name="kick2",stringImg="images/characters/Sagat/kick2.png",wFrame=81,hFrame=106,lstFrames={1,2},speed=0.1,bLoop=false}
  lstFighters[5].lstAnimations[7]={name="victory1",stringImg="images/characters/Sagat/victory1.png",wFrame=47,hFrame=116,lstFrames={1,2},speed=0.2,bLoop=false}
  lstFighters[5].lstAnimations[8]={name="victory2",stringImg="images/characters/Sagat/victory2.png",wFrame=48,hFrame=114,lstFrames={1,2,3,4},speed=0.2,bLoop=false}
  lstFighters[5].lstAnimations[9]={name="ko",stringImg="images/characters/Sagat/ko.png",wFrame=88,hFrame=103,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[5].lstAnimations[10]={name="faceHit",stringImg="images/characters/Sagat/faceHit.png",wFrame=57,hFrame=108,lstFrames={1,2,3},speed=0.1,bLoop=false}
  
  lstFighters[5].lstBodyCollide={}
  lstFighters[5].lstBodyCollide["idle"]={x=8,y=0,w=44,h=104}
  lstFighters[5].lstBodyCollide["walk"]={x=10,y=1,w=42,h=107}
  lstFighters[5].lstBodyCollide["punch"]={x=4,y=0,w=46,h=107}
  lstFighters[5].lstBodyCollide["punch2"]={x=1,y=0,w=42,h=108}
  lstFighters[5].lstBodyCollide["kick"]={x=7,y=0,w=44,h=109}
  lstFighters[5].lstBodyCollide["kick2"]={x=0,y=0,w=41,h=72}
  lstFighters[5].lstBodyCollide["faceHit"]={x=0,y=0,w=46,h=106}
  
  lstFighters[5].lstHitCollide={}
  lstFighters[5].lstHitCollide["punch"]={x=93,y=32,w=11,h=13}
  lstFighters[5].lstHitCollide["punch2"]={x=85,y=34,w=11,h=11}
  lstFighters[5].lstHitCollide["kick"]={x=77,y=5,w=16,h=13}
  lstFighters[5].lstHitCollide["kick2"]={x=65,y=16,w=16,h=11}
  
  
  ---------------Vega-----
  lstFighters[6]={}
  lstFighters[6].name="Vega"
  
  lstFighters[6].scale=3.5
  
  lstFighters[6].lstImagesHits={}
  
  lstFighters[6].lstImagesHits[1]="images/characters/Vega/imagesHits/punch.png"
  lstFighters[6].lstImagesHits[2]="images/characters/Vega/imagesHits/punch2.png"
  lstFighters[6].lstImagesHits[3]="images/characters/Vega/imagesHits/kick.png"
  lstFighters[6].lstImagesHits[4]="images/characters/Vega/imagesHits/kick2.png"
  
  lstFighters[6].lstAnimations={}
  lstFighters[6].lstAnimations[1]={name="idle",stringImg="images/characters/Vega/idle.png",wFrame=59,hFrame=97,lstFrames={1,2,3},speed=0.2,bLoop=true}
  lstFighters[6].lstAnimations[2]={name="walk",stringImg="images/characters/Vega/walk.png",wFrame=58,hFrame=100,lstFrames={1,2,3,4},speed=0.1,bLoop=true}
  lstFighters[6].lstAnimations[3]={name="punch",stringImg="images/characters/Vega/punch.png",wFrame=115,hFrame=94,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[6].lstAnimations[4]={name="punch2",stringImg="images/characters/Vega/punch2.png",wFrame=92,hFrame=93,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[6].lstAnimations[5]={name="kick",stringImg="images/characters/Vega/kick.png",wFrame=92,hFrame=103,lstFrames={1,2,3,4,5},speed=0.1,bLoop=false}
  lstFighters[6].lstAnimations[6]={name="kick2",stringImg="images/characters/Vega/kick2.png",wFrame=82,hFrame=102,lstFrames={1,2,3},speed=0.1,bLoop=false}
  lstFighters[6].lstAnimations[7]={name="victory1",stringImg="images/characters/Vega/victory1.png",wFrame=75,hFrame=142,lstFrames={1,2,3,4,5,6,7,8,9},speed=0.2,bLoop=false}
  lstFighters[6].lstAnimations[8]={name="victory2",stringImg="images/characters/Vega/victory2.png",wFrame=75,hFrame=125,lstFrames={1,2,3,4,5,6,7,8},speed=0.2,bLoop=false}
  lstFighters[6].lstAnimations[9]={name="ko",stringImg="images/characters/Vega/ko.png",wFrame=79,hFrame=107,lstFrames={1,2,3,4,5,6},speed=0.2,bLoop=false}
  lstFighters[6].lstAnimations[10]={name="faceHit",stringImg="images/characters/Vega/faceHit.png",wFrame=60,hFrame=91,lstFrames={1,2,3},speed=0.1,bLoop=false}
  
  lstFighters[6].lstBodyCollide={}
  lstFighters[6].lstBodyCollide["idle"]={x=12,y=0,w=42,h=97}
  lstFighters[6].lstBodyCollide["walk"]={x=16,y=0,w=38,h=97}
  lstFighters[6].lstBodyCollide["punch"]={x=6,y=1,w=51,h=93}
  lstFighters[6].lstBodyCollide["punch2"]={x=17,y=0,w=38,h=93}
  lstFighters[6].lstBodyCollide["kick"]={x=17,y=4,w=38,h=39}
  lstFighters[6].lstBodyCollide["kick2"]={x=6,y=1,w=42,h=101}
  lstFighters[6].lstBodyCollide["faceHit"]={x=6,y=0,w=43,h=91}
  
  lstFighters[6].lstHitCollide={}
  lstFighters[6].lstHitCollide["punch"]={x=93,y=26,w=20,h=11}
  lstFighters[6].lstHitCollide["punch2"]={x=77,y=13,w=15,h=13}
  lstFighters[6].lstHitCollide["kick"]={x=76,y=0,w=16,h=12}
  lstFighters[6].lstHitCollide["kick2"]={x=70,y=46,w=12,h=13}

end

function rndMyOpponent(pFighterName)
  
  local bag={}
  for i=1,#lstFighters do
    
    if lstFighters[i].name~=pFighterName then
      table.insert(bag,i)
    end
  end

  local nBag=math.floor(math.random(1,#bag))
  local rndOpponent=bag[nBag]

  return rndOpponent
end

function SceneGame.load(pGameplayService,pSceneLoader)
  
  gameplayService=pGameplayService
  assetManager=pGameplayService.assetManager
  sceneLoader=pSceneLoader
  
  initBackgrounds()
  initFighters()
  
  local nBg=rndBackground()
  imgBG=gameplayService.assetManager.getImage(lstBackgrounds[nBg])
  
  ----------my Opponent----------------------
  local nOpponent=rndMyOpponent(gameplayService.myFighterName)
 
  myOpponent.sprite=gameplayService.sprite.init(nil,0,0)
  myOpponent.sprite.setScale(lstFighters[nOpponent].scale,lstFighters[nOpponent].scale)
  
  myOpponent.sprite.offsetX=-1
  
  myOpponent.name=lstFighters[nOpponent].name
  
  myOpponent.lstHitCollide=lstFighters[nOpponent].lstHitCollide
  myOpponent.lstBodyCollide=lstFighters[nOpponent].lstBodyCollide
  
  for n=1,#lstFighters[nOpponent].lstAnimations do
    local animation=lstFighters[nOpponent].lstAnimations[n]
    
    myOpponent.sprite.addAnimation(animation.name,assetManager.getImage(animation.stringImg),animation.wFrame,
      animation.hFrame,animation.lstFrames,animation.speed,animation.bLoop)
  end
  
  
  ------my fighter------------
  for i=1,#lstFighters do
    local fighter=lstFighters[i]
    
    if fighter.name==gameplayService.myFighterName then
      --myFighter
      myFighter.sprite=gameplayService.sprite.init(nil,0,0)
      myFighter.sprite.setScale(fighter.scale,fighter.scale)
      
      myFighter.sprite.offsetX=1
      
      myFighter.name=fighter.name

      myFighter.lstHitCollide=fighter.lstHitCollide
      myFighter.lstBodyCollide=fighter.lstBodyCollide
      
      for n=1,#fighter.lstAnimations do
        local animation=fighter.lstAnimations[n]
        
        myFighter.sprite.addAnimation(animation.name,assetManager.getImage(animation.stringImg),animation.wFrame,
          animation.hFrame,animation.lstFrames,animation.speed,animation.bLoop)
      end
      
      for i=1,#fighter.lstImagesHits do
        local img=gameplayService.assetManager.getImage(fighter.lstImagesHits[i])
        
        table.insert(myFighter.lstImagesHits,img)
      end
      
    end
    
  end
  
  -----impact animation-------
  impact=gameplayService.sprite.init(nil,0,0)
  impact.setScale(2,2)
  impact.addAnimation("impact",assetManager.getImage("images/impact.png"),32,32,{1,2,3,4,5,6,7,8},0.05,false)
  
  -----GUI-----
  myFighter.progressBar=GUI.newProgressBar(assetManager.getImage("images/GUI/progress_grey.png"),
    assetManager.getImage("images/GUI/progress_red.png"),gameplayService.screenWidth/2-30,64/2,myFighter.lives,100,-1)
  myFighter.progressBar.setScale(1.5,1)
  
  myOpponent.progressBar=GUI.newProgressBar(assetManager.getImage("images/GUI/progress_grey.png"),
    assetManager.getImage("images/GUI/progress_red.png"),(gameplayService.screenWidth/2)+30,64/2,myOpponent.lives,100,1)
  myOpponent.progressBar.setScale(1.5,1)
  
  
  AIFighter.init(myOpponent)
  
  myOpponent.nbVictory=0
  myFighter.nbVictory=0
  
  --btnA
  btnA={}
  btnA.sprite=gameplayService.sprite.init(assetManager.getImage("images/GUI/btnA.png"),gameplayService.screenWidth-32,32/1.2)
  btnA.sprite.addAnimation("normal",nil,32,32,{1},0.5,false)
  btnA.sprite.addAnimation("click",nil,32,32,{2},0.5,false)
  
  btnA.sprite.startAnimation("normal")
  btnA.bIsClick=false
  btnA.imgPage=gameplayService.assetManager.getImage("images/GUI/combosPage.png")
  
  ---ko
  ko.sprite=gameplayService.sprite.init(assetManager.getImage("images/GUI/ko.png"),gameplayService.screenWidth/2,64/1.5)
  ko.sprite.addAnimation("normal",nil,64,64,{1},0,false)
  ko.sprite.addAnimation("active",nil,64,64,{2},0.2,false)
  ko.sprite.startAnimation("normal")
  
  --sounds
  soundHit=gameplayService.assetManager.getSound("sounds/coupoing.wav")
  round.soundBip=gameplayService.assetManager.getSound("sounds/bip.wav")
  round.soundFight=gameplayService.assetManager.getSound("sounds/fight.wav")
  round.soundEnd=gameplayService.assetManager.getSound("sounds/finishRound.mp3")
  
  --musics
  round.music=gameplayService.assetManager.getSound("musics/musicCombat.mp3")
  round.music:setLooping(true)
  
  round.imgFight=gameplayService.assetManager.getImage("images/fight.png")
  
  round.musicVictory=gameplayService.assetManager.getSound("musics/musicVictoire.mp3")
  
  round.currentNum=1
  round.winnerGame=""
  camera.x=-400
  
  initRound()
  
end

function initRound()
  
  if round.winnerGame=="" then
    sequence=""
    
    myFighter.sprite.startAnimation("idle")
    myOpponent.sprite.startAnimation("idle")
    
    myFighter.lives=100
    myOpponent.lives=100
    
    myFighter.bHit=false
    myOpponent.bHit=false
    
    myFighter.sprite.offsetX=1
    myOpponent.sprite.offsetX=-1
    
    myFighter.sprite.x=(gameplayService.screenWidth/3)-(myFighter.sprite.currentAnimation.wFrame/2)*myFighter.sprite.scale.x
    myFighter.sprite.y=gameplayService.screenHeight-((myFighter.sprite.currentAnimation.hFrame/2)*myFighter.sprite.scale.y)-(gameplayService.screenHeight/12)

    
    myOpponent.sprite.x=gameplayService.screenWidth-((myOpponent.sprite.currentAnimation.wFrame/2)*myOpponent.sprite.scale.x)-100
    myOpponent.sprite.y=gameplayService.screenHeight-((myOpponent.sprite.currentAnimation.hFrame/2)*myOpponent.sprite.scale.y)-(gameplayService.screenHeight/12)
    
    round.count=4
    round.bFinishAnim=false
    round.bOnFight=false
  
  end
  round.timer=round.speed
   
end

function endRound(pType)
  
  love.audio.stop(round.music)
  
  
  if pType=="finishRound" then
    love.audio.play(round.soundEnd)
    if round.loser=="myFighter" and round.winner=="myOpponent" then
      myFighter.sprite.startAnimation("ko")
      myOpponent.sprite.startAnimation("victory1")
      
    else
      myFighter.sprite.startAnimation("victory1")
      myOpponent.sprite.startAnimation("ko")
    end
    
  elseif pType=="finishGame" then
    
    love.audio.play(round.musicVictory)
    if myFighter.nbVictory>myOpponent.nbVictory then
      myOpponent.sprite.startAnimation("ko")
      myFighter.sprite.startAnimation("victory2")
      
      round.winnerGame=myFighter.name
    else
      myFighter.sprite.startAnimation("ko")
      myOpponent.sprite.startAnimation("victory2")
      
       round.winnerGame=myOpponent.name
    end
      
      myFighter.sprite.offsetX=1
      myOpponent.sprite.offsetX=-1
      
       ---fighters positions x for the victory animation
      myFighter.sprite.x=(gameplayService.screenWidth/2)-(myFighter.sprite.currentAnimation.wFrame/2)*myFighter.sprite.scale.x
      myOpponent.sprite.x=gameplayService.screenWidth/2+((myOpponent.sprite.currentAnimation.wFrame/2)*myOpponent.sprite.scale.x)
  end
  
   ---fighters positions y for the victory animation
  myFighter.sprite.y=gameplayService.screenHeight-((myFighter.sprite.currentAnimation.hFrame/2)*myFighter.sprite.scale.y)-(gameplayService.screenHeight/12)        
  myOpponent.sprite.y=gameplayService.screenHeight-((myOpponent.sprite.currentAnimation.hFrame/2)*myOpponent.sprite.scale.y)-(gameplayService.screenHeight/12)
  
  round.bOnFight=false
end

function collideHitFighters(pFighter,pOpponent)
  
  if pFighter.sprite.currentAnimation~=nil and pOpponent.sprite.currentAnimation~=nil then
    
    ---box collide
    local fighterHit=pFighter.lstHitCollide[pFighter.sprite.currentAnimation.name]
    local opponentBody=pOpponent.lstBodyCollide[pOpponent.sprite.currentAnimation.name]
   
    if fighterHit~=nil and opponentBody~=nil then
    
      local nFrame=math.floor(#pFighter.sprite.currentAnimation.lstFrames/2)+1
      local bCollide
      
      if pFighter.sprite.currentFrameInAnimation==nFrame then
       if pFighter.sprite.offsetX==1 and pOpponent.sprite.offsetX==-1 then
         
         bCollide=checkCollision(pFighter.sprite.x-((pFighter.sprite.currentAnimation.wFrame/2)*pFighter.sprite.scale.x)+(fighterHit.x*pFighter.sprite.scale.x),
            pFighter.sprite.y-((pFighter.sprite.currentAnimation.hFrame/2)*pFighter.sprite.scale.y)+(fighterHit.y*pFighter.sprite.scale.y),
            fighterHit.w*pFighter.sprite.scale.x,
            fighterHit.h*pFighter.sprite.scale.y,
            pOpponent.sprite.x+((pOpponent.sprite.currentAnimation.wFrame/2)*pOpponent.sprite.scale.x)-((opponentBody.x+opponentBody.w)*pOpponent.sprite.scale.x),
            pOpponent.sprite.y-((pOpponent.sprite.currentAnimation.hFrame/2)*pOpponent.sprite.scale.y),
            opponentBody.w*pOpponent.sprite.scale.x,
            opponentBody.h*pOpponent.sprite.scale.y)
          
        elseif pFighter.sprite.offsetX==-1 and pOpponent.sprite.offsetX==1 then
          
          bCollide=checkCollision(pFighter.sprite.x+((pFighter.sprite.currentAnimation.wFrame/2)*pFighter.sprite.scale.x)-((fighterHit.x+fighterHit.w)*pFighter.sprite.scale.x),
          pFighter.sprite.y-((pFighter.sprite.currentAnimation.hFrame/2)*pFighter.sprite.scale.y)+(fighterHit.y*pFighter.sprite.scale.y),
            fighterHit.w*pFighter.sprite.scale.x,
            fighterHit.h*pFighter.sprite.scale.y,
            pOpponent.sprite.x-((pOpponent.sprite.currentAnimation.wFrame/2)*pOpponent.sprite.scale.x)+(opponentBody.x*pOpponent.sprite.scale.x),
            pOpponent.sprite.y-((pOpponent.sprite.currentAnimation.hFrame/2)*pOpponent.sprite.scale.y)+(opponentBody.y*pOpponent.sprite.scale.y),
            opponentBody.w*pOpponent.sprite.scale.x,
            opponentBody.h*pOpponent.sprite.scale.y)
          
        end
        
      end
      
      if bCollide then
        
        if impact.currentAnimation==nil then
          
          pOpponent.lives=pOpponent.lives-10
          
          pOpponent.sprite.startAnimation("faceHit")
          
          -------impact position
          if pFighter.sprite.offsetX==1 then
            impact.x=pFighter.sprite.x-((pFighter.sprite.currentAnimation.wFrame/2)*pFighter.sprite.scale.x)+((fighterHit.x+fighterHit.w)*pFighter.sprite.scale.x)
            impact.y=pFighter.sprite.y-((pFighter.sprite.currentAnimation.hFrame/2)*pFighter.sprite.scale.y)+(fighterHit.y*pFighter.sprite.scale.y)
            
          else
            impact.x=pFighter.sprite.x+((pFighter.sprite.currentAnimation.wFrame/2)*pFighter.sprite.scale.x)-((fighterHit.x+fighterHit.w)*pFighter.sprite.scale.x)
            impact.y=pFighter.sprite.y-((pFighter.sprite.currentAnimation.hFrame/2)*pFighter.sprite.scale.y)+(fighterHit.y*pFighter.sprite.scale.y)
          end
          
          impact.startAnimation("impact")
          ko.sprite.startAnimation("active")
          love.audio.play(soundHit)
          
        end
      end
  
    end
  end
  
end

function combos(pCombos)
  
  for i=1,#myFighter.lstAnimations do
    local combos=myFighter.lstAnimations[i]
    
    if combos.sequence==pCombos then
      
      sequence=""
      myFighter.sprite.startAnimation(combos.name)
      myFighter.bHit=true
    
      
      return true
    end
    
  end
  
  return false
  
end

function updateStartRound(dt)
    
  round.timer=round.timer-dt
 
  if round.timer<=0 then
    if not round.bFinishAnim then
      
      if round.count>=1 then
        round.count=round.count-1
        
        if round.count>0 then
          love.audio.play(round.soundBip)
        end
        
      else
        round.bFinishAnim=true
      end
    
    else
      if not round.bOnFight then
        round.bOnFight=true
        love.audio.play(round.soundFight)
        
      else
        timerGame=speedTimer
        love.audio.play(round.music)
        bStartRound=true
      end
    end
    
    round.timer=round.speed
  end
end


function updateRound(dt)
      
  local animation=""

  local oldX=myFighter.sprite.x
  local oldY=myFighter.sprite.y
  
  ------timer combos-----
  resetTimer=resetTimer-dt
  
  if resetTimer<=0 then
    resetTimer=resetSpeed
    sequence=""
  end
  
    
  --move of my Fighter
  if love.keyboard.isDown("right") then
    
    if not myFighter.bHit then
      
      myFighter.sprite.x=myFighter.sprite.x+5*60*dt
      
      --scrolling
      if camera.x>-600 then
        if myFighter.sprite.x>gameplayService.screenWidth/2 then
          camera.x=camera.x-8*60*dt
          myOpponent.sprite.x=myOpponent.sprite.x-8*60*dt
        end
      end
      
    end
    
    animation="walk"
    
  elseif love.keyboard.isDown("left") then
    
    if not myFighter.bHit then
      
      myFighter.sprite.x=myFighter.sprite.x-5*60*dt
      
      --scrolling
      if camera.x<0 then
        if myFighter.sprite.x<gameplayService.screenWidth/2 then
          camera.x=camera.x+8*60*dt
          myOpponent.sprite.x=myOpponent.sprite.x+8*60*dt
        end
      end
    end
    
    animation="walk"
    
  elseif love.keyboard.isDown("up") then
    
    if not myFighter.bHit then
      myFighter.sprite.y=myFighter.sprite.y-3*60*dt
    end
    
    animation="walk"
  
  elseif love.keyboard.isDown("down") then
    
    if not myFighter.bHit then
      myFighter.sprite.y=myFighter.sprite.y+3*60*dt
    end
    
    animation="walk"
    
  else
    animation="idle"
  end
  
  
  ---limit move x
  if camera.x>=0 then
    camera.x=0
    
    if myFighter.sprite.x-((myFighter.sprite.currentAnimation.wFrame/2)*myFighter.sprite.scale.x)<=0 then
      myFighter.sprite.x=((myFighter.sprite.currentAnimation.wFrame/2)*myFighter.sprite.scale.x)
    end
  end
  
  if camera.x<=-600 then
    camera.x=-600
    
    if myFighter.sprite.x+((myFighter.sprite.currentAnimation.wFrame/2)*myFighter.sprite.scale.x)>=gameplayService.screenWidth then
      myFighter.sprite.x=gameplayService.screenWidth-((myFighter.sprite.currentAnimation.wFrame/2)*myFighter.sprite.scale.x)
    end
  end
  
  ---limit move y
  if myFighter.sprite.y+(myFighter.sprite.currentAnimation.hFrame/2*myFighter.sprite.scale.y)>=gameplayService.screenHeight-20 then
    myFighter.bIsFalse3DPos=true
    myFighter.sprite.y=(gameplayService.screenHeight-20)-(myFighter.sprite.currentAnimation.hFrame/2*myFighter.sprite.scale.y)
    
  elseif myFighter.sprite.y+(myFighter.sprite.currentAnimation.hFrame/2*myFighter.sprite.scale.y)<=gameplayService.screenHeight-(gameplayService.screenHeight/7) then
    
    myFighter.bIsFalse3DPos=true
    myFighter.sprite.y=(gameplayService.screenHeight-(gameplayService.screenHeight/7))-(myFighter.sprite.currentAnimation.hFrame/2*myFighter.sprite.scale.y)
  
else
  
    if myFighter.sprite.y+(myFighter.sprite.currentAnimation.hFrame/2*myFighter.sprite.scale.y)>gameplayService.screenHeight-((gameplayService.screenHeight/7)-10) and myFighter.sprite.y+(myFighter.sprite.currentAnimation.hFrame/2)*myFighter.sprite.scale.y<gameplayService.screenHeight-(20+10) then
      myFighter.bIsFalse3DPos=false
    end
  
  end
  
  
  if not myFighter.bIsFalse3DPos then
    
    ---collision with enemy
    if myFighter.sprite.offsetX==1 then
      if myFighter.sprite.x>=myOpponent.sprite.x-(myOpponent.sprite.currentAnimation.wFrame/2*myOpponent.sprite.scale.x) then
        myFighter.sprite.x=myOpponent.sprite.x-(myOpponent.sprite.currentAnimation.wFrame/2*myOpponent.sprite.scale.x)
        
      end
      
    else
      
      if myFighter.sprite.x<=myOpponent.sprite.x+((myOpponent.sprite.currentAnimation.wFrame/2)*myOpponent.sprite.scale.x) then
        
        myFighter.sprite.x=myOpponent.sprite.x+((myOpponent.sprite.currentAnimation.wFrame/2)*myOpponent.sprite.scale.x)
        
      end
      
    end
    
  else
    ------offsetX change------
    if myFighter.sprite.x>myOpponent.sprite.x then
      myFighter.sprite.offsetX=-1
      myOpponent.sprite.offsetX=1
      
    else
      myOpponent.sprite.offsetX=-1
      myFighter.sprite.offsetX=1
    end
    
  end

  ---------Hits!--------
  
  if not myFighter.bIsFalse3DPos then
    ------myFighter hit
    if myFighter.bHit then
      collideHitFighters(myFighter,myOpponent)
    end
    
    ----myOpponent hit
    if myOpponent.bHit then
      collideHitFighters(myOpponent,myFighter)
    end
  end
  
  ------combos
  local sequence3=string.sub(sequence,#sequence-(3*2)+1,#sequence)
  
  if not combos(sequence3) then
    
    local sequence4=string.sub(sequence,#sequence-(4*2)+1,#sequence)
    
    if not combos(sequence4) then
      local sequence5=string.sub(sequence,#sequence-(5*2)+1,#sequence)
      
      if not combos(sequence5) then
        
      end
        
    end
  
  end
  
  --animations
  if animation~="" then
    
    if myFighter.sprite.currentAnimation.bLoop then
      myFighter.sprite.startAnimation(animation)
    else
      
      if myFighter.sprite.currentAnimation.bIsFinish then
        myFighter.bHit=false
        myFighter.sprite.startAnimation(animation)
      end
      
    end
  end
  
  -------value progress bar------------- 
  if myFighter.lives<=0 then
    
    myFighter.lives=0
    myOpponent.nbVictory=myOpponent.nbVictory+1
    round.winner="myOpponent"    
    round.loser="myFighter"
    
    bStartRound=false
    endRound("finishRound")
    
  
  elseif myOpponent.lives<=0 then
  
    timerGame=speedTimer
    myOpponent.lives=0
    myFighter.nbVictory=myFighter.nbVictory+1
    round.winner="myFighter"
    round.loser="myOpponent"
    
    bStartRound=false
    endRound("finishRound")
  
  end
  
  --------AI opponent
  AIFighter.update(dt,myFighter)
  
  -----impact animation
  if impact.currentAnimation~=nil then
    if impact.currentAnimation.bIsFinish then
      impact.currentAnimation=nil
    end
  end
  
end

function SceneGame.update(dt)
  
  if not btnA.bIsClick then
    
    if bStartRound then
      
      ---resume music
      if not love.audio.play(round.music) then
        love.audio.resume(round.music)
      end
      
      updateRound(dt)
    else
      
      if round.currentNum>=1 then
        
        if not myFighter.sprite.currentAnimation.bLoop then
          ---finish animation victory1 and ko
          if myFighter.sprite.currentAnimation.bIsFinish and myOpponent.sprite.currentAnimation.bIsFinish then
            timerGame=timerGame-dt
            
            if timerGame<=0 then
              if round.currentNum>=3 then
                
                if myFighter.sprite.currentAnimation.name=="victory1" or myOpponent.sprite.currentAnimation.name=="victory1" then
                  timerGame=speedTimer+2
                  gameplayService.GUI.totalDelete()
                  endRound("finishGame")
                else
                  sceneLoader.init("menu")
                end
                
              else

                --init new round
                round.currentNum=round.currentNum+1
                initRound()
              end
            end
          end
          
        else
          ---animation new Round
          updateStartRound(dt)
        end
        
      end
    end
    
    ---btn A animation
    if btnA.sprite.currentAnimation.bIsFinish then
      if btnA.sprite.currentAnimation.name=="normal" then
        btnA.sprite.startAnimation("click")
      else
        btnA.sprite.startAnimation("normal")
      end
    end
    
    ---ko
    if ko.sprite.currentAnimation.name=="active" then
      if ko.sprite.currentAnimation.bIsFinish then
        ko.sprite.startAnimation("normal")
      end
    end
  
    
  else
    btnA.sprite.startAnimation("normal")
    ---pause music
    love.audio.pause(round.music)
  end
  
  
  gameplayService.sprite.update(dt)
   
  myFighter.progressBar.setValue(myFighter.lives)
  myOpponent.progressBar.setValue(myOpponent.lives)

end

function drawFighters()
  
  if myFighter.bHit then
    myOpponent.sprite.draw()
    myFighter.sprite.draw()
    
  elseif myOpponent.bHit then
    myFighter.sprite.draw()
    myOpponent.sprite.draw()
  end
    
  if myFighter.sprite.y+((myFighter.sprite.currentAnimation.hFrame)*myFighter.sprite.scale.y)>myOpponent.sprite.y+((myOpponent.sprite.currentAnimation.hFrame)*myOpponent.sprite.scale.y) then
    
    myOpponent.sprite.draw()
    myFighter.sprite.draw()
  
  elseif myFighter.sprite.y+((myFighter.sprite.currentAnimation.hFrame)*myFighter.sprite.scale.y)<myOpponent.sprite.y+((myOpponent.sprite.currentAnimation.hFrame)*myOpponent.sprite.scale.y) then
    myFighter.sprite.draw()
    myOpponent.sprite.draw()
  
  else
    myOpponent.sprite.draw()
    myFighter.sprite.draw()
  end  
end

function SceneGame.draw()
  love.graphics.draw(imgBG,0+camera.x,0)
  
  
  if round.winnerGame=="" then
    btnA.sprite.draw()
    ko.sprite.draw()
  
    love.graphics.setColor(97/255,0,0)
    love.graphics.print(myFighter.name,myFighter.progressBar.x-((myFighter.progressBar.imgProgress:getWidth()/2)*myFighter.progressBar.scaleX)-50,myFighter.progressBar.y+20,0,0.3,0.3)
    
    love.graphics.print(myOpponent.name,myOpponent.progressBar.x+((myOpponent.progressBar.imgProgress:getWidth()/2)*myOpponent.progressBar.scaleX)-50,myOpponent.progressBar.y+20,0,0.3,0.3)
    
    love.graphics.setColor(1,1,1)
  end
  
  drawFighters()
  gameplayService.GUI.draw()
  
  if impact.currentAnimation~=nil then
    impact.draw()
  end
  
  love.graphics.setFont(gameplayService.fontGame)
  
  love.graphics.setColor(0,0,0)
  if not bStartRound then
    
    if round.winnerGame=="" then
      
      if round.count>=1 and round.count<4 then
        love.graphics.print(round.count,gameplayService.screenWidth/2-50,gameplayService.screenHeight/3)
      
      elseif round.count==4 then
        love.graphics.print("ROUND "..round.currentNum,gameplayService.screenWidth/4,gameplayService.screenHeight/3)
        
      else
        if round.bOnFight then
          love.graphics.setColor(1,1,1,1)
          love.graphics.draw(round.imgFight,gameplayService.screenWidth/3.5,gameplayService.screenHeight/3)
        end
      end
      
    else
      love.graphics.setColor(0,0,0)
      love.graphics.print("Victoire pour "..round.winnerGame,gameplayService.screenWidth/5,5)
    end
      
  end
  
  love.graphics.setColor(1,1,1,1)
  
  ----page combos
  if btnA.bIsClick then
    love.graphics.draw(btnA.imgPage,50,0,0)
    
    ---hits images
    for i=1,#myFighter.lstImagesHits do
      local img=myFighter.lstImagesHits[i]
      
      if myFighter.name~="Sagat" and myFighter.name~="Chun-Li" then
        
        love.graphics.draw(img,(gameplayService.screenWidth/2),gameplayService.screenHeight/3+(myFighter.lstImagesHits[1]:getHeight())*(i-1))
      else
        
        if myFighter.name=="Sagat" then
          love.graphics.draw(img,(gameplayService.screenWidth/2),gameplayService.screenHeight/3.3+(myFighter.lstImagesHits[1]:getHeight())*(i-1))
          
        elseif myFighter.name=="Chun-Li" then
           love.graphics.draw(img,(gameplayService.screenWidth/2),gameplayService.screenHeight/2.5+(myFighter.lstImagesHits[1]:getHeight())*(i-1))
        end
        
      end
      
    end
  
end

end

function SceneGame.keypressed(key)
  
  if key=="a" then
    if not btnA.bIsClick then
      btnA.bIsClick=true
    else
      btnA.bIsClick=false
    end
  end
  
  resetTimer=resetSpeed
  
  local action=key.."-"..previousKey
  
  if ActionsList[action]~=nil then
    sequence=sequence..ActionsList[action]
    
  else
    action=key
    
    if ActionsList[action]~=nil then
      sequence=sequence..ActionsList[action]
    end
    
  end

  previousKey=key
end

return SceneGame