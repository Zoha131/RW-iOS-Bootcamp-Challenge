//
//  SandwichViewModel.swift
//  SandwichSaturation
//
//  Created by Zoha on 7/19/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

class SandwichViewModel {
  
  let defaults = UserDefaults.standard
  
  private let KEY_SAUCE = "KEY_SAUCE"
  private let KEY_FIRST_TIME = "KEY_FIRST_TIME"
  
  private var isSeedDataLoaded: Bool {
    get{
      return defaults.bool(forKey: KEY_FIRST_TIME)
    }
    
    set {
      defaults.set(newValue, forKey: KEY_FIRST_TIME)
    }
  }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Database")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      //print(storeDescription)
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  lazy var coreDataContext: NSManagedObjectContext = {
    persistentContainer.viewContext
  }()
  
  init() {
    if !isSeedDataLoaded {
      loadSandwiceDataFromJSON().forEach { (sandwichData) in
        self.addSandwich(sandwichData)
      }
      isSeedDataLoaded = true
    }
  }
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let error = error as NSError
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  func addSandwich(_ sandwichData: SandwichData) {
    let sauceAmountModel = SauceAmountModel(context: coreDataContext)
    sauceAmountModel.sauceAmountString = sandwichData.sauceAmount.rawValue
    
    
    // FIXME: for some weird reason this code give me fatal error.
    // I think, I some issue with the  NSEntityDescriptions
    // let sandwich = Sandwich(entity: Sandwich.entity(), insertInto: coreDataContext)
    let sandwich = Sandwich(context: coreDataContext)
    sandwich.name = sandwichData.name
    sandwich.imageName = sandwichData.imageName
    sandwich.sauceAmount = sauceAmountModel
    
    saveContext()
  }
  
  func fetchSandwiches(for query: String? = nil, sauce: SauceAmount? = nil) -> [Sandwich] {
    
    let request = Sandwich.fetchRequest() as NSFetchRequest<Sandwich>
    var predicates: [NSPredicate] = []
    
    if let name = query, !name.isEmpty {
      let namePredicate = NSPredicate(
        format: "name CONTAINS[cd] %@",
        name
      )
      predicates.append(namePredicate)
    }
    
    if let sauceAmount = sauce, sauceAmount != .any{
      let saucePredicate = NSPredicate(
        format: "sauceAmount.sauceAmountString = %@",
        sauceAmount.rawValue
      )
      predicates.append(saucePredicate)
    }
    
    request.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
    
    do {
      let data = try coreDataContext.fetch(request)
      return data
      
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
    
    return []
  }
  
  func getSelectedSauceAmountIndex() -> Int {
    if let sauceRawValue = defaults.string(forKey: KEY_SAUCE),
      let sauceAmount = SauceAmount.init(rawValue: sauceRawValue),
      let index = SauceAmount.allCases.firstIndex(of: sauceAmount){
      //print("Retrieved SauceAmount: \(sauceAmount.rawValue)")
      return index
    }
    return 0
  }
  
  // FIXME: Unreliable UserDefault
  //
  // Sometimes when I close the app just after changing the sauce amount
  // this functin get called but later when I open the app again
  // then it does not reflect the change.
  //
  // If I wait before closing the app then it works as expected
  func setSelectedSauceAmount(_ sauceAmount: SauceAmount) {
    defaults.set(sauceAmount.rawValue, forKey: KEY_SAUCE)
    //print("SauceAmount Saved: \(sauceAmount.rawValue)")
  }
  
  private func loadSandwiceDataFromJSON() -> [SandwichData] {
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
