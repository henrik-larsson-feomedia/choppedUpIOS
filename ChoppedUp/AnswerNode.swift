//
//  AnswerNode.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-09.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation
import SpriteKit


class AnswerNode: SKNode {
    
    var answerLabel = SKLabelNode(text: "")
    var answerBackgroundNode: SKShapeNode?
    
    init(answer: String) {
        super.init()
        
        self.answerLabel.text = answer
        
        
        self.answerLabel.fontName = "ArialRoundedMTBold"
        self.answerLabel.fontSize = 35.0
        self.answerLabel.color = UIColor.white
        self.answerLabel.position = CGPoint(x: 0, y: -10)
        
        
        let answerBackgroundNodeWidth = answerLabel.frame.size.width + 100
        let answerBackgroundNodeHeight = answerLabel.frame.size.height + 100
        
        answerBackgroundNode = SKShapeNode(rectOf: CGSize(width: answerBackgroundNodeWidth,height: answerBackgroundNodeHeight), cornerRadius: 10)
        answerBackgroundNode?.fillColor = UIColor(red: 0.1961, green: 0.4, blue: 0.6588, alpha: 1.0) /* #3266a8 */
        answerBackgroundNode?.strokeColor = UIColor.clear
        answerBackgroundNode?.position = CGPoint(x: 0, y: -30)
        
        addChild(answerBackgroundNode!)
        addChild(answerLabel)
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
