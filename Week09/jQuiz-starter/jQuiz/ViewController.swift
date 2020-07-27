//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var clues: [String] = []
  
  let viewModel = QuizViewModel()
  private var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
    
    SoundManager.shared.playSound()
    
    viewModel.$quizState
      .sink { quizState in
        switch quizState {
          
        case .unInitialized:
          self.viewModel.fetchNextQuestion()
        case .loading:
          self.activityIndicator.isHidden = false
        case .success( let state ):
          self.categoryLabel.text = state.category
          self.clueLabel.text = state.question
          self.clues = state.clues
          self.tableView.reloadData()
          self.tableView.allowsSelection = true
          self.activityIndicator.isHidden = true
        case .failure( let error ):
          self.activityIndicator.isHidden = true
          print("error occured \(error)")
          self.showErrorAlert(for: error)
        }
      }
      .store(in: &subscriptions)
    
    viewModel.$totalScore
      .sink { (totalScore) in
        self.scoreLabel.text = "\(totalScore)"
      }
      .store(in: &subscriptions)
    
  }
  
  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
  }
  
  private func showErrorAlert(for error: Error){
    
    let alert = UIAlertController(
      title: "Opps!!",
      message: "Something went wrong: \(error.localizedDescription)",
      preferredStyle: .alert
    )
    let action = UIAlertAction(title: "Try Agin", style: UIAlertAction.Style.default){
      uiAlertAction in
      self.viewModel.fetchNextQuestion()
    }
    alert.addAction(action)
    
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clues.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell")!
    let label = cell.viewWithTag(1000) as! UILabel
    label.text = clues[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.checkClue(for: indexPath.row)
    // this will prevent user to select different
    // option while downloading next question.
    tableView.allowsSelection = false
  }
}

