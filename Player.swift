//
//  Player.swift
//  jack64
//
//  Created by ABD on 11/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import SpriteKit
import GameplayKit

struct ColliderType  {
    static let Player : UInt32 = 0;
    static let Grounds : UInt32 = 1;
    static let DarkgroundCollectables  : UInt32 = 2;
    static let kunai : UInt32 = 4;
    
    
}

class Player : SKSpriteNode{
    
      private var textureAtlas = SKTextureAtlas()
      private var plyerAnimation = [SKTexture]()
      private var animatePlayerAction = SKAction()
      private var lastY = CGFloat()
    
    func initializePlayerAndAnimation(){
    
        textureAtlas = SKTextureAtlas(named: "Player")
        for i in 1...9{
           let name = "Run__00\(i)"
            
            plyerAnimation.append(SKTexture(imageNamed : name))
            
             }
             animatePlayerAction = SKAction.animate(with: plyerAnimation, timePerFrame: 0.06, resize: true, restore: false)
        
         // add PhysicsBody To the player
          self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
          self.physicsBody?.affectedByGravity = true
          self.physicsBody?.allowsRotation = false
          self.physicsBody?.restitution = 0
          self.physicsBody?.categoryBitMask = ColliderType.Player
          self.physicsBody?.collisionBitMask = ColliderType.Grounds
        // call did Begean Contact
          self.physicsBody?.contactTestBitMask = ColliderType.DarkgroundCollectables
          self.physicsBody?.contactTestBitMask = ColliderType.kunai

        lastY = self.position.y
        
    }
    func animatePlayer(moveLeft:Bool){
        if moveLeft{
        self.xScale = -(CGFloat)(fabsf(Float(self.xScale)))
        
        
        }else{
        self.xScale = (CGFloat)(fabsf(Float(self.xScale)))
        
        
        }
        
    
       self.run(SKAction.repeatForever(animatePlayerAction), withKey:"Animate")
    }
    func stopAnimatePlayer(){
    
    self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Run__000")
        self.size = (self.texture?.size())!
    
    }
    
    
    func MovePlayer(moveLeft : Bool) {
        
        
        if moveLeft{
           self.position.x -= 6
            }else{
        
           self.position.x += 6
        }
    
    
    
    
    }
       func setScore(){
        if self.position.y < lastY {
          GamePlayController.instace.incrementScore()
            lastY = self.position.y
        
        }
    
    
    }

}
