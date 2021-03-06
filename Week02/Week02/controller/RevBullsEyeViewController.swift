//
//  RevBullsEyeViewController.swift
//  Week02
//
//  Created by Zoha on 6/7/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class RevBullsEyeViewController: UIViewController {
    
    let bullsEyeGame = BullsEyeGame(minTargetValue: 1, maxTargetValue: 100)
    
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
    
    
    @IBAction func onTapped(_ sender: Any) {
        guessTxt.endEditing(true)
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
        if  let text = self.guessTxt.text,          // Unwrapped the optional string here
            let roundedValue = Int(text),           // checked if the string is valid integer
            roundedValue <= 100 && roundedValue >= 1// checked if the value is inside of the slider value
        {
            bullsEyeGame.currentValue = roundedValue
            hitButton.isEnabled = true
            
        } else{
            hitButton.isEnabled = false
            slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(1.0)
        }
        
        updateViews(calledFromTxtListener: true)
        
    }
    
    func updateViews(calledFromTxtListener: Bool = false) {
        
        if !calledFromTxtListener {
            // If i don't check this then the TextField does not work properly
            guessTxt.text = String(bullsEyeGame.currentValue)
        }
        
        slider.value = Float(bullsEyeGame.targetValue)
        scoreLabel.text = String(bullsEyeGame.totalScore)
        roundLabel.text = String(bullsEyeGame.round)
        
        // giving hint to the user
        slider.minimumTrackTintColor = UIColor
            .blue
            .withAlphaComponent(CGFloat(bullsEyeGame.difference)/100.0)
        
        print(bullsEyeGame.targetValue)
    }
    
    @IBAction func startNewGame() {
        bullsEyeGame.reset()
        updateViews()
    }
    
    
    
}
