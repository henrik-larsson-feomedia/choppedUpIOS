//
//  Content.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-08.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation


class ContentGenerator {
    
    let answersAndQuestions = ["Barack Obama" : "Who is the current president of the united states ?", "Mount Everest" : "What is the highest mountain in the world ?", "Israel" : "Where can you find the wailing wall ?", "1492" : "When did Columbus 'discover' the American continent ?", "384,400 km" : "How far away from earth is the moon ?"]
    
    
    func prepareTask() -> (String, [QuestionWord]) {
        
        let keyArray = Array(answersAndQuestions.keys)
        
        let count = UInt32(answersAndQuestions.count)
        let random = Int(arc4random_uniform(count))
        
        let answer = keyArray[random]
        
        let question = answersAndQuestions[answer]
        
        var questionStringArray: [String] = []
        
        if let question = question {
            questionStringArray = question.components(separatedBy: " ")
        }
        var questionWordsArray = [QuestionWord]()
        
        
        for i in 0..<questionStringArray.count {
            let questionWord = QuestionWord(word: (questionStringArray[i]))
            questionWordsArray.append(questionWord)
        }
        
        
        for i in 0..<questionStringArray.count {
            for questionWord in questionWordsArray {
                if questionWord.word == questionStringArray[i] {
                    questionWord.sentenceIndexes.append(i)
                }
            }
        }
        
        return (question!, questionWordsArray)
    }
    
}



class QuestionWord {
    
    var sentenceIndexes: [Int] = []
    
    let word: String
    
    init(word: String) {
        self.word = word
    }
    
}
