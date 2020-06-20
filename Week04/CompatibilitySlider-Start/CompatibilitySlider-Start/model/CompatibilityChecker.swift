//
//  CompatibilityChecker.swift
//  CompatibilitySlider
//
//  Created by Zoha on 6/20/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class CompatibilityChecker{
  
  private var compatibilityItems = ["Cats", "Dogs", "SwiftUI", "Catalyst", "Multiple Trailing Closure", "WWDC 2020"] // Add more!
  private var currentItemIndex = 0
  
  var currentItem:String { compatibilityItems[currentItemIndex] }

  private var person1: Person!
  private var person2: Person!
  private var currentPerson: Person!
  
  
  
  func isPerson1Current() -> Bool {currentPerson == person1}
  
  
  
  func toggleCurrentPerson() {
    if currentPerson == person1 {
      currentPerson = person2
    } else {
      currentPerson = person1
    }
    
    currentItemIndex = 0
  }
  
  
  
  func nextItem() -> Bool {
    guard currentItemIndex+1 < compatibilityItems.count else {
      return false
    }

    currentItemIndex += 1
    return true
  }
  
  
  
  func startNewCompare(person1: Person, person2: Person) {
    self.person1 = person1
    self.person2 = person2
    
    currentPerson = self.person1
    currentItemIndex = 0
  }
  
  
  
  func addRating(rating: Float){
    if currentPerson == person1 {
      person1.items.updateValue(rating, forKey: currentItem)
    } else {
      person2.items.updateValue(rating, forKey: currentItem)
    }
  }
  
  
  
  func calculateCompatibility() -> String {
      // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
      var percentagesForAllItems: [Double] = []

      for (key, person1Rating) in person1.items {
          let person2Rating = person2.items[key] ?? 0
          let difference = abs(person1Rating - person2Rating)/5.0
          percentagesForAllItems.append(Double(difference))
      }

      let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
      let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
      print(matchPercentage, "%")
      let matchString = 100 - (matchPercentage * 100).rounded()
      return "\(matchString)%"
  }
  
}
