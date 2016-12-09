//
//  Extensions.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-09.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation
import SpriteKit


protocol Animatable {
    
    func growShrinkEffect() -> SKAction

    
}

extension Animatable {
    
    func growShrinkEffect() -> SKAction {
        let grow = SKAction.scale(to: 1.4, duration: 0.3)
        let shrink = SKAction.scale(to: 1.0, duration: 0.3)
        
        let growShrink = SKAction.sequence([grow, shrink])
        
        let growShrinkRepeat = SKAction.repeat(growShrink, count: 40)
        
        return growShrinkRepeat
    }

    
}
