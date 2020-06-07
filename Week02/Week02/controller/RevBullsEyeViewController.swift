//
//  RevBullsEyeViewController.swift
//  Week02
//
//  Created by Zoha on 6/7/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class RevBullsEyeViewController: UIViewController {
    
    var bullsEyeGame = BullsEyeGame(minTargetValue: 1, maxTargetValue: 100)
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var guessTxt: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var hitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        slider.isEnabled = false
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

    
    @IBAction func onTextChange(_ sender: Any) {
        if  let text = self.guessTxt.text,
            let roundedValue = Int(text),
            roundedValue <= 100 && roundedValue >= 1
        {
            bullsEyeGame.currentValue = roundedValue
            hitButton.isEnabled = true
            
        } else{
            hitButton.isEnabled = false
        }
        
    }
    
    func updateViews() {
        slider.value = Float(bullsEyeGame.targetValue)
        guessTxt.text = String(bullsEyeGame.currentValue)
        scoreLabel.text = String(bullsEyeGame.totalScore)
        roundLabel.text = String(bullsEyeGame.round)
        

        print(bullsEyeGame.targetValue)
    }
    
    @IBAction func startNewGame() {
        bullsEyeGame.reset()
        updateViews()
    }
    
    
    
}
