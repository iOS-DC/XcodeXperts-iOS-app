//
//  ResourceViewController.swift
//  HerHub
//

import UIKit

class ResourceViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var resources: [Resource] = []


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resources = ResourceManager.shared.getAllResources()

//        title = "Resources"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        
        // Fetch data from manager
        resources = ResourceManager.shared.getAllResources()
        tableView.contentInsetAdjustmentBehavior = .never

    }

    }


// MARK: - UITableViewDelegate & DataSource
extension ResourceViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 // UITableView.automaticDimension // matches the card height in your screenshot
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPage",
           let destination = segue.destination as? ArticleDetailViewController,
           let indexPath = sender as? IndexPath {
            destination.resources = resources[indexPath.row]
        }
    }
}
