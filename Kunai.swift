//
//  Kunai.swift
//  jack64
//
//  Created by ABD on 23/03/2017.
//  Copyright © 2017 ABD. All rights reserved.
//


import SpriteKit


class KunaiController {
    private var minX = CGFloat(-166) , maxX = CGFloat(173) , X = CGFloat(-70)
    
    var kunai = SKSpriteNode()
    
    func spawnKunai(camera : SKCameraNode) -> SKSpriteNode {
        kunai = SKSpriteNode(imageNamed: "Kunai")
        kunai.name = "Kunai1"
        
        
        
        if Int(randomBetweenNumbers(firstNum: 0, secendNum: 10)) >= 6{
            
            kunai.zRotation =  CGFloat(Double.pi/2)
            kunai.position.y = camera.position.y - 1000
            kunai.position.x = randomBetweenNumbers(firstNum: minX, secendNum: X)
            kunai.xScale = 0.35
            kunai.yScale = 0.35
            kunai.zPosition = 3
            kunai.anchorPoint = CGPoint(x: 0.5, y: 0.5)
           
            // physicsBody
            
            
            
            
            
            
        } else {
            kunai.zRotation =  CGFloat(Double.pi/2)
            kunai.position.y = camera.position.y - 1000
            kunai.position.x = randomBetweenNumbers(firstNum: 70, secendNum: maxX)
            kunai.xScale = 0.35
            kunai.yScale = 0.35
            kunai.zPosition = 3
            kunai.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            // physicsBody
            
            
            
            
        }
        
        kunai.physicsBody = SKPhysicsBody(rectangleOf: (kunai.size))
        kunai.physicsBody?.affectedByGravity = false
        kunai.physicsBody?.allowsRotation = false
        kunai.physicsBody?.restitution = 0
        kunai.physicsBody?.categoryBitMask = ColliderType.kunai
        kunai.physicsBody?.collisionBitMask = ColliderType.Player
        
        
        
        return kunai
}
    
    
    func randomBetweenNumbers(firstNum : CGFloat ,secendNum : CGFloat)->CGFloat{
        
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secendNum) + min(firstNum,secendNum)
        
        
    }
    

    
    
    
    
    
    
    
    
    
    
    

}//Class


























