//
//  GameplayScene.swift
//  jack64
//
//  Created by ABD on 11/11/2016.
//  Copyright © 2016 ABD. All rights reserved.


import SpriteKit
import GameKit
import AudioToolbox
import Social
import UIKit


class GameplayScene: SKScene,SKPhysicsContactDelegate  {
    
    var groundController = GroundController();
    var kunaiController = KunaiController();
    var social = Social()
    var pause : SKSpriteNode?
    var mainCamera : SKCameraNode?
    var bg1 : BGClass?
    var bg2 : BGClass?
    var bg3 : BGClass?
    var Player : Player?
    var canMove = false
    var moveLeft = false
    var center : CGFloat?
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    var scoreLabel = SKLabelNode()
    var touchOrigin = CGPoint()

 
    
    private var camerdestance = CGFloat()
    let distanceBetweenGround = CGFloat(250)
    private let MinPlayerX = CGFloat(-208)
    private let MaxPlayerX = CGFloat(205)
    let minX = CGFloat(-180)
    let maxX = CGFloat(180)
    private var PausePanel : SKSpriteNode?
    private var endScorePanal : SKSpriteNode?
    private let gameOverSound = SKAudioNode(fileNamed: "game_over.wav")
     var swipeRightRec = UISwipeGestureRecognizer(target: self , action: #selector(GameplayScene.swipeRight))
     var swipeLeftRec = UISwipeGestureRecognizer(target: self, action: #selector(GameplayScene.swipeLeft))
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = SKSceneScaleMode.resizeFill
        initializeVeriable()
//        self.view?.addGestureRecognizer(swipeLeftRec)
//        self.view?.addGestureRecognizer(swipeRightRec)
      
       
        
        
     // NotificationCenter.default.post(name: NSNotification.Name(rawValue:"gameStateOff"), object: nil)
        
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            var currentTouchPosition = touch.location(in: self)
            touchOrigin = touch.location(in: self)
            

            
        
        
        
        
        }
        
        
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        manageBackground()
        manageCamera()
        managePlayer()
        creatNewGround()
        checkGroundInScreeen()
        moveKunai()

         Player?.setScore()
        
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secendBody = SKPhysicsBody()
        if contact.bodyA.node?.name == "Player"{
         firstBody = contact.bodyA
         secendBody = contact.bodyB
        
        
        }else{
            firstBody = contact.bodyB
            secendBody = contact.bodyA
        }
        if firstBody.node?.name == "Player" && secendBody.node?.name == "Coin" {
        // play the sound of coin
            if  GameManager.instance.getIsMusicOn(){
          self.run(SKAction.playSoundFileNamed("Coin-8Bit.wav", waitForCompletion: false))
        }
             //
            
           GamePlayController.instace.incrementCoin()
           secendBody.node?.removeFromParent()
            if ((GamePlayController.instace.score!) % 50 == 0 ){
                
                GamePlayController.instace.incrementLife()
            }
            
            
          
        
        }else if firstBody.node?.name == "Player" && secendBody.node?.name == "DarkGround" || secendBody.node?.name == "Kunai1" {
          // Kill the Player
             AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.scene?.isPaused = true
            GamePlayController.instace.life! -= 1
            if GamePlayController.instace.life! >= 0{
            GamePlayController.instace.lifeText?.text = String(GamePlayController.instace.life!)
            
            } else {
               
                createEndPanal()
                pause?.removeFromParent()
                
                
            
            }
            firstBody.node?.removeFromParent()
            
           
            playerDied()
            pause?.removeFromParent()
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches{
          let location = touch.location(in: self)
            if self.scene?.isPaused == false {
                if location.x > center! {
                    moveLeft = false
                    Player?.animatePlayer(moveLeft: moveLeft)
                }else{
                    
                    moveLeft = true
                    Player?.animatePlayer(moveLeft: moveLeft)
                }
            
            
            }
            
           
            if atPoint(location).name == "Pause"{
             self.scene?.isPaused = true
            
                createPausePanel()
            }
            if atPoint(location).name == "Resume"{
                PausePanel?.removeFromParent()
                self.scene?.isPaused = false
                
                
            }
            if atPoint(location).name == "Quit"{
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
                
                
                
            }; if atPoint(location).name == "Restart"{
                GameManager.instance.gameStartedFromMainMenu = true
                let scene = GameplayScene(fileNamed: "GamePlayScene")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
                
                
                
                
            }; if atPoint(location).name == "share"{
                
                share()
                
                
            } ; if atPoint(location).name == "FB"{
                
                shareFB()
                
                
            } ;if atPoint(location).name == "Twitt"{
                
                shareTwitter()
                
                
            }

            
            
        
        }
        
        canMove = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        Player?.stopAnimatePlayer()
    }
    
    func initializeVeriable(){
    
        physicsWorld.contactDelegate = self
        center = ((self.scene?.size.width)! / (self.scene?.size.height)!);
        Player = childNode(withName: "Player") as? Player!
        Player?.initializePlayerAndAnimation()
        Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(GameplayScene.removeItems), userInfo: nil, repeats: true)
        
        timerKunai()
        pause = self.childNode(withName: "Pause") as? SKSpriteNode
       
        
       
        mainCamera = self.childNode(withName: " Main Camera") as! SKCameraNode?
        getBackground()
        getLabls()
        GamePlayController.instace.initilizeVriables()
        
        
        groundController.arrangeGroundInScene(scene: self.scene!, distanceBetweenGrounds: distanceBetweenGround, center: center!, minX: minX, maxX: maxX, initialGround: true)
        camerdestance = (mainCamera?.position.y)! - 400 ;
         setCameraSpeed()
        
    }
    
