//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var questionLabel: UILabel!
  
  let compatibilityChecker = CompatibilityChecker()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    compatibilityChecker.startNewCompare(
      person1: Person(id: 1, items: [:]),
      person2: Person(id: 2, items: [:])
    )
    
    updateViews()
  }
  
  
  
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    print(sender.value)
    
    //This will create a snaping behavior
    //Slider will snap only for 5 valuse
    //from 1 to 5
    let roundedCurrent = slider.value.rounded()
    slider.setValue(roundedCurrent, animated: true)
  }
  
  
  
  @IBAction func didPressNextItemButton(_ sender: Any) {
    
    let sliderValue = slider.value.rounded()
    compatibilityChecker.addRating(rating: sliderValue)
    
    if compatibilityChecker.nextItem() {
      updateViews()
    } else if compatibilityChecker.isPerson1Current() {
      compatibilityChecker.toggleCurrentPerson()
      updateViews()
    } else {
      
      let compareResult = compatibilityChecker.calculateCompatibility()
      
      let alert = UIAlertController(
        title: "Alert Title",
        message: compareResult,
        preferredStyle: UIAlertController.Style.alert
      )
      
      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
      
      alert.addAction(UIAlertAction(title: "Start New", style: .default, handler:{ (UIAlertAction) in
        
        self.compatibilityChecker.startNewCompare(
          person1: Person(id: 1, items: [:]),
          person2: Person(id: 2, items: [:])
        )
        
        self.updateViews()
        
      }))
      
      self.present(alert, animated: true, completion: nil)
    }
  }
  
  
  
  func updateViews(){
    if compatibilityChecker.isPerson1Current(){
      questionLabel.text = "User 1, what do you think about..."
    } else {
      questionLabel.text = "User 2, what do you think about..."
    }
    
    compatibilityItemLabel.text = compatibilityChecker.currentItem
    slider.setValue(3.0, animated: true)
  }
}
