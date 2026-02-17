//
//  ResourceViewController.swift
//  HerHub
//

import UIKit

class ResourceViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var resources: [Resource] = []
    private var allResources: [Resource] = []

    

    override func viewDidLoad() {
            super.viewDidLoad()
            
        allResources = ResourceManager.shared.getAllResources()
           resources = allResources

            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.isTranslucent = false
            
        searchBar.delegate = self        // 🔑 IMPORTANT
            searchBar.placeholder = "Search any resource..."
        
            tableView.contentInsetAdjustmentBehavior = .never
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
        }
    @IBAction func openLikedResources(_ sender: UIButton) {
        performSegue(withIdentifier: "showLikedResources", sender: nil)
    }


        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Reload latest likes/bookmarks
            allResources = ResourceManager.shared.getAllResources()
            resources = allResources
            tableView.reloadData()
        }
    }
extension ResourceViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            resources = allResources
        } else {
            resources = allResources.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // hide keyboard
    }
}


    // MARK: - UITableView Delegate & DataSource
    extension ResourceViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return resources.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 280 // matches your card size
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCellIdentifier", for: indexPath) as! ResourceCell
            let item = resources[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "detailPage", sender: indexPath)
        }

        // MARK: - Navigation to Detail Page
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "detailPage",
               let destination = segue.destination as? ArticleDetailViewController,
               let indexPath = sender as? IndexPath {
                
                destination.resource = resources[indexPath.row]   // FIXED
            }
        }
    }
