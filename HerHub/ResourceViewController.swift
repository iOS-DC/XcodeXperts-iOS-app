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

        title = "Resources"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.systemGray6
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 20, right: 0)
        
        // Fetch data from manager
        resources = ResourceManager.shared.getAllResources()
    }
    private func openDetail(for resource: Resource) {
            // This will open a simple detail page when the user taps “Read Article”
            let detailVC = UIViewController()
            detailVC.view.backgroundColor = .systemBackground
            detailVC.title = resource.title
            
            // You can customize this later to show real article content
            let label = UILabel(frame: CGRect(x: 20, y: 100, width: 340, height: 200))
            label.text = resource.content
            label.numberOfLines = 0
            detailVC.view.addSubview(label)
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }


// MARK: - UITableViewDelegate & DataSource
extension ResourceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350// matches the card height in your screenshot
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCellIdentifier", for: indexPath) as! ResourceCell
        // let cell = cell1 
        
        let item = resources[indexPath.row]
        cell.configure(with: item)
        // cell.selectionStyle = .none

        // handle read button tap
//        cell.readTapped = { [weak self] in
//            guard let self = self else { return }
//            self.openDetail(for: item)
//        }

        return cell
    }
    
    // Spacing between cards
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 24 }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 24 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
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
