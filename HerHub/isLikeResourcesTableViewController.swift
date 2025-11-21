//
//  ResourceTableViewController.swift
//  HerHub
//
//  Created by mahika behal on 21/11/25.
//

import UIKit

class isLikeResourcesTableViewController: UITableViewController {

    private var likedResources: [Resource] = []

    // TEMP user ID (replace later with real logged-in user's ID)
    private let userId = UUID(uuidString: "11111111-1111-1111-1111-111111111111")!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Liked Articles"
        navigationController?.navigationBar.prefersLargeTitles = true

        // Fetch all articles and filter liked ones
        let allResources = ResourceManager.shared.getAllResources()
        likedResources = allResources.filter { $0.isLiked?.contains(userId) == true }
    
    }

    // MARK: - TableView Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return likedResources.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedResourceCell", for: indexPath)
        
        let resource = likedResources[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = resource.title
        content.secondaryText = resource.description
        cell.contentConfiguration = content
        
        return cell
    }
    
    

    // MARK: - Select Row → Open Detail Page

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        let selectedResource = likedResources[indexPath.row]

        if let detailVC = storyboard?.instantiateViewController(
            withIdentifier: "ArticleDetailViewController"
        ) as? ArticleDetailViewController {

            // IMPORTANT → this is the correct property name
            detailVC.resource = selectedResource

            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
