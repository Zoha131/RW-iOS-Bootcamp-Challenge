//
//  QuizViewModel.swift
//  jQuiz
//
//  Created by Zoha on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import Combine

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

enum Async<Success> {
  case unInitialized
  case loading
  case success(Success)
  case failure(Error)
}

class QuizViewModel {
  
  @Published private(set) var quizState: Async<QuizState> = .unInitialized
  @Published private(set) var totalScore: Int = 0
  @Published private(set) var imageData: Async<Data> = .unInitialized
  @Published private(set) var musicData: Async<Data> = .unInitialized
  
  var cancellables: Set<AnyCancellable> = []
  
  func checkClue(for selectedIndex: Int) {
    switch quizState {
    case .success(let state):
      if state.ansIndex == selectedIndex {
        totalScore += state.score
      }
      
      fetchNextQuestion()
      
      
    default:
      return
    }
  }
  
  func fetchNextQuestion(){
    quizState = .loading
    
    let locationUrl = URL(string: "http://www.jservice.io/api/random?count=2")!
    URLSession.shared.dataTaskPublisher(for: locationUrl)
      .map(\.data)
      .decode(type: [Clue].self, decoder: JSONDecoder())
      .flatMap { items in
        self.getClues(forCategory: items[0].category )
      }
      .sink(receiveCompletion: { completion in // I wanted to wrap this inside a method. but the type of the completion freak me out.
        switch completion {
        case .failure(let error):
          DispatchQueue.main.async {self.quizState = .failure(error)}
        case .finished:
          return
        }
      },receiveValue: updateQuizState(with:) )
      .store(in: &cancellables)
    
  }
  
  func getClues(forCategory category: Category) -> AnyPublisher<[Clue], Error> {
    let offset = category.cluesCount <= 4 ? 0 : category.cluesCount - 4
    let clueUrl = URL(string: "http://www.jservice.io/api/clues?category=\(category.id)&offset=\(offset)")!
    
    return URLSession.shared.dataTaskPublisher(for: clueUrl)
      .map(\.data)
      .decode(type: [Clue].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
  
  func updateQuizState(with clues: [Clue]) {
    let random = Int.random(in: 0..<4)
    let rightClue = clues[random]
    
    // FIXME: Check for null value and empty question
    
    let tempState = QuizState(
      question: rightClue.question,
      clues: clues.map(\.answer),
      category: rightClue.category.title,
      ansIndex: random,
      score: rightClue.value ?? 0
    )
    
    DispatchQueue.main.async {
      
      self.quizState = .success(tempState)
    }
  }
  
}
