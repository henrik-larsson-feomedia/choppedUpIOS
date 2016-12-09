//
//  HighScoreNode.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-09.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation
import SpriteKit

class HighScoreNode: SKLabelNode, Animatable {
    
    var highschoreLabel: SKLabelNode!
    
   override init() {
        
        super.init()

        self.text = "NEW HIGH SCORE!"
        self.fontName = "ArialRoundedMTBold"
        self.fontSize = 15.0
        self.fontColor = UIColor.red
        self.zPosition = 40
        self.zRotation = CGFloat(GLKMathDegreesToRadians(-30))
    
    }
    
    func animate() {
        run(growShrinkEffect())
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
