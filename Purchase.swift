//
//  Purchase.swift
//  jack64
//
//  Created by ABD on 15/07/2017.
//  Copyright © 2017 ABD. All rights reserved.
//

import SpriteKit
import StoreKit
import CloudKit
import UIKit




class Purchase : SKScene {
    
    
    let bundelID = "com.abdm64.jack64"
    
     var activityIndecator : UIActivityIndicatorView = UIActivityIndicatorView()
    var list = [SKProduct]()
    var p = SKProduct()
    
    var product = SKProduct()
    var productID : String?
    var lbale : SKLabelNode?
    var desc : SKLabelNode?
    var removeAdsBtn : SKSpriteNode?
    private var CoinLable : SKLabelNode?
    let id = "com.abdm64.jack64.RemoveAds"
    let addCoinID = "com.abdm64.jack64.Add100Coin"
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "Back button" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
            }
            
            if atPoint(location).name == "ads1" {
                
                print("rem ads")
                for product in list {
                    let prodID = product.productIdentifier
                    if(prodID == "com.abdm64.jack64.RemoveAds") {
                        p = product
                        buyProduct()
                    }
                }
                
            }
             if atPoint(location).name == "restore" {
                StoreManager.instance.restoreRemoveAds { success in
                   // self.activity()
                    if success {
                      // self.activityIndecator.stopAnimating()
                        print("sucess restore")
                        
                        let alert = UIAlertController(title: "Purchases Restored", message: "All purchases have been restored.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                      self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                        
                    }else {
                       // print("Failed")
                      //  self.activityIndecator.stopAnimating()
                        let alert = UIAlertController(title: "Nothing To Restore", message: "No previous purchases were made", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        
                        
                        
                    }
                }
                
           
                
                
                
                
            }
            
        }
    }
    override func didMove(to view: SKView) {
        
        
        getRefrence()
       
        if(SKPaymentQueue.canMakePayments()) {
            print("IAP is enabled, loading")
            let productID: NSSet = NSSet(objects: "com.abdm64.jack64.RemoveAds")
            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            print("please enable IAPS")
        }
        
    }
    private func getRefrence(){
        lbale?.childNode(withName: "labl")
        desc?.childNode(withName: "Description")
        removeAdsBtn?.childNode(withName: "ads")
        CoinLable = self.childNode(withName: "Coin label") as! SKLabelNode?
        CoinLable?.text = String(GameManager.instance.getMediumDefficultyCoinScore())
    }
    func activity(){
        activityIndecator.center = (self.view?.center)!
        activityIndecator.hidesWhenStopped = true
        activityIndecator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view?.addSubview(activityIndecator)
        activityIndecator.startAnimating()
        
        
        
        
    }
    func buyProduct() {
        print("buy " + p.productIdentifier)
        let pay = SKPayment(product: p)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(pay as SKPayment)
    }
    

    /*
   
    let bundelID = "com.abdm64.jack64"
    var removeAds = RegisterPurchase.RemoveAds
    var product = SKProduct()
    var productID : String?
    var lbale : SKLabelNode?
    var desc : SKLabelNode?
    var removeAdsBtn : SKSpriteNode?
    private var CoinLable : SKLabelNode?
   
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "Back button" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.8))
            }
            if atPoint(location).name == "ads" {
                puchase(purchase: removeAds)
            } ; if atPoint(location).name == "restore" {
                
                
                restorePuchases()
                

                
                
            }
            
        }
    }
    override func didMove(to view: SKView) {
        
       
        getRefrence()
        
    }
    private func getRefrence(){
        lbale?.childNode(withName: "labl")
        desc?.childNode(withName: "Description")
        removeAdsBtn?.childNode(withName: "ads")
        CoinLable = self.childNode(withName: "Coin label") as! SKLabelNode?
        CoinLable?.text = String(GameManager.instance.getMediumDefficultyCoinScore())
    }
    func getInfo(purchase : RegisterPurchase) {
        NetworkIndicaterManager.NetworkOperationStarted()
        SwiftyStoreKit.retrieveProductsInfo([bundelID + "."+purchase.rawValue], completion: {
            result in
             NetworkIndicaterManager.NetworkOperationFinish()
            
        })
    }
    func puchase(purchase : RegisterPurchase){
        NetworkIndicaterManager.NetworkOperationStarted()
         SwiftyStoreKit.purchaseProduct(bundelID + "."+purchase.rawValue, completion: {
            result in
            NetworkIndicaterManager.NetworkOperationFinish()
            if case .success(let product) = result {
                
                if product.productId == self.bundelID + "." + "10Dolla"{
                    
                    
                    
                }
                if product.productId == self.bundelID + "." + "RemoveAds" {
                    let save = UserDefaults.standard
                    save.set(true, forKey: "Purchase")
                    save.synchronize()
                    
                    self.iCloudSetUp()
                   
                }
                
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.showAlert(alert: self.alertPurchaseResult(result: result))
            }
            
            
        })
        
            
            
        }
    
        
        
        
    
    func restorePuchases(){
        NetworkIndicaterManager.NetworkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true, completion: {
            result in
            NetworkIndicaterManager.NetworkOperationFinish()
            for product in result.restoredProducts {
                if product.needsFinishTransaction {
                    
                    SwiftyStoreKit.finishTransaction(product.transaction)
                
                    
                }
            }
            self.showAlert(alert: self.alertForRestorePurchases(result: result))
        })
        
        
        
    }
    func verfyRecipt(){
        NetworkIndicaterManager.NetworkOperationStarted()
        SwiftyStoreKit.verifyReceipt(using: sharedSecret as! ReceiptValidator,  completion: {
            result in
            NetworkIndicaterManager.NetworkOperationFinish()
            self.showAlert(alert: self.alertVerfyReceipt(result: result))
            if case .error(let error) = result  {
                if case .noReceiptData = error {
                    self.refreshReceipt()
                    
                }
                
                
            }
            
        })
        
        
        
    }
    func verfiyPurchase(product : RegisterPurchase){
        NetworkIndicaterManager.NetworkOperationStarted()
        SwiftyStoreKit.verifyReceipt(using: sharedSecret as! ReceiptValidator,  completion: {
            result in
            NetworkIndicaterManager.NetworkOperationFinish()
            switch result {
            case .success(let receipt) :
                let productID = self.bundelID + "."+product.rawValue
                if  product == .autoRenw {
                    let purchaseResult = SwiftyStoreKit.verifySubscription( type: .autoRenewable, productId: productID, inReceipt: receipt, validUntil: Date())
                    
                    self.showAlert(alert: self.alertForVerfiySubscription(result: purchaseResult))
                    
                    
                } else  {
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productID, inReceipt: receipt)
                    self.showAlert(alert: self.alertForVerfiyPurchase(result: purchaseResult))
               
                    
                }
            case .error(let error) :
                self.showAlert(alert: self.alertVerfyReceipt(result: result))
                if case .noReceiptData = error {
                    
                    self.refreshReceipt()
                    
                    
                }
                
                
                
                
            }
            
        })
        
        
    }
    func refreshReceipt(){
        SwiftyStoreKit.refreshReceipt(completion: {
            result in
            
            self.showAlert(alert: self.alertForRefrashReceipt(result: result))
            
        })
        
        
    }
    func iCloudSetUp(){
        let keyStore =  NSUbiquitousKeyValueStore.default
        keyStore.set(true, forKey: "Purchased")
        keyStore.synchronize()
        
        
    }
    
    
    
    */
    
}// Class


























