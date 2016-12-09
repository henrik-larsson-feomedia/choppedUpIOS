//
//  ScoreNode.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-09.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation
import SpriteKit


class ScoreNode: SKNode, Animatable {
    
    var labelBackground: SKShapeNode!
    var scoreLabel: SKLabelNode!
    var scoreShadowLabel: SKLabelNode!
    var highScoreNode: HighScoreNode?
    
   override init() {
        super.init()
        

        
        self.scoreLabel = SKLabelNode()
        scoreLabel.text = ""
        scoreLabel.position = CGPoint(x: 0, y: -10)
        scoreLabel.fontName = "ArialRoundedMTBold"
        scoreLabel.fontSize = 80.0
        scoreLabel.fontColor = UIColor.green
        scoreLabel.zPosition = 40
        
        
        
        labelBackground = SKShapeNode(rectOf: CGSize(width: scoreLabel.frame.size.width + 16, height: scoreLabel.frame.size.height + 10), cornerRadius: 10)
        labelBackground.fillColor = UIColor.clear
        labelBackground.strokeColor = UIColor.clear
        labelBackground.position = CGPoint(x: 0, y: 0)
        
        
    
        
        addChild(labelBackground)
        addChild(scoreLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayScore(_ score: Int) {
        self.scoreLabel.text = String(score)
        
        self.scoreLabel.run(growShrinkEffect())
    }
    
    func newHighScore() {
        self.highScoreNode = HighScoreNode()
        highScoreNode?.position = CGPoint(x: self.frame.width + 100, y: 40)
        highScoreNode?.zPosition = self.scoreLabel!.zPosition + 1
        addChild(highScoreNode!)
        highScoreNode?.animate()
    }
    
    func sparkEffect() {
            if let starEffect = SKEmitterNode(fileNamed: "StarEffect") {
                starEffect.position = labelBackground!.position
                labelBackground!.addChild(starEffect)
        }
    }
}
