//
//  HighscoreScene.swift
//  jack64
//
//  Created by ABD on 16/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import SpriteKit



class HighScoreScene: SKScene {
    private var scoreLabel : SKLabelNode?
    private var CoinLable : SKLabelNode?
    
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = SKSceneScaleMode.resizeFill
         getRefrence()
         setScore()
        
        
    }
    
    private func getRefrence(){
      scoreLabel = self.childNode(withName: "Score label") as! SKLabelNode?
      CoinLable = self.childNode(withName: "Coin label") as! SKLabelNode?
    }
    
    private func setScore(){
        if GameManager.instance.getEasyDefficultty() == true {
            scoreLabel?.text = String(GameManager.instance.getEasyDefficultyScore() )
            CoinLable?.text = String(GameManager.instance.getEasyDefficultyCoinScore())
            GameKitHelper.instance.saveHighScore(identifier: "Easy", score: Int(GameManager.instance.getEasyDefficultyScore()))
        
        } else if GameManager.instance.getMediumDefficultty() == true {
        
            scoreLabel?.text = String(GameManager.instance.getMediumDefficultyScore() )
            CoinLable?.text = String(GameManager.instance.getMediumDefficultyCoinScore())
            GameKitHelper.instance.saveHighScore(identifier: "Medium", score: Int(GameManager.instance.getMediumDefficultyScore()))
        
        } else if GameManager.instance.getHardDefficultty() == true {
            
            scoreLabel?.text = String(GameManager.instance.getHardDefficultyScore() )
            CoinLable?.text = String(GameManager.instance.getHardDefficultyCoinScore())
            GameKitHelper.instance.saveHighScore(identifier: "Hard", score: Int(GameManager.instance.getHardDefficultyScore()))
        
        
        }
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "Back Button" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
                
                
            }
    
    
        }
    
    
    
    }


}
