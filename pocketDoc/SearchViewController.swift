/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Properties
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  
  var detailViewController: DetailViewController? = nil
  var candies = [SearchOption]()
  var filteredCandies = [SearchOption]()
  let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Candies"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    
    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = ["All", "Medicine", "Symptom", "Hospital", "Pharmacy"]
    searchController.searchBar.delegate = self
    
    // Setup the search footer
    tableView.tableFooterView = searchFooter
    
    candies = [
        SearchOption(category:"Medicine", name:"Synthroid", description:"It can treat hypothyroidism. It can also treat an enlarged thyroid gland and thyroid cancer.\n\nBrands: Synthroid, Tirosint, Levoxyl, Unithroid, and Levo-T\n\nAvailability: Prescription needed\n\nPregnancy: No known risks\n\nAlcohol: No known interactions with light drinking\n\nDrug class: Thyroid hormones"),
        SearchOption(category:"Medicine", name:"Crestor", description:"It can treat high cholesterol and triglyceride levels. This may reduce the risk of heart attack, stroke, and related health conditions.\n\nBrands: Crestor\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Interactions can occur"),
      SearchOption(category:"Symptom", name:"Cough", description:""),
      SearchOption(category:"Hospital", name:"Carle Hospital", description:""),
      SearchOption(category:"Pharmacy", name:"Walgreens", description:""),
      SearchOption(category:"Symptom", name:"Vomiting", description:""),
      SearchOption(category:"Symptom", name:"Headache", description:""),
      SearchOption(category:"Symptom", name:"Back Pain", description:""),
      SearchOption(category:"Medicine", name:"Ventolin HFA", description:"It can treat or prevent bronchospasm.\n\nBrands: ProAir HFA, Proventil HFA, ProAir RespiClick, and Ventolin HFA\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: No known interactions with light drinking\n\nDrug class: Inhaled beta-2-agonist"),
      SearchOption(category:"Medicine", name:"Nexium", description:"It can treat gastroesophageal reflux disease (GERD). It can also lower the risk of bleeding after endoscopy in patients with ulcers.\n\nBrands: Nexium, Nexium IV, Nexium 24HR, and Nexium Packet\n\nAvailability: Prescription sometimes needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Avoid. Very serious interactions can occur"),
      SearchOption(category:"Hospital", name:"OSF Medical Center", description:""),
      SearchOption(category:"Medicine", name:"Vyvanse", description:"It can treat ADHD and binge-eating disorder.\n\nCaution: Can cause rapid or irregular heartbeat, delirium, panic, psychosis, and heart failure.\n\nBrands: Vyvanse\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Avoid. Very serious interactions can occur"),
      SearchOption(category:"Medicine", name:"Lyrica", description:"It can treat nerve and muscle pain, including fibromyalgia. It can also treat seizures.\n\nBrands: Lyrica\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Interactions can occur\n\nDrug class: GABA analogue"),
      SearchOption(category:"Pharmacy", name:"Christie Clinic", description:""),
      SearchOption(category:"Symptom", name:"Congestion", description:"")]
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table View
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      searchFooter.setIsFilteringToShow(filteredItemCount: filteredCandies.count, of: candies.count)
      return filteredCandies.count
    }
    
    searchFooter.setNotFiltering()
    return candies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let candy: SearchOption
    if isFiltering() {
      candy = filteredCandies[indexPath.row]
    } else {
      candy = candies[indexPath.row]
    }
    cell.textLabel!.text = candy.name
    cell.detailTextLabel!.text = candy.category
    return cell
  }
  
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let candy: SearchOption
        if isFiltering() {
          candy = filteredCandies[indexPath.row]
        } else {
          candy = candies[indexPath.row]
        }
        let controller = segue.destination as! DetailViewController
        controller.detailCandy = candy
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
  // MARK: - Private instance methods
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredCandies = candies.filter({( candy : SearchOption) -> Bool in
      let doesCategoryMatch = (scope == "All") || (candy.category == scope)
      
      if searchBarIsEmpty() {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
      }
    })
    tableView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
  }
}

extension SearchViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension SearchViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
