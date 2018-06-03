//
//  CollectablesController.swift
//  jack64
//
//  Created by ABD on 24/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//


import SpriteKit

    class collectablesController {
        
        
        func getCoin() ->SKSpriteNode{
            var coin = SKSpriteNode()
            
            if Int(randomBetweenNumbers(firstNum: 0, secendNum: 7)) >= 0{
                
                coin = SKSpriteNode(imageNamed: "gold_1")
                coin.name = "Coin"
                coin.xScale = 0.4
                coin.yScale = 0.4
                coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.height / 2)
                coin.physicsBody?.affectedByGravity = false
                coin.physicsBody?.categoryBitMask = ColliderType.kunai
                coin.physicsBody?.collisionBitMask = ColliderType.Player
                coin.zPosition = 2
                
            }
        return coin
        
        
        
        }

        func randomBetweenNumbers(firstNum : CGFloat ,secendNum : CGFloat)->CGFloat{
            
            
            return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secendNum) + min(firstNum,secendNum)
            
            
        }
        func addLife(){
            if ((GamePlayController.instace.score!) % 5 == 0 ){
                
                GamePlayController.instace.incrementLife()
            }
            
            
        }




}


