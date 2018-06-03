//
//  GamePlayController.swift
//  jack64
//
//  Created by ABD on 24/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import Foundation
import SpriteKit


class GamePlayController {
    
   static let instace = GamePlayController()
    private init() {}
    var scoreText : SKLabelNode?
    var coinText : SKLabelNode?
    var lifeText : SKLabelNode?
    
    var score : Int32?
    var coin : Int32?
    var life : Int32?
    func initilizeVriables(){
        if GameManager.instance.gameStartedFromMainMenu{
            GameManager.instance.gameStartedFromMainMenu = false
         score = 0
         coin = 0
         life = 2
         scoreText?.text = "\(score!)"
         coinText?.text = "\(coin!)"
         lifeText?.text = "\(life!)"
        }else if GameManager.instance.gameRestartedPlayerDied{
            GameManager.instance.gameRestartedPlayerDied = false
        
            scoreText?.text = "\(score!)"
            coinText?.text = "\(coin!)"
            lifeText?.text = "\(life!)"
        
        
        
        
        }}
  
    func incrementScore(){
        score! += 1
        scoreText?.text = "\(score!)"
        
    }
    func incrementCoin(){
        coin! += 1
        score! += 200
        
        scoreText?.text = "\(score!)"
        coinText?.text = "\(coin!)"
        
    }
    func incrementLife(){
        life! += 1
        lifeText?.text = "\(life!)"
        
    }

} // Class
