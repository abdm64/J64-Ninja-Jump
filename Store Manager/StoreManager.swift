//
//  StoreManager.swift
//  jack64
//
//  Created by ABD on 02/10/2017.
//  Copyright © 2017 ABD. All rights reserved.
//


typealias ComplitionHandler = (_ success : Bool) -> ()


import Foundation
import StoreKit


class StoreManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let instance = StoreManager()
    
    let id = "com.abdm64.jack64.RemoveAds"
    var productsRequset : SKProductsRequest!
    var products = [SKProduct]()
    var transactionComplete : ComplitionHandler?
    
    
    func fetchProduct(){
        let productID = NSSet(object: id) as! Set<String>
        productsRequset = SKProductsRequest(productIdentifiers: productID)
        productsRequset.delegate = self
        productsRequset.start()
        
    }
    
    func purchaseRemoveAds(onComplete : @escaping ComplitionHandler){
        if SKPaymentQueue.canMakePayments() && products.count > 0 {
            transactionComplete = onComplete
            let removeAdsProduct = products[0]
            let payment = SKPayment(product: removeAdsProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            
        } else {
            onComplete(false)
            
            
            
        }
        
        
        
    }
    
    func restoreRemoveAds(onComplete : @escaping ComplitionHandler){
        if SKPaymentQueue.canMakePayments() {
            transactionComplete = onComplete
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
            
            
        } else {
            onComplete(false)
            
            
        }
        
        
        
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.products.count > 0 {
            
            products = response.products
          
            
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased :
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == id {
                    UserDefaults.standard.set(true, forKey: id)
                    transactionComplete?(true)
                    
                }
                break
            case .failed :
                SKPaymentQueue.default().finishTransaction(transaction)
                transactionComplete?(false)
                break
            case .restored :
                SKPaymentQueue.default().finishTransaction(transaction)
                if transaction.payment.productIdentifier == id {
                    UserDefaults.standard.set(true, forKey: id)
                }
                transactionComplete?(true)
                break
            default :
                transactionComplete?(false)
                break
                
                
                
                
            }
            
        }
        
    }
    
    
}//Class
