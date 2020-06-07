//
//  SecondViewController.swift
//  Week02
//
//  Created by Zoha on 6/7/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class RGBullsEyeViewController: UIViewController {
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let game = RGBullsEyeGame(minTargetValue: 1, maxTargetValue: 100)
    
    @IBAction func aSliderMoved(sender: UISlider) {
        
        let r = Int(redSlider.value.rounded())
        let g = Int(greenSlider.value.rounded())
        let b = Int(blueSlider.value.rounded())
        
        game.currentValue = RGB(r: r, g: g, b:  b)
        
        updateView()
    }
    
    @IBAction func showAlert(sender: AnyObject) {
        let difference = game.difference
        let points = game.calculateScore()
        
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
            self.game.nextRound()
            self.updateView()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(sender: AnyObject) {
        game.reset()
        updateView()
    }
    
    func updateView() {
        
        redSlider.value = Float(game.currentValue.r)
        greenSlider.value = Float(game.currentValue.g)
        blueSlider.value = Float(game.currentValue.b)
        
        targetLabel.backgroundColor = UIColor(rgbStruct: self.game.targetValue)
        
        guessLabel.backgroundColor = UIColor(rgbStruct: self.game.currentValue)
        
        redLabel.text = "R \(game.currentValue.r)"
        greenLabel.text = "G \(game.currentValue.g)"
        blueLabel.text = "B \(game.currentValue.b)"
        
        
        roundLabel.text = "Round \(game.round)"
        scoreLabel.text = "Score \(game.totalScore)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
}

