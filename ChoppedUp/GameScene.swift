//
//  GameScene.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-08.
//  Copyright © 2016 FEO. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var contentGenerator = ContentGenerator()
    
    private var backgroundImage = SKSpriteNode(imageNamed: "Background")
    private var answerNode: AnswerNode?
    private var questionWordNodes: [WordNode]?
    private var questionArea: SKSpriteNode?
    private var timerSpriteNode: SKSpriteNode!
    private var scoreNode: ScoreNode?
    private var boundaryWalls: [BoundaryWall]!
    var touchedNode: SKNode?
    
    var levelTimeInSeconds: Int = 60
    var levelTimerValue: Int = 120
    var blockTouch = false
    
    var currentHighScore = 0
    
    override func didMove(to view: SKView) {
        
        
        // Create shape node to use during mouse interaction
        //        let w = (self.size.width + self.size.height) * 0.05
        
        
        backgroundImage.position = CGPoint(x: self.view!.bounds.width / 2, y: self.view!.bounds.height / 2)
        backgroundImage.zPosition = -1
        addChild(backgroundImage)
        
        var frameSize = CGSize()
        
        if let s = self.view?.bounds.size {
            
            frameSize = CGSize(width: s.width, height: s.height / 2)
        }
        
        let bounds = self.view?.bounds
        self.questionArea = SKSpriteNode(color: UIColor.clear, size: frameSize)
        questionArea?.position = CGPoint(x: (bounds?.width)! / 2, y: (bounds?.height)! / 1.8)
        
        addChild(self.questionArea!)
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        contentGenerator.getAnswersAndQuestions(completion: startGame)

    }
    
    func startGame() {
        newTask()
        setupBoundaryWalls()
        self.setTimer()
    }
    
    func setupBoundaryWalls() {
        let leftWall = BoundaryWall(rectOf: CGSize(width: 5, height: self.view!.frame.height))
        let rightWall = BoundaryWall(rectOf: CGSize(width: 5, height: self.view!.frame.height))
        let topWall = BoundaryWall(rectOf: CGSize(width: self.view!.frame.width, height: 60))
        let bottomWall = BoundaryWall(rectOf: CGSize(width: self.view!.frame.width, height: 150))
        
        leftWall.fillColor = UIColor.black
        rightWall.fillColor = UIColor.black
        topWall.fillColor = UIColor.black
        bottomWall.fillColor = UIColor.black
        
        leftWall.position = CGPoint(x: 0, y: ((self.view?.frame.height)! / 2))
        rightWall.position = CGPoint(x: (self.view?.frame.width)!, y: ((self.view?.frame.height)! / 2))
        topWall.position = CGPoint(x: self.frame.width / 2, y: (self.view?.frame.height)! - 30)
        bottomWall.position = CGPoint(x: self.frame.width / 2, y: 75)
        
        self.boundaryWalls = [leftWall, rightWall, topWall, bottomWall]
        
        for wall in boundaryWalls {
             wall.fillColor = UIColor.clear
            wall.strokeColor = UIColor.clear
            wall.physicsBody = SKPhysicsBody(rectangleOf: wall.frame.size)
            wall.physicsBody?.affectedByGravity = false
            wall.physicsBody?.allowsRotation = false
            wall.physicsBody?.isDynamic = false
            self.addChild(wall)
        }
    }
    
    
    func setTimer() {
        
        self.levelTimerValue = levelTimeInSeconds * 2
        
        timerSpriteNode = SKSpriteNode(imageNamed: "TimeBar")
        timerSpriteNode.position = CGPoint(x: (self.view?.bounds.width)! / 2, y: (self.view?.bounds.height)! - 30)
        
        let timerSpriteFraction = (timerSpriteNode.size.width) / 120
        
        addChild(timerSpriteNode)
        
        let wait = SKAction.wait(forDuration: 0.5) //change countdown speed here
        let block = SKAction.run({
            [unowned self] in
            
            if self.levelTimerValue > 0 {
                self.levelTimerValue -= 1
                
                self.timerSpriteNode.size = CGSize(width: (self.timerSpriteNode.size.width) - timerSpriteFraction , height: (self.timerSpriteNode.size.height))
                
            }else{
                self.timeOut()
                
            }
        })
        let sequence = SKAction.sequence([wait,block])
        
        run(SKAction.repeatForever(sequence), withKey: "countdown")
    }
    
    func timeOut() {
        self.removeAction(forKey: "countdown")
        self.blockTouch = true
        
        run(SoundPlayer.sharedInstance.wrongBlockSelectionSound)
        
        self.newRound()
    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if !blockTouch {
        let touchedNodes = self.nodes(at: pos)
        
        for node in touchedNodes {
            if let wordNode = node as? WordNode {
                touchedNode = wordNode
                wordNode.touchedMe()
                
            }
        }
        }
    }
    
    
    
    func touchMoved(toPoint pos : CGPoint) {
        if !blockTouch {
        let touchedNodes = self.nodes(at: pos)
        
        var hitWall = false
        
        for node in touchedNodes {
            if node.isKind(of: BoundaryWall.self) {
                hitWall = true
            }
        }
        
        if touchedNode != nil && !hitWall {
            touchedNode?.position = convert(pos, to: questionArea!)
        } else {
        }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if !blockTouch {
        if touchedNode != nil {
            
            if let wordNode = touchedNode as? WordNode {
                
                wordNode.releasedMe()
                
                for wordNode in questionWordNodes! {
                    
                    wordNode.currentIndex = 0
                    
                    let posY = wordNode.position.y
                    
                    for wordNode2 in questionWordNodes! {
                        let posY2 = wordNode2.position.y
                        
                        if posY < posY2 {
                            wordNode.currentIndex += 1
                        }
                    }
                    
                }
            }
            touchedNode = nil
        }
        checkOrder()
        }
    }
    
    func waitThenRunFunction(duration: Float, completion: @escaping () -> Void) {
        let wait = SKAction.wait(forDuration: TimeInterval(duration))
        run(wait, completion: {() -> Void in
           completion()
        })
    }
    
    func wait(duration: Float) {
        let wait = SKAction.wait(forDuration: TimeInterval(duration))
        run(wait, completion: {() -> Void in
            
        })
    }

    
    func newRound() {
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        if scoreNode != nil {
            scoreNode?.removeFromParent()
            scoreNode = nil
        }
        self.timerSpriteNode.removeFromParent()
        self.answerNode?.removeFromParent()
        for i in self.questionWordNodes! {
            i.removeFromParent()
        }
        
        self.answerNode = nil
        self.questionWordNodes = nil
        
        setTimer()
        newTask()
     
        blockTouch = false
    }
    
    func checkOrder() {
        
        var matches = 0
        
        for wordNode in questionWordNodes! {
            if wordNode.questionWord.sentenceIndexes.index(of: wordNode.currentIndex) != nil {
                matches += 1
            }
        }
        
        if matches == questionWordNodes!.count {
            print("megayeah!")
            blockTouch = true
            self.removeAction(forKey: "countdown")
            correctAnswer()
            waitThenRunFunction(duration: 2, completion:  self.newRound)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func newTask() {
        
        questionWordNodes = [WordNode]()
 
        
        let task = contentGenerator.prepareTask()
        
        questionWordNodes?.removeAll(keepingCapacity: false)
        
        for questionWord in task.questionWordsArray {
            
            let wordNode = WordNode(questionWord: questionWord)
            
            wordNode.position = getRandomPosition()
            
            
            questionWordNodes?.append(wordNode)
            
            self.questionArea!.addChild(wordNode)
        }

        self.answerNode = AnswerNode(answer: task.answer)
        
        self.answerNode?.position = CGPoint(x: (self.view?.bounds.width)! / 2, y: 30)

        
        addChild(self.answerNode!)
        
        run(SoundPlayer.sharedInstance.newLettersSpawnedSound)
    }
    
    
    func getRandomPosition() -> CGPoint {
        
        let width = Double((questionArea?.frame.width)! / 2)
        let height = Double((questionArea?.frame.height)!)
        
        let halfWidth = Int(width / 2)
        let halfHeight = Int(height / 2)
        
        let randomX = randomNumberBetween(-halfWidth, halfWidth)
        let randomY = randomNumberBetween(-halfHeight, halfHeight)
        
        let randomPosition = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
        
        return randomPosition
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func randomNumberBetween(_ x: Int, _ y: Int) -> Int {
        let result = Int(arc4random_uniform(UInt32(y - x + 1))) +   x
        return result
    }
    
    func calculateScore() -> Int {
        let numberOfWords = questionWordNodes?.count
        let timeLeftInSeconds = levelTimerValue / 2
        
        let score = Int(numberOfWords! * timeLeftInSeconds)
        
        return score
    }
    
    func correctAnswer() {
        
        for word in questionWordNodes! {
            word.correctAnswer()
        }
        run(SoundPlayer.sharedInstance.wholeBlockBonusSound)
        answerNode!.answerLabel.text = ""
    
        
        showScore(calculateScore())
        
        
        
        wait(duration: 3)

    }
    
    
    func showScore(_ score: Int) {
        
        
        self.scoreNode = ScoreNode()
        scoreNode!.position = CGPoint(x: self.view!.frame.width / 2, y: self.view!.frame.height / 2)
        addChild(scoreNode!)
        scoreNode?.displayScore(score)
        scoreNode!.sparkEffect()
        
         if score > currentHighScore {
            scoreNode?.newHighScore()
            currentHighScore = score
        }

    }
}



class BoundaryWall: SKShapeNode {
    
}


