//
//  StoreProducts.swift
//  jack64
//
//  Created by ABD on 16/07/2017.
//  Copyright © 2017 ABD. All rights reserved.
//

import Foundation
import StoreKit

struct ProductList {
    
    static let Option01_NonConsumable : String = "com.abdm64.jack64.RemoveAds"
    static let Option01_Consumable : String = "com.abdm64.jack64."
    static let Option02_Consumable : String = "com.abdm64.jack64"
    
    static let products = [Option01_NonConsumable,Option01_Consumable, Option02_Consumable ]
    
    
}
struct ProductDelivery {
    
    static func deliverProduct(product : String) {
        switch product {
        case ProductList.Option01_NonConsumable:
            deliverNonConsumable(identifier: ProductList.Option01_NonConsumable)
        case ProductList.Option01_Consumable :
            deliverConsumableProduct(identifier : ProductList.Option01_Consumable, units: 5)
        case ProductList.Option02_Consumable :
            deliverConsumableProduct(identifier: ProductList.Option02_Consumable, units : 5)
        break
        default:
        break
        }
        
        
    }
    static func deliverNonConsumable(identifier : String) {
        
    UserDefaults.standard.set(true, forKey: identifier)
    UserDefaults.standard.synchronize()
        
        
        
    }
    static func isProductAvailable(identifier : String) -> Bool {
        if  UserDefaults.standard.bool(forKey: identifier) == true {
            return true
        } else {
            return false
        }
    }
    static func  deliverConsumableProduct(identifier : String, units : Int){
        let currectUnits: Int = UserDefaults.standard.integer(forKey: identifier)
        UserDefaults.standard.set(currectUnits + units, forKey: identifier)
        UserDefaults.standard.synchronize()
        
    }
    
    
    static func remainingUnits(identifier : String) -> Int {
        
        return UserDefaults.standard.integer(forKey:identifier)
        
        
        
    }
    
    
    
    
}

