//
//  FirstViewController.swift
//  Week02
//
//  Created by Zoha on 6/7/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class BullsEyeViewController: UIViewController {
    
    let bullsEyeGame = BullsEyeGame(minTargetValue: 1, maxTargetValue: 100)
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func showAlert() {
        
        let difference = bullsEyeGame.difference
        let points = bullsEyeGame.calculateScore()
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.bullsEyeGame.nextRound()
            self.updateViews()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        bullsEyeGame.currentValue = Int(roundedValue)
        
        print(bullsEyeGame.currentValue)
    }
    
    func updateViews() {
        slider.value = Float(bullsEyeGame.currentValue)
        targetLabel.text = String(bullsEyeGame.targetValue)
        scoreLabel.text = String(bullsEyeGame.totalScore)
        roundLabel.text = String(bullsEyeGame.round)
    }
    
    @IBAction func startNewGame() {
        bullsEyeGame.reset()
        updateViews()
    }
    
    
    
}

