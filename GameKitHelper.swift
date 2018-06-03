//
//  GameKitHelper.swift
//  jack64
//
//  Created by ABD on 16/12/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import Foundation
import UIKit
import GameKit




class GameKitHelper: SKScene , GKGameCenterControllerDelegate {
    
    
    let PresentAuthenticationViewController = "PresentAuthenticationViewController"
    
    static let instance = GameKitHelper()
    var authenticationViewController: UIViewController?
    var gameCenterEnabled = false
    
    func authenticateLocalPlayer() {
        //1
        let localPlayer = GKLocalPlayer()
        localPlayer.authenticateHandler = {(viewController, error) in
            if viewController != nil {
                //2
                self.authenticationViewController = viewController
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: self.PresentAuthenticationViewController), object: self)
            } else if error == nil {
                //3
                self.gameCenterEnabled = true
            }
        } }
    func saveHighScore(identifier : String , score :Int){
        if (GKLocalPlayer.localPlayer().isAuthenticated){
            let scoreReporter = GKScore(leaderboardIdentifier: identifier)
            scoreReporter.value = Int64(score)
            let scoreArray:[GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: {
              error -> Void in
            
                if error != nil {
                 print("ERROR")
                
                
                
                }else{
                print("Score Posted")
                
                }
            
            
            
            
            
        })
    
    
    
    
        }


    }
    func showGameCenter(){
        
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        
        self.view?.window?.rootViewController?.present(gcvc, animated: true, completion: nil)
        
        
    }

    func athPlayer(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameKitHelper.showAuthenticationViewController), name:NSNotification.Name(rawValue: PresentAuthenticationViewController), object: nil)
        
        
        GameKitHelper.instance.authenticateLocalPlayer()
        
    }
    @objc func showAuthenticationViewController(){
        let gameKitHelper = GameKitHelper.instance
        if gameKitHelper.authenticationViewController != nil{
            
            self.view?.window?.rootViewController?.present(authenticationViewController!, animated: true, completion: nil)
            
        }
        
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

}
