//
//  GroundController.swift
//  jack64
//
//  Created by ABD on 13/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import SpriteKit



class GroundController{
    
    var coinController = collectablesController()
    
    
    var lastGroundPositionY = CGFloat();
    
    
    func shuffle( groundArray: [SKSpriteNode] ) -> [SKSpriteNode]{
        var groundArray = groundArray
        for i in ((0 + 1)...groundArray.count - 1).reversed() {
         let j = Int(arc4random_uniform(UInt32(i - 1)))
        
            groundArray.swapAt(i, j)        
        }
        return groundArray
    }
    
    func randomBetweenNumbers(firstNum : CGFloat ,secendNum : CGFloat)->CGFloat{
      
    
      return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secendNum) + min(firstNum,secendNum)
    
    
    }

    func createGround() ->[SKSpriteNode]{
    
        var Grounds = [SKSpriteNode]();
        
        for  var i in 0 ..< 2  {
            
            let ground1 = SKSpriteNode(imageNamed: "ground1.png")
               ground1.name = "1"
            let ground2 = SKSpriteNode(imageNamed: "ground22.png")
               ground2.name = "2"
            let ground3 = SKSpriteNode(imageNamed: "ground3.png")
               ground3.name = "3"
            let DarkGround = SKSpriteNode(imageNamed: "DARK12.png")
               DarkGround.name = "DarkGround"
            
            ground1.xScale = 0.6
            ground1.yScale = 0.6
            
            ground2.xScale = 0.6
            ground2.yScale = 0.6
            
            ground3.xScale = 0.6
            ground3.yScale = 0.6
            
            DarkGround.xScale = 0.55
            DarkGround.yScale = 0.55
            
            //add physics body to the Ground
            ground1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground1.size.width, height: ground1.size.height))
            ground1.physicsBody?.affectedByGravity = false
            ground1.physicsBody?.restitution = 0
            ground1.physicsBody?.categoryBitMask = ColliderType.Grounds
            ground1.physicsBody?.collisionBitMask = ColliderType.Player
            
            
            ground2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground2.size.width, height: ground2.size.height))
            ground2.physicsBody?.affectedByGravity = false
            ground2.physicsBody?.restitution = 0
            ground2.physicsBody?.categoryBitMask  = ColliderType.Grounds
            ground2.physicsBody?.collisionBitMask = ColliderType.Player

            
            ground3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground3.size.width, height: ground3.size.height))
            ground3.physicsBody?.affectedByGravity = false
            ground3.physicsBody?.restitution = 0
            ground3.physicsBody?.categoryBitMask = ColliderType.Grounds
            ground3.physicsBody?.collisionBitMask = ColliderType.Player

            
             DarkGround.physicsBody = SKPhysicsBody(rectangleOf: DarkGround.size)
             DarkGround.physicsBody?.affectedByGravity = false
             DarkGround.physicsBody?.categoryBitMask  = ColliderType.kunai
             DarkGround.physicsBody?.collisionBitMask = ColliderType.Player

            
            
            
            Grounds.append(ground1)
            Grounds.append(ground2)
            Grounds.append(ground3)
            Grounds.append(DarkGround)
            i += 1
         
        
        
        }
        
        
    
      Grounds = shuffle(groundArray: Grounds)
    
    
        return Grounds ;
    }
    
    func arrangeGroundInScene( scene : SKScene , distanceBetweenGrounds : CGFloat , center : CGFloat , minX : CGFloat , maxX : CGFloat , initialGround : Bool) {
        var grounds = createGround()
        if initialGround{
            while (grounds[0].name == "DarkGround") {
                //Shuffle the Ground Array
                grounds = shuffle(groundArray: grounds)
            }
        
        
        
        }
        var positionY = CGFloat();
        
        if initialGround{
            positionY = center - 100
        }else{
            positionY = lastGroundPositionY
    
}
        var random = 0
        for i in 0...grounds.count - 1 {
            var randomX = CGFloat()
            if random == 0{
            
                randomX = randomBetweenNumbers(firstNum: center + 90, secendNum: maxX)
                random = 1
            
            }else if random == 1 {
               randomX = randomBetweenNumbers(firstNum: center - 90, secendNum: minX)
                random = 0
            
            
            }
        
            grounds[i].position = CGPoint(x: randomX, y: positionY)
            grounds[i].zPosition = 3
            
            
            
            if !initialGround {
                if Int(randomBetweenNumbers(firstNum: 0, secendNum: 7)) >= 1{
                    if grounds[i].name != "DarkGround"{
                     let coin = coinController.getCoin()
                        coin.position = CGPoint(x: grounds[i].position.x, y: grounds[i].position.y + 66)
                        scene.addChild(coin) 
                   
                    
                    
                    }
                    
                    
                    
                
                
                
                
                }
            
            
            
            }
            
            scene.addChild(grounds[i])
            positionY -= distanceBetweenGrounds
            lastGroundPositionY = positionY
            
        
        }



}
}