    func getBackground(){
       bg1 = self.childNode(withName: "BG 1") as! BGClass?
       bg2 = self.childNode(withName: "BG 2") as! BGClass?
       bg3 = self.childNode(withName: "BG 3") as! BGClass?
        bg1?.name = "BG 1"
        bg2?.name = "BG 2"
        bg3?.name = "BG 3"
    
    
    }
    func managePlayer(){
        
        if canMove {
            
            Player?.MovePlayer(moveLeft: moveLeft)
            
        }
        if (Player?.position.x)! < MinPlayerX{
        Player?.position.x = MinPlayerX
        
        }
        if (Player?.position.x)! > MaxPlayerX{
        Player?.position.x = MaxPlayerX
        
        }
        
        if (Player?.position.y)!  - (Player?.size.height )! * 6.0 > (mainCamera?.position.y)! {
           self.scene?.isPaused = true
            GamePlayController.instace.life! -= 1
            if GamePlayController.instace.life! >= 0{
                GamePlayController.instace.lifeText?.text = String(GamePlayController.instace.life!)
                
            } else {
               
                createEndPanal()
               // AudioManager.instance.stopBgMusic()
                 self.run(SKAction.playSoundFileNamed("game_over.wav", waitForCompletion: false))
                
                
            }
         
            Timer.scheduledTimer(timeInterval: (0.1), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        
        
        }
        if (Player?.position.y)!  + (Player?.size.height )! * 6.0 < (mainCamera?.position.y)! {
            self.scene?.isPaused = true
            GamePlayController.instace.life! -= 1
            if GamePlayController.instace.life! >= 0{
                GamePlayController.instace.lifeText?.text = String(GamePlayController.instace.life!)
                
            } else {
              
               createEndPanal()
              //  AudioManager.instance.stopBgMusic()
                self.run(SKAction.playSoundFileNamed("game_over.wav", waitForCompletion: false))

                
            }
            
            Timer.scheduledTimer(timeInterval: (0.05), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
            
            
        }
        
    }
    func manageCamera(){
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
          cameraSpeed = maxSpeed
        
        }
        self.mainCamera?.position.y -= cameraSpeed
        
    }
    
    func manageBackground(){
          bg1?.moveBG(camera: mainCamera!)
      

          bg2?.moveBG(camera: mainCamera!)
        
        
          bg3?.moveBG(camera: mainCamera!)
        
    
    }
    func creatNewGround(){
        if camerdestance > (mainCamera?.position.y)!{
           camerdestance = (mainCamera?.position.y)! - 400
        
         groundController.arrangeGroundInScene(scene: self.scene!, distanceBetweenGrounds: distanceBetweenGround, center: center!, minX: minX, maxX: maxX, initialGround: false)
          
        }
        
        
            }
    func checkGroundInScreeen(){
        
        for child in children {
        
            if child.position.y > (mainCamera?.position.y)! + ((self.scene?.size.height)!) {
               let childName = child.name?.components(separatedBy: " ")
                if childName?[0] != "BG"{
                    child.removeFromParent();
                
                
                }
                
            
            }
        
        
        
        }
       
        
    }
    

    func getLabls(){
        GamePlayController.instace.scoreText = self.mainCamera?.childNode(withName: "Score text") as! SKLabelNode?
        GamePlayController.instace.coinText = self.mainCamera?.childNode(withName: "Coin Score") as! SKLabelNode?
        GamePlayController.instace.lifeText = self.mainCamera?.childNode(withName: "life Score") as! SKLabelNode?
        
    
    
    
    
    
    }
    
    func createPausePanel(){
       
        

        PausePanel = SKSpriteNode(imageNamed: "PAUSE")
        let ResumeBtn = SKSpriteNode(imageNamed: "RESUME")
        let QuitBtn = SKSpriteNode(imageNamed: "QUIT")
        
        
        PausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        PausePanel?.xScale = 1.45
        PausePanel?.yScale = 1.45
        PausePanel?.zPosition = 4
        PausePanel?.alpha = 0.85
        PausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2 )
        
        ResumeBtn.name = "Resume"
        ResumeBtn.zPosition = 5
        ResumeBtn.xScale = 0.8
        ResumeBtn.alpha = 1.2
        ResumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ResumeBtn.position = CGPoint(x: (PausePanel?.position.x)!, y: (PausePanel?.position.y)! + 25)
        
        QuitBtn.name = "Quit"
        QuitBtn.zPosition = 5
        QuitBtn.xScale = 0.8
        QuitBtn.alpha = 1.2
        QuitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        QuitBtn.position = CGPoint(x: (PausePanel?.position.x)!, y: (PausePanel?.position.y)!-45)
        
        PausePanel?.addChild(ResumeBtn)
        PausePanel?.addChild(QuitBtn)
        
        self.mainCamera?.addChild(PausePanel!)
        
    }
    
