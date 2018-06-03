//
//  OptionScene.swift
//  jack64
//
//  Created by ABD on 16/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
     private var easyBtn: SKSpriteNode?
     private var mediumBtn: SKSpriteNode?
     private var hardBtn: SKSpriteNode?
    
      private var sign : SKSpriteNode?
     
    override func didMove(to view: SKView) {
        scene?.scaleMode = SKSceneScaleMode.resizeFill
        initializeVeriables()
        setSign()
        
        
    }
    
    
    func initializeVeriables(){
        easyBtn = self.childNode(withName: "easy button") as! SKSpriteNode?
        mediumBtn = self.childNode(withName: "normal button") as! SKSpriteNode?
        hardBtn = self.childNode(withName: "Hard button") as! SKSpriteNode?
        sign = self.childNode(withName: "sign") as! SKSpriteNode?
            
    }
    func setSign(){
        if GameManager.instance.getEasyDefficultty() == true {
          sign?.position.y = (easyBtn?.position.y)!
        }else if GameManager.instance.getMediumDefficultty() == true {
          sign?.position.y = (mediumBtn?.position.y)!
        }else if GameManager.instance.getHardDefficultty() == true {
         sign?.position.y = (hardBtn?.position.y)!
        
        }
    
    }
    
    private func setDefficulty(defficulty: String){
        switch (defficulty) {
          case "easy":
            GameManager.instance.setEasyDefficulty(easyDefficulty: true)
            GameManager.instance.setMediumDefficulty(mediumDefficulty: false)
            GameManager.instance.setHardDefficulty(hardDefficulty: false) 
               break
          case "medium":
            GameManager.instance.setEasyDefficulty(easyDefficulty: false)
            GameManager.instance.setMediumDefficulty(mediumDefficulty: true)
            GameManager.instance.setHardDefficulty(hardDefficulty: false)
               break
          case "hard":
            GameManager.instance.setEasyDefficulty(easyDefficulty: false)
            GameManager.instance.setMediumDefficulty(mediumDefficulty: false)
            GameManager.instance.setHardDefficulty(hardDefficulty: true)
               break
         default:
            break
        }
        GameManager.instance.saveData()
    
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "easy button" {
              setDefficulty(defficulty: "easy")
              sign?.position.y = (easyBtn?.position.y)!
            }
            if atPoint(location).name == "normal button" {
                setDefficulty(defficulty: "medium")
                sign?.position.y = (mediumBtn?.position.y)!
            }
            if atPoint(location).name == "Hard button" {
                setDefficulty(defficulty: "hard")
                sign?.position.y = (hardBtn?.position.y)!
            }

            
            
            if atPoint(location).name == "Back button" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
    }

}
}
}
