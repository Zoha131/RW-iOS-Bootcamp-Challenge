//
//  QuizViewModel.swift
//  jQuiz
//
//  Created by Zoha on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import Combine
import AVFoundation

class QuizViewModel {
  
  @Published private(set) var quizState: Async<QuizState> = .unInitialized
  @Published private(set) var totalScore: Int = 0
  @Published private(set) var imageData: Async<Data> = .unInitialized
  @Published private(set) var musicData: Async<Data> = .unInitialized
  
  var cancellables: Set<AnyCancellable> = []
  
  private var player: AVAudioPlayer?
  
  init() {
    guard let musicUrl = Bundle.main.url(forResource: "Jeopardy-theme-song", withExtension: "mp3") else {
      fatalError("resource not found")
    }
    
    do {
      player = try AVAudioPlayer(contentsOf: musicUrl)
      player?.numberOfLoops = -1
    } catch let error {
      print("AvAudioPlayer not initialized \(error)")
    }
  }
  
  var isSoundEnabled: Bool {
    get {
      // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
      // You might want to use `object`, because if an object has not been set yet it will be nil
      // Then if it's nil you know it's the user's first time launching the app
      UserDefaults.standard.object(forKey: "sound") as? Bool ?? true
    }
  }
  
  func playSound() {
    guard let player = self.player else {
      return
    }
    player.play()
  }
  
  func pauseSound() {
    guard let player = self.player else {
      return
    }
    player.pause()
  }
  
  func toggleSoundPreference() {
    UserDefaults.standard.set(!isSoundEnabled, forKey: "sound")
  }
  
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
  
  func downloadImage() {
    
    let imageUrl = URL(string: "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg")!
    
    URLSession.shared.downloadTask(with: imageUrl) { (localUrl, response, error) in
      
      do {
        let data = try Data(contentsOf: localUrl!)
        DispatchQueue.main.async {
          self.imageData = .success(data)
        }
      }catch let error {
        print("\(error.localizedDescription)")
        DispatchQueue.main.async {
          self.imageData = .failure(error)
        }
      }
      
    }.resume()
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
      score: rightClue.points ?? 0
    )
    
    DispatchQueue.main.async {
      
      self.quizState = .success(tempState)
    }
  }
  
}
