//
//  SandwichViewModel.swift
//  SandwichSaturation
//
//  Created by Zoha on 7/19/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation

class SandwichViewModel {
  
  let defaults = UserDefaults.standard
  
  private let KEY_SAUCE = "KEY_SAUCE"
  
  func getSelectedSauceAmountIndex() -> Int {
    
    if let sauceRawValue = defaults.string(forKey: KEY_SAUCE),
      let sauceAmount = SauceAmount.init(rawValue: sauceRawValue),
      let index = SauceAmount.allCases.firstIndex(of: sauceAmount){
      
      return index
    }
    
    return 0
  }
  
  func setSelectedSauceAmount(_ sauceAmount: SauceAmount) {
    defaults.set(sauceAmount.rawValue, forKey: KEY_SAUCE)
    print("SauceAmount Saved: \(sauceAmount.rawValue)")
  }
  
  func loadSandwiceDataFromJSON() -> [SandwichData] {
    
    let decoder = JSONDecoder()
    
    if let path = Bundle.main.path(forResource: "sandwiches", ofType: "json"){
      
      let JsonURL = URL(fileURLWithPath: path)
      
      do {
        let data = try Data(contentsOf: JsonURL)
      
        let sandwiches = try decoder.decode([SandwichData].self, from: data)
        
        return sandwiches
      
      } catch let error {
        print("Something went wrong \(error)")
      }
      
    }
    
    return []
  }
}
