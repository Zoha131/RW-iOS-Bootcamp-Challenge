//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {
  
  static let shared = SoundManager()
  
  private var player: AVAudioPlayer?
  
  override init() {
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
  
}
