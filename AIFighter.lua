local AIFighter={}

local state={}
state.none="NONE"
state.move="MOVE"
state.attack="ATTACK"
state.changeDir="CHANGE"

local agent=nil
local animation=""

function dist(pX1,pY1,pX2,pY2)
  return ((pX2-pX1)^2+(pY2-pY1)^2)^0.5
end

function AIFighter.init(pAgent)
  agent=pAgent
  
  agent.state=state.none
  agent.vx=0
  agent.vy=0
  
  agent.timerSpeed=math.random(0.1,0.2)
  agent.timer=agent.timerSpeed
  
end

function rndAttack()
  
  local rnd=math.floor(math.random(1,5))
  local nameAttack=""
  
  if rnd==1 then
    nameAttack="punch"
  elseif rnd==2 then
    nameAttack="punch2"
  elseif rnd==3 then
    nameAttack="kick"
  elseif rnd==4 then
    nameAttack="kick2"
  elseif rnd==5 then
    nameAttack="idle"
  end

  return nameAttack
end

function stopAgent()
  agent.vx=0
  animation="idle"
end

function AIFighter.update(dt,pOpponent)
  animation=""
  local attackAnim=rndAttack()
  
  local distance=dist(agent.sprite.x,agent.sprite.y,pOpponent.sprite.x,pOpponent.sprite.y)
  
  agent.sprite.x=agent.sprite.x+agent.vx*60*dt
  
  if not pOpponent.bIsFalse3DPos then
  
    ---------------------NONE--------------------------
    if agent.state==state.none then
      
      animation="idle"
      
      agent.timer=agent.timer-dt
      
      if agent.timer<=0 then
        
        if pOpponent.sprite.x>screenWidth/4 then
          agent.state="MOVE"
        end
        
      end
      
    -----------------------MOVE--------------------------
    elseif agent.state==state.move then
      
      local bNewState=false

      if not pOpponent.bHit then
        
        if agent.sprite.offsetX==-1 then
          agent.vx=-3
          animation="walk"
         
        elseif agent.sprite.offsetX==1 then
          agent.vx=3
          animation="walk"
      
        end
        
        if distance<=(pOpponent.sprite.currentAnimation.wFrame)*pOpponent.sprite.scale.x then
          agent.vx=0
          agent.timerSpeed=0.2
          agent.timer=agent.timerSpeed
          agent.state="ATTACK"
        end
      end

    ----------------CHANGE----------------------------
    elseif agent.state==state.changeDir then
      
      agent.timer=agent.timer-dt
      
      if agent.timer<=0 then
        agent.timerSpeed=math.random(0.1,0.2)
        agent.timer=agent.timerSpeed
        
        
        agent.vx=0
        agent.state="NONE"
        
      else
        
        if agent.sprite.offsetX==-1 then
          
          if agent.sprite.x+((agent.sprite.currentAnimation.wFrame/2)*agent.sprite.scale.x)<screenWidth then
            animation="walk"
            agent.vx=4
          else
            stopAgent()
          end
        
        else
        
          if agent.sprite.x-((agent.sprite.currentAnimation.wFrame/2)*agent.sprite.scale.x)>0 then
            animation="walk"
            agent.vx=-4
          else
            stopAgent()
          end
        
        end
        
        
        
      end
      
    -----------------------------ATTACK------------------
    elseif agent.state==state.attack then
      
      if not pOpponent.bHit then
      
        -------attack
        if agent.sprite.currentFrameInAnimation>=#agent.sprite.currentAnimation.lstFrames then
          
          agent.timer=agent.timer-dt
          
          if agent.timer<=0 then
            agent.timerSpeed=math.random(0.5,0.8)
            agent.timer=agent.timerSpeed
            
            agent.bHit=false
            agent.state="CHANGE"
          end
          
        else
          
          if agent.sprite.currentAnimation.name~="idle" then
            agent.bHit=true
            animation=attackAnim
            
          else
            agent.state="NONE"
          end
        end
       
      end
      
    end
    
  else
    stopAgent()
  end
    
  if pOpponent.bHit then
    stopAgent()
  end
  
  ------animation----
  if animation~="" then
    
    if agent.sprite.currentAnimation.bLoop then
      agent.sprite.startAnimation(animation)
      
    else
      
      if agent.sprite.currentAnimation.bIsFinish then
         agent.sprite.startAnimation(animation)
      end
      
    end
    
  end

end

return AIFighter