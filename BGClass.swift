//
//  BGClass.swift
//  jack64
//
//  Created by ABD on 12/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import SpriteKit



class BGClass : SKSpriteNode{

    func moveBG(camera : SKCameraNode){
        if self.position.y - self.size.height - 10 > camera.position.y {
             self.position.y -= self.size.height * 3
        
        }
    
    
    
    }

}
