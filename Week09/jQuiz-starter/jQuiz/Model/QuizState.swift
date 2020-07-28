//
//  QuizState.swift
//  jQuiz
//
//  Created by Zoha on 7/28/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct QuizState{
  let question: String
  let clues: [String]
  let category: String
  let ansIndex: Int
  let score: Int
  
  init(question: String, clues: [String], category: String, ansIndex: Int, score: Int) {
    self.question = question
    self.clues = clues
    self.category = category
    self.ansIndex = ansIndex
    self.score = score
    
    guard (0..<4).contains(ansIndex) else{
      fatalError("ansIndex of QuizState must be in between 0 to 3. current is: \(ansIndex)")
    }
    
    guard clues.count == 4 else{
      fatalError("count of clues array must be 4. current is: \(clues.count)")
    }
  }
}
