//
//  extention.swift
//  jack64
//
//  Created by ABD on 07/08/2017.
//  Copyright © 2017 ABD. All rights reserved.
//

import Foundation
import StoreKit
//import SwiftyStoreKit



extension Purchase : SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("add payment")
        
        for transaction: AnyObject in transactions {
            let trans = transaction as! SKPaymentTransaction
            print(trans.error)
            
            switch trans.transactionState {
            case .purchased:
                print("buy ok, unlock IAP HERE")
                print(p.productIdentifier)
                
                let prodID = p.productIdentifier
                switch prodID {
                case "com.abdm64.jack64.RemoveAds":
                    print("remove ads")
                    UserDefaults.standard.set(true, forKey: id)
                case "seemu.iap.addcoins":
                    print("add coins to account")
                    
                default:
                    print("IAP not found")
                }
                queue.finishTransaction(trans)
            case .failed:
                print("buy error")
                queue.finishTransaction(trans)
                break
            default:
                print("Default")
                break
            }
        }
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("product request")
        let myProduct = response.products
        for product in myProduct {
            print("product added")
            print(product.productIdentifier)
            print(product.localizedTitle)
            print(product.localizedDescription)
            print(product.price)
            
            list.append(product)
        }
        
       
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transactions restored")
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            
            switch prodID {
            case "com.abdm64.jack64.RemoveAds":
                print("remove ads")
                UserDefaults.standard.set(true, forKey: id)
               
            case "seemu.iap.addcoins":
                print("add coins to account")
                
            default:
                print("IAP not found")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
  
   func alertWitTitle (title : String , message : String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        
        
        return alert
    }
    func showAlert(alert : UIAlertController){
        guard let _ = self.view?.window?.rootViewController?.presentedViewController else {
            
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    func alertForProductRetriveInfo(result : RetrieveResults) -> UIAlertController{
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            
            
            return alertWitTitle(title: product.localizedTitle, message: "\(product.localizedDescription)- \(priceString)")
            
        } else if let invalidProductID = result.invalidProductIDs.first {
            
            return alertWitTitle(title: "Error", message: "Invalid Product ID\(invalidProductID)")
            
            
        } else {
            let error = result.error?.localizedDescription ?? "Conact Support"
            return alertWitTitle(title: "Error", message: error)
        }
    }
    
    func alertPurchaseResult(result : PurchaseResult) -> UIAlertController{
        switch result {
        case .success(let product):
            print("Purchase Succesful: \(product.productId)")
            
            return alertWitTitle(title: "Thank You", message: "Purchase completed")
        case .error(let error):
            print("Purchase Failed: \(error)")
            return alertWitTitle(title: "Error", message: "Purchase Failed: \(error)")
        }
    }
    func alertForRestorePurchases(result : RestoreResults) -> UIAlertController{
        if result.restoreFailedProducts.count > 0 {
            print ("Failed Restore \(result.restoreFailedProducts)")
            
            return alertWitTitle(title: "Restore Failed", message: "Please Contact Support")
            
        } else if result.restoredProducts.count > 0  {
            let save = UserDefaults.standard
            save.set(true, forKey: "Purchase")
            save.synchronize()
            
            self.iCloudSetUp()
            
            return alertWitTitle(title: "Purchases Restored", message: "All purchases have been restored.")
            
        } else   {
            
            print("Nothing to restore")
            
            return alertWitTitle(title: "Nothing To Restore", message: "No previous purchases were made.")
        }
        
        
        
    }
    func alertVerfyReceipt(result : VerifyReceiptResult) -> UIAlertController{
        switch result {
        case .success(let receipt) :
            return alertWitTitle(title:"Receipt is Verfid" , message:"Receipt Verfied Remotly" )
        case .error(let error) :
            switch error {
            case .noReceiptData :
                return alertWitTitle(title:"Receipt Verfication" , message:"No Receipt Data Found Application will try to get new one Try Again" )
            default :
                return alertWitTitle(title:"Receipt Verfication" , message:"Receipt Verfication Failed" )
                
            }
        }
        
        
        
    }
    func alertForVerfiySubscription(result : VerifySubscriptionResult)-> UIAlertController {
        switch result {
        case .purchased(let expiryDate) :
            
            return alertWitTitle(title: "Product is Puchased", message: "Product will be valide until\(expiryDate) ")
        case .notPurchased :
            return alertWitTitle(title: "Not Puchased" , message: "This Product has never Puchased")
        case .expired(let expiryDate) :
            return alertWitTitle(title: "Subscription has expired", message: "date of expiration : \(expiryDate)")
        }
        
        
        
    }
    
    func alertForVerfiyPurchase(result : VerifyPurchaseResult) -> UIAlertController {
        switch result {
        case .purchased:
            return alertWitTitle(title: "Product is Purchased", message:"Product will not expire")
        case .notPurchased:
            return alertWitTitle(title: "Product is not Purchased", message:"Product has never been Purchased")
            
        }
    }
    
    func alertForRefrashReceipt(result : RefreshReceiptResult) -> UIAlertController  {
        switch result {
        case .success(let receiptData):
            return alertWitTitle(title: "Receipt Refreshed", message: "Receipt Refresh succcefully")
        case .error(let error) :
            return alertWitTitle(title: "Receipt Refresh Failed", message: "Receipt Refresh Failed")
            
        }
        
        
        
        
    }
    
    */
    
} // extention