    func createEndPanal(){
        
        endScorePanal = SKSpriteNode(imageNamed: "GameEndPanl.png")
        let RestartBtn = SKSpriteNode(imageNamed: "Restart.png")
        let QuitBtn = SKSpriteNode(imageNamed: "QUIT")
        let TwittBtn = SKSpriteNode(imageNamed: "Twitter")
        let FbBtn = SKSpriteNode(imageNamed: "FB")
        let shareBtn = SKSpriteNode(imageNamed: "Share")
        
        endScorePanal?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanal?.zPosition = 4
        endScorePanal?.xScale = 1.45
        endScorePanal?.yScale = 1.45
        endScorePanal?.alpha = 0.85
        
        scoreLabel.fontSize = 26
      
        scoreLabel.fontName = "kenvector_future.ttf"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.position = CGPoint(x: (endScorePanal?.position.x)!, y: (endScorePanal?.position.y)! + 30)
        
       
        scoreLabel.zPosition = 9
        scoreLabel.text = String(GamePlayController.instace.score!)
        endScorePanal?.addChild(scoreLabel)
        
        RestartBtn.name = "Restart"
        RestartBtn.zPosition = 5
        RestartBtn.xScale = 0.8
        RestartBtn.alpha = 1.2
        RestartBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        RestartBtn.position = CGPoint(x: (endScorePanal?.position.x)!, y: (endScorePanal?.position.y)! )
        endScorePanal?.addChild(RestartBtn)
        
        QuitBtn.name = "Quit"
        QuitBtn.zPosition = 5
        QuitBtn.xScale = 0.8
        QuitBtn.alpha = 1.2
        QuitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        QuitBtn.position = CGPoint(x: (endScorePanal?.position.x)!, y: (endScorePanal?.position.y)! - 50)
        endScorePanal?.addChild(QuitBtn)
        
        shareBtn.name = "share"
        shareBtn.zPosition = 5
        shareBtn.xScale = 0.45
        shareBtn.yScale = 0.45
        shareBtn.alpha = 1
        shareBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shareBtn.position = CGPoint(x: (endScorePanal?.position.x)!, y: (endScorePanal?.position.y)! - 125)
        endScorePanal?.addChild(shareBtn)
        
        
        
        pause?.removeFromParent()
        
        
        
        
        
        
        
        
        
        TwittBtn.name = "Twitt"
        TwittBtn.zPosition = 5
        TwittBtn.xScale = 0.45
        TwittBtn.yScale = 0.44
        TwittBtn.alpha = 1.2
        TwittBtn.color = UIColor.white
        TwittBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        TwittBtn.position = CGPoint(x: ((endScorePanal?.position.x)! - 70), y: (endScorePanal?.position.y)! - 125)
        endScorePanal?.addChild(TwittBtn)

        FbBtn.name = "FB"
        FbBtn.zPosition = 5
        FbBtn.xScale = 0.45
        FbBtn.yScale = 0.44

        FbBtn.alpha = 1.2
        FbBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        FbBtn.position = CGPoint(x: ((endScorePanal?.position.x)! + 70), y: (endScorePanal?.position.y)! - 125)
        endScorePanal?.addChild(FbBtn)
        

       
       
       
        endScorePanal?.position = CGPoint(x: (mainCamera?.frame.size.width)! / 2, y: (mainCamera?.frame.size.height)!/2)
        
         self.run(SKAction.playSoundFileNamed("game_over.wav", waitForCompletion: false))
        mainCamera?.addChild(endScorePanal!)
       
    }

