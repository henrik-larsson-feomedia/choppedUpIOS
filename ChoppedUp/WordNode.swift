//
//  WordNode.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-08.
//  Copyright © 2016 FEO. All rights reserved.
//

import UIKit
import SpriteKit

class WordNode: SKNode {
    
    var questionWord: QuestionWord = QuestionWord(word: "doh")
    var labelBackground: SKShapeNode!
    var wordLabel: SKLabelNode!
    var wordShadowLabel: SKLabelNode!
    
    var currentIndex = 0
    
    init(questionWord: QuestionWord) {
        super.init()
        
        self.questionWord = questionWord

        
        self.wordShadowLabel = SKLabelNode()
        wordShadowLabel.text = self.questionWord.word
        wordShadowLabel.position = CGPoint(x: -1, y: -11)
        wordShadowLabel.fontName = "ArialRoundedMTBold"
        wordShadowLabel.fontSize = 30.0
        wordShadowLabel.fontColor = UIColor.black
        
        self.wordLabel = SKLabelNode()
        wordLabel.text = self.questionWord.word
        wordLabel.position = CGPoint(x: 0, y: -10)
        wordLabel.fontName = "ArialRoundedMTBold"
        wordLabel.fontSize = 30.0
        wordLabel.fontColor = UIColor.white
        wordLabel.zPosition = 40
        

        
        labelBackground = SKShapeNode(rectOf: CGSize(width: wordLabel.frame.size.width + 16, height: wordLabel.frame.size.height + 10), cornerRadius: 10)
        labelBackground.fillColor = UIColor(red: 0.1961, green: 0.4, blue: 0.6588, alpha: 1.0) /* #3266a8 */
        labelBackground.strokeColor = UIColor.clear
        labelBackground.position = CGPoint(x: 0, y: 0)
        
        
        self.physicsBody = SKPhysicsBody(rectangleOf: labelBackground.frame.size)
        self.physicsBody?.allowsRotation = false
        
        
        addChild(labelBackground)
        addChild(wordShadowLabel)
        addChild(wordLabel)
    
    }
    
    
    func touchedMe() {
        run(SoundPlayer.sharedInstance.menuButtonSound)
        self.setScale(1.1)
    }
    
    func releasedMe() {
        self.setScale(1.0)
    }
    
    func correctAnswer() {
        if let sparkEffect = SKEmitterNode(fileNamed: "SparkEffect") {
            sparkEffect.position = labelBackground!.position
            addChild(sparkEffect)
            
            
            for child in self.children where child != sparkEffect {
                child.isHidden = true
            }
            
        }
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
