//
//  SauceAmountModel+CoreDataClass.swift
//  SandwichSaturation
//
//  Created by Zoha on 7/20/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


public class SauceAmountModel: NSManagedObject {

  var sauceAmount: SauceAmount {
    get {
      guard let sauceAmount = SauceAmount(rawValue: sauceAmountString) else {
        return .none
      }
      
      return sauceAmount
    }
    
    set {
      self.sauceAmountString = newValue.rawValue
    }
  }
}
