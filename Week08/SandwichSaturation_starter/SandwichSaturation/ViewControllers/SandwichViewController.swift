//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource {
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [Sandwich]()
  var filteredSandwiches = [Sandwich]()
  var prevSearchQuery: (searchText: String, sauceAmount: SauceAmount?) = ("", nil)
  
  let viewModel = SandwichViewModel()

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    sandwiches = viewModel.fetchSandwiches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    _ = viewModel.fetchSandwiches()
        
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.selectedScopeButtonIndex = viewModel.getSelectedSauceAmountIndex()
    searchController.searchBar.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  func saveSandwich(_ sandwich: SandwichData) {
    viewModel.addSandwich(sandwich)
    sandwiches = viewModel.fetchSandwiches()
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(
    _ searchText: String,
    sauceAmount: SauceAmount? = nil
  ) {
    prevSearchQuery.searchText = searchText
    prevSearchQuery.sauceAmount = sauceAmount
    filteredSandwiches = viewModel.fetchSandwiches(for: searchText, sauce: sauceAmount)
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.sauceAmountString

    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        
        let sandwich = sandwiches[indexPath.row]
        viewModel.deleteSandwich(sandwich)
        sandwiches = viewModel.fetchSandwiches()
        filteredSandwiches = viewModel.fetchSandwiches(
          for: prevSearchQuery.searchText,
          sauce: prevSearchQuery.sauceAmount
        )
          
        tableView.reloadData()
      } 
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(
      rawValue:searchBar.scopeButtonTitles![
        searchBar.selectedScopeButtonIndex
      ]
    )

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  
  func searchBar(
    _ searchBar: UISearchBar,
    selectedScopeButtonIndexDidChange selectedScope: Int
  ) {
    
    if let sauceAmount = SauceAmount(rawValue: searchBar.scopeButtonTitles![selectedScope]){
      
      viewModel.setSelectedSauceAmount(sauceAmount)
      filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
    }
  }
}

