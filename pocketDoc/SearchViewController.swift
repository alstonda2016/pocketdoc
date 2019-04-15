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
        SearchOption(category:Category.Medicine, name:"Synthroid", description:"It can treat hypothyroidism. It can also treat an enlarged thyroid gland and thyroid cancer.\n\nBrands: Synthroid, Tirosint, Levoxyl, Unithroid, and Levo-T\n\nAvailability: Prescription needed\n\nPregnancy: No known risks\n\nAlcohol: No known interactions with light drinking\n\nDrug class: Thyroid hormones"),
        SearchOption(category:Category.Medicine, name:"Crestor", description:"It can treat high cholesterol and triglyceride levels. This may reduce the risk of heart attack, stroke, and related health conditions.\n\nBrands: Crestor\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Interactions can occur"),
      SearchOption(category:Category.Symptom, name:"Cough", description:"A sudden, forceful hacking sound to release air and clear an irritation in the throat or airway.\n\nCoughing can have causes that aren't due to underlying disease. Examples include normal clearing of airways, irritants such as smoke and gas, tobacco use, or improperly swallowing food and liquids."),
      SearchOption(category:Category.Hospital, name:"Carle Hospital", description:"Carle Foundation Hospital is a 413-bed regional care hospital in Urbana, Illinois, United States, that has achieved Magnet designation. It is owned by the not-for-profit Carle Foundation.\n\nAddress: 611 W Park St, Urbana, IL 61801\n\nHours: Open 24 hours\n\nNumber of beds: 413"),
      SearchOption(category:Category.Pharmacy, name:"Walgreens Pharmacy", description:"Department of the Walgreens chain providing prescription medications & other health-related items.\n\nLocated in: Carle Foundation Hospital\n\nAddress: 602 W University Ave, Urbana, IL 61801\n\nHours: 8am - 9pm\n\n"),
      SearchOption(category:Category.Symptom, name:"Vomiting", description:"Forcefully expelling the stomach's contents out of the mouth.\n\nVomiting can have causes that aren't due to underlying disease. Examples include hangover, pregnancy, overeating, or motion sickness."),
      SearchOption(category:Category.Symptom, name:"Headache", description:"A painful sensation in any part of the head, ranging from sharp to dull, that may occur with other symptoms.\n\nHeadaches can have causes that aren't due to underlying disease. Examples include lack of sleep, an incorrect eyeglass prescription, stress, loud noise exposure, or tight headwear."),
      SearchOption(category:Category.Symptom, name:"Back Pain", description:"Physical discomfort occurring anywhere on the spine or back, ranging from mild to disabling.\n\nBack pain can have causes that aren't due to underlying disease. Examples include overuse such as working out or lifting too much, prolonged sitting and lying down, sleeping in an uncomfortable position, or wearing a poorly fitting backpack."),
      SearchOption(category:Category.Medicine, name:"Ventolin HFA", description:"It can treat or prevent bronchospasm.\n\nBrands: ProAir HFA, Proventil HFA, ProAir RespiClick, and Ventolin HFA\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: No known interactions with light drinking\n\nDrug class: Inhaled beta-2-agonist"),
      SearchOption(category:Category.Medicine, name:"Nexium", description:"It can treat gastroesophageal reflux disease (GERD). It can also lower the risk of bleeding after endoscopy in patients with ulcers.\n\nBrands: Nexium, Nexium IV, Nexium 24HR, and Nexium Packet\n\nAvailability: Prescription sometimes needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Avoid. Very serious interactions can occur"),
      SearchOption(category:Category.Hospital, name:"Northwestern Memorial Hospital", description:"Northwestern Memorial Hospital is a nationally ranked academic medical center located in Streeterville, Chicago, Illinois.\n\nAddress: 251 E Huron St, Chicago, IL 60611\n\nHours: Open 24 hours\n\nNumber of beds: 894"),
      SearchOption(category:Category.Medicine, name:"Vyvanse", description:"It can treat ADHD and binge-eating disorder.\n\nCaution: Can cause rapid or irregular heartbeat, delirium, panic, psychosis, and heart failure.\n\nBrands: Vyvanse\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Avoid. Very serious interactions can occur"),
      SearchOption(category:Category.Medicine, name:"Lyrica", description:"It can treat nerve and muscle pain, including fibromyalgia. It can also treat seizures.\n\nBrands: Lyrica\n\nAvailability: Prescription needed\n\nPregnancy: Consult a doctor\n\nAlcohol: Interactions can occur\n\nDrug class: GABA analogue"),
      SearchOption(category:Category.Pharmacy, name:"CVS Pharmacy", description:"Drugstore chain selling a variety of beauty & health products, plus some grocery & household items.\n\nAddress: 1818 S Philo Rd, Urbana, IL 61802\n\nHours: 8am - 9pm\n\n"),
      SearchOption(category:Category.Symptom, name:"Congestion", description:"Nasal passages swollen with excess fluid and mucus, may be triggered by infection, tobacco smoke, or perfume.\n\nNasal congestion can have causes that aren't due to underlying disease. Examples include anatomical variation, having an object stuck in the nose, or dried mucus.")]
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
    cell.detailTextLabel!.text = candy.category.toString()
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
      let doesCategoryMatch = (scope == "All") || (candy.category.toString() == scope)
      
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
