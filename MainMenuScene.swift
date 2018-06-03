//
//  MainMenuScene.swift
//  jack64
//
//  Created by ABD on 16/11/2016.
//  Copyright © 2016 ABD. All rights reserved.


import SpriteKit

import UIKit
import GameKit
import GoogleMobileAds
import UserNotifications




class MainMenuScene: SKScene ,GKGameCenterControllerDelegate ,GADBannerViewDelegate {
    
    var ninga : SKSpriteNode?
    var gamehelp = GameKitHelper()
    private var textureAtlas = SKTextureAtlas()
   
   
    private var NinjaAnimation = [SKTexture]()
    private var animateNinjaAction = SKAction()
            var animateForever = SKAction()
    private var musicBtn = SKSpriteNode()
    private var musicOn = SKTexture(imageNamed: "Music on")
    private var musicOff = SKTexture(imageNamed: "Music off")
    let PresentAuthenticationViewController = "PresentAuthenticationViewController"
    var viewController: GameViewController!
    var googleBannerView: GADBannerView!
    
    
   
    
    
    
    
    
    override func didMove(to view: SKView) {
               
        musicBtn = self.childNode(withName: "Music") as! SKSpriteNode
        animateNinja()
        GameManager.instance.initializeGameData()
        
        //scene?.scaleMode = SKSceneScaleMode.resizeFill
        
        //notification()
        
        
        setMusic()
     //   gamehelp.authenticateLocalPlayer()
        athPlayer()
        
        
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
          let location = touch.location(in: self)
            if atPoint(location).name == "Hiegh" {
                let scene = HighScoreScene(fileNamed: "HightScore")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
                
            }
            if atPoint(location).name == "Start" {
                GameManager.instance.gameStartedFromMainMenu = true
                let scene = GameplayScene(fileNamed: "GamePlayScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
                
                
            }
            
            
            if atPoint(location).name == "Option" {
                let scene = OptionScene(fileNamed: "OptionScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1))
        
        
        
        


            }
            if atPoint(location).name == "CREDITS" {
                let scene = Credits(fileNamed:"Credits")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.8))
            }
            if atPoint(location).name == "Purchase" {
                let scene = Purchase(fileNamed:"Purchase")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.8))
            }
            

             if atPoint(location).name == "Music"{
                handleMusicBottun()
            
            
            
            
            
            }
            if atPoint(location).name == "Game Center"{
                
                
         showGameCenter()
                
                
                
                
            }

        
        
        

    }


    }
    func animateNinja(){
    
        ninga = childNode(withName: "ninja") as! SKSpriteNode?
        textureAtlas = SKTextureAtlas(named: "Player")
        for i in 1...9{
            let name = "Idle__00\(i)"
            
            NinjaAnimation.append(SKTexture(imageNamed : name))
            
        }
        animateNinjaAction = SKAction.animate(with: NinjaAnimation, timePerFrame: 0.08)
        animateForever = SKAction.repeatForever(animateNinjaAction)
        ninga?.run(animateForever)

    
    
    
    }
    private func setMusic(){
        if GameManager.instance.getIsMusicOn(){
            if AudioManager.instance.isAudioPlayerInitialzed(){
                AudioManager.instance.playBGMusic()
                musicBtn.texture = musicOff
            
            }
        
        }
    
      GameManager.instance.saveData()
    
    }
    private func handleMusicBottun(){
        if GameManager.instance.getIsMusicOn() {
           AudioManager.instance.stopBgMusic()
            GameManager.instance.setIsMusicOn(isMusicOn: false)
            musicBtn.texture = musicOn
        
        
        }else {
          AudioManager.instance.playBGMusic()
            GameManager.instance.setIsMusicOn(isMusicOn: true)
            musicBtn.texture = musicOff
        
        
        
        }
         GameManager.instance.saveData()
    
    }
    func athPlayer(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainMenuScene.showAuthenticationViewController), name:NSNotification.Name(rawValue: PresentAuthenticationViewController), object: nil)
        
        
        GameKitHelper.instance.authenticateLocalPlayer()
        
    }
    func showGameCenter(){
        
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        
       self.view?.window?.rootViewController?.present(gcvc, animated: true, completion: nil)
        
        
    }
    
    
   
    @objc func showAuthenticationViewController(){
      let gameKitHelper = GameKitHelper.instance
        if gameKitHelper.authenticationViewController != nil{
            
            self.view?.window?.rootViewController?.present(GameKitHelper.instance.authenticationViewController!, animated: true, completion: nil)
            
                 }
        
        
        }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
//
    func notification(){
        
      
        let center = UNUserNotificationCenter.current()
        let date = Date(timeIntervalSinceNow: 3600)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Let's Play J64"
        content.body = "it's time to Play J64 : ninja jump"
        content.sound = UNNotificationSound.default()
        
       let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
       let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier,content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })

        
        

        
    }
        
        
    }// Class
    
           

    
    

    
   