    private func setCameraSpeed(){
    
        if GameManager.instance.getEasyDefficultty(){
          acceleration = 0.005
          cameraSpeed = 2.0
          maxSpeed = 3.8
        
        
        } else if GameManager.instance.getMediumDefficultty(){
            acceleration = 0.01
            cameraSpeed = 3
            maxSpeed = 4
        
        
        } else if GameManager.instance.getHardDefficultty() {
            acceleration = 0.02
            cameraSpeed = 4
            maxSpeed = 5.8
        
        
        
        }
    
    
    }
    @objc func playerDied(){
        if GamePlayController.instace.life! >= 0{
            GameManager.instance.gameRestartedPlayerDied = true
            let scene = GameplayScene(fileNamed: "GamePlayScene")
            scene?.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.7))
        
        
        } else  {
            if GameManager.instance.getEasyDefficultty() {
              let highScore = GameManager.instance.getEasyDefficultyScore()
              let coinScore = GameManager.instance.getEasyDefficultyCoinScore()
                if highScore < GamePlayController.instace.score! {
                 GameManager.instance.setEasyDefficultyScore(easyDefficultyScore: GamePlayController.instace.score!)
                    GameKitHelper.instance.saveHighScore(identifier: "Easy", score: Int(GamePlayController.instace.score!))
                }
                if coinScore < GamePlayController.instace.coin! {
                  GameManager.instance.setEasyDefficultyCoinScore(easyDefficultyCoinScore: GamePlayController.instace.coin!)
                
                }
            
            
            } else if GameManager.instance.getMediumDefficultty() {
                let highScore = GameManager.instance.getMediumDefficultyScore()
                let coinScore = GameManager.instance.getMediumDefficultyCoinScore()
                if highScore < GamePlayController.instace.score! {
                 GameManager.instance.setMediumDefficultyScore(mediumDefficultyScore: GamePlayController.instace.score!)
                     GameKitHelper.instance.saveHighScore(identifier: "Medium", score: Int(GamePlayController.instace.score!))
                }
                if coinScore < GamePlayController.instace.coin! {
                 GameManager.instance.setMediumDefficultyCoinScore(mediumDefficultyCoinScore: GamePlayController.instace.coin!)
                
                
                
                }
                
                
                
            
            } else if GameManager.instance.getHardDefficultty(){
              let highScore = GameManager.instance.getHardDefficultyScore()
              let coinScore = GameManager.instance.getHardDefficultyCoinScore()
                if highScore < GamePlayController.instace.score! {
                  GameManager.instance.setHardDefficultyScore(hardDefficultyScore: GamePlayController.instace.score!)
                    GameKitHelper.instance.saveHighScore(identifier: "Hard", score: Int(GamePlayController.instace.score!))
                    
                    }
                if coinScore < GamePlayController.instace.coin! {
                 GameManager.instance.setHardDefficultyCoinScore(hardDefficultyCoinScore: GamePlayController.instace.coin!)
                
                
                }
            
            
            
            
            
            }
        
        
            GameManager.instance.saveData()
          
           self.scene?.isPaused = true
        
        }
    
    
    
    
    }
    func pauseTheGame(){
    
    self.scene?.isPaused = true
    
    }
    func resumeTheGame(){
        
    self.scene?.isPaused = false
    
    
    }
    
    
    @objc func removeItems(){
        for child in children {
            if child.name == "1" || child.name == "2" || child.name == "3" || child.name == "DarkGround" || child.name == "Kunai1"{
                
                if child.position.y > (mainCamera?.position.y)! + ((self.scene?.size.height)!) {
                    
                    child.removeFromParent()
                    
                    
                }
                
                
            }
            
            
            
            
        }
        
        
        
        
    }
  @objc func spownKunai(){
        
        self.scene?.addChild((kunaiController.spawnKunai(camera: mainCamera!)))
        
        
        
        
    }
    

    private func moveKunai(){
        enumerateChildNodes(withName: "Kunai1", using: ({
            (node, Error) in
            
           
            if GameManager.instance.getEasyDefficultty(){
                
                node.position.y += 4
                
            } else if GameManager.instance.getMediumDefficultty(){
                
                node.position.y += 5.5

                
            } else if GameManager.instance.getHardDefficultty() {
                
                node.position.y += 10

                          }
            
        }))
        
        
        
    }
    
    func timerKunai(){
        
        if self.scene?.isPaused == false {
            
    
        
        if GameManager.instance.getEasyDefficultty(){
            
            Timer.scheduledTimer(timeInterval: TimeInterval(TimeInterval(kunaiController.randomBetweenNumbers(firstNum: 2, secendNum: 4))), target: self, selector: #selector(GameplayScene.spownKunai), userInfo: nil, repeats: true)
            
        } else if GameManager.instance.getMediumDefficultty(){
            
            
            Timer.scheduledTimer(timeInterval: TimeInterval(TimeInterval(kunaiController.randomBetweenNumbers(firstNum: 2, secendNum: 4))), target: self, selector: #selector(GameplayScene.spownKunai), userInfo: nil, repeats: true)
            
        } else if GameManager.instance.getHardDefficultty() {
            
            
            Timer.scheduledTimer(timeInterval: TimeInterval(TimeInterval(kunaiController.randomBetweenNumbers(firstNum: 1, secendNum: 1.5))), target: self, selector: #selector(GameplayScene.spownKunai), userInfo: nil, repeats: true)
            
        }
    
        }
    }
    func shareFB(){
        let post = SLComposeViewController(forServiceType:SLServiceTypeFacebook)!
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
        {
           // post.add(URL(string: "https//itunes.apple.com/app/id1214494214"))
            post.setInitialText("My Score on J64 game is : "+String(GamePlayController.instace.score!)+" Download From Here : https://appsto.re/fr/gy7yib.i ")
            self.view?.window?.rootViewController?.present(post, animated: true, completion: nil)
        } else {
            self.showAlert(service: "Facebook")
        }
        
        
        
        
    }
    func shareTwitter(){
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let vc = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
          //  vc?.add(URL(string: "https//itunes.apple.com/app/id1214494214"))
            vc?.setInitialText("My Score on J64 game is : "+String(GamePlayController.instace.score!)+" Download From Here : https://appsto.re/fr/gy7yib.i ")
            self.view?.window?.rootViewController?.present(vc!, animated: true, completion: nil)
        } else {
            
            self.showAlert(service: "Twitter")
        }
        
        
    }
    
    func showAlert(service:String)
    {
        let alert = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func share(){
        let message = ("My Score on J64 game is : "+String(GamePlayController.instace.score!)+" Download From Here : https://appsto.re/fr/gy7yib.i ")
        
        if let link = NSURL(string: "https//itunes.apple.com/app/id1214494214")
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.view?.window?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
        
        
        
    }
    
    
        
    @objc func swipeLeft(){
      //  moveLeft = false
        Player?.animatePlayer(moveLeft: moveLeft)
        print("Left")
    }
    @objc func swipeRight(){
    
    
      //  moveLeft = true
        Player?.animatePlayer(moveLeft: moveLeft)

         print("Right")
        
    
    }
   





}//Class









