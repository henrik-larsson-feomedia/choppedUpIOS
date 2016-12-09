//
//  Content.swift
//  ChoppedUp
//
//  Created by FEO on 2016-12-08.
//  Copyright © 2016 FEO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ContentGenerator {
    
    var answersAndQuestions = ["Barack Obama" : "who is the current president of the united states ?", "Mount Everest" : "what is the highest mountain in the world ?", "Israel" : "where can you find the wailing wall ?", "1492" : "when did Columbus 'discover' the American continent ?", "384,400 km" : "how far away is the moon ?", "Thomas Edison" : "who invented the incadescent lightbulb ?", "what is the capital of Vietnam" : "Hanoi"]
    
    func getAnswersAndQuestions(completion: @escaping () -> Void) {
        _ = NetworkHandler.sharedInstance.getTasks() { (tasks, errorJson) in
            if let tasks = tasks {
                self.answersAndQuestions = tasks
                print(self.answersAndQuestions)
                completion()
            } else if errorJson == nil {
                print("Couldn't get tasks from server. Using hardcoded quizziwizzies")
            }
        }
        
    }

    
    func prepareTask() -> Task {
        
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
        
        let task = Task(answer: answer, questionWordsArray: questionWordsArray)
        
        return task
    }
    
}


class Task {
    var answer: String!
    var questionWordsArray: [QuestionWord]!

    init(answer: String, questionWordsArray: [QuestionWord]) {
        self.answer = answer
        self.questionWordsArray = questionWordsArray
    }
}

class QuestionWord {
    
    var sentenceIndexes: [Int] = []
    
    let word: String
    
    init(word: String) {
        self.word = word
    }
    
}
