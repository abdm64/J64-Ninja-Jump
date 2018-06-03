//
//  GameViewController.swift
//  jack64
//
//  Created by ABD on 09/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
import UserNotifications



class GameViewController: UIViewController , GADBannerViewDelegate {
    var googleBannerView: GADBannerView!
    let  id = "com.abdm64.jack64.RemoveAds"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        removeAds()
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (auth, error) in
            if !auth {
                print("app is not allow to Use notifiation")
                
            }
        }
        
                
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = MainMenuScene(fileNamed: "MainMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill   
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
        notification()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    func admobe(){
        
        googleBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        googleBannerView.adUnitID = "ca-app-pub-1405683736226327/5742676896"
        
        googleBannerView.rootViewController = self
        let request: GADRequest = GADRequest()
        googleBannerView.load(request)
//        googleBannerView.frame = CGRect(x: 0, y: (view.bounds.height - googleBannerView.frame.size.height), width: googleBannerView.frame.size.width, height: googleBannerView.frame.size.height)
        
        self.view.addSubview(googleBannerView!)
    }
    
//    func showAd(notif: NSNotification) {
//        // this func places the ad to the bottom of the screen
//        var frame = googleBannerView.frame
//        frame.origin.x = view.bounds.width / 2 - frame.size.width / 2
//        frame.origin.y = view.bounds.height - frame.size.height
//        googleBannerView.frame = frame
//    }
//
//      func hideAd(notif: NSNotification) {
//        // this func places the ad outside the screen
//        var frame = googleBannerView.frame
//        frame.origin.x = view.bounds.width / 2 - frame.size.width / 2
//        frame.origin.y = -frame.size.height
//        googleBannerView.frame = frame
//    }
    override func viewWillAppear(_ animated: Bool) {
           
            
        }
 
    
    
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
    
    
    func removeAds(){
        
        
        let save = UserDefaults.standard
        
        if save.value(forKey: id) == nil  {
            
            admobe()
            
            
            
            
            
            
        }
        
        
    }
    
    }
    
   

