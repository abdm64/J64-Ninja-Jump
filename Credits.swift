//
//  Credits.swift
//  jack64
//
//  Created by ABD on 20/01/2017.
//  Copyright © 2017 ABD. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import MessageUI

class Credits : SKScene, MFMailComposeViewControllerDelegate{
    var ninga : SKSpriteNode?
    private var textureAtlas = SKTextureAtlas()
    
    private var NinjaAnimation = [SKTexture]()
    private var animateNinjaAction = SKAction()
    var animateForever = SKAction()
  

    override func didMove(to view: SKView) {
        scene?.scaleMode = SKSceneScaleMode.resizeFill
        animateNinja()
                
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "rate" {
                
                
                // UIApplication.shared.openURL("itms-apps://itunes.apple.com/app/1214494214")
                rateApp()
                UIApplication.shared.openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1214494214")! as URL)
                
                print("app rated")
                
            }


        
        if atPoint(location).name == "Back button" {
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
        }
            if atPoint(location).name == "share" {
                
                
                    let message = "Download the Amazing Game J64 : Ninja Jump from the AppStore : https://appsto.re/fr/gy7yib.i "
                
                    if let link = NSURL(string: "https//itunes.apple.com/app/id1214494214")
                    {
                        let objectsToShare = [message,link] as [Any]
                        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                        self.view?.window?.rootViewController?.present(activityVC, animated: true, completion: nil)
                    }
                print("shared")
            }
               if atPoint(location).name == "contact" {
            
              
                    if MFMailComposeViewController.canSendMail() {
                        let mail = MFMailComposeViewController()
                            mail.mailComposeDelegate = self
                            mail.setToRecipients(["abdm64@icloud.com"])
                            mail.setSubject("J64 Feedback")
                            mail.setMessageBody("Hi J64 Team would I like to share the following feedback .. \n ", isHTML: false)
                       
                        
                        
                        self.view?.window?.rootViewController?.present(mail, animated: true,completion: nil)
                    } else {
                        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
                        sendMailErrorAlert.show()
                        
                } ;
                
                
                    
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
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
       
        controller.dismiss(animated: true, completion: nil)
    }
    
    func rateApp(){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string : "itms-apps://itunes.apple.com/app/id1214494214")!, options: [:]) { (done) in
                // Handle results
                
            }
        } else {
            // Fallback on earlier versions
        }}
} // Class
