//
//  ArticleDetailViewController.swift
//  HerHub
//
//  Created by mahika behal on 17/11/25.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var resources: Resource?

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var readTimeLabel: UILabel!
    @IBOutlet weak var articleBodyLabel: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var bottomCardView: UIView!
        @IBOutlet weak var exploreButton: UIButton!
        @IBOutlet weak var articleCompleteLabel: UILabel!
        @IBOutlet weak var moreInfoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Title in navigation bar
        navigationItem.title = resources?.title
        navigationItem.largeTitleDisplayMode = .never
        
//        articleTitleLabel.text = resources?.title
//           subtitleLabel.text = resources?.description
//           categoryLabel.text = resources?.category.rawValue
//           authorLabel.text = resources?.author
//           readTimeLabel.text = resources?.estimatedReadTime
//           articleBodyLabel.text = resources?.content
//           bigImageView.image = UIImage(named: resources?.imageURL ?? "")
        
        updateUI()
        styleUI()
    }
    private func updateUI() {
        guard let resource = resources else { return }

        articleTitleLabel.text = resource.title
        subtitleLabel.text = resource.description
        categoryLabel.text = resource.category.rawValue
        authorLabel.text = resource.author
        readTimeLabel.text = resource.estimatedReadTime
        
        bigImageView.image = UIImage(named: resource.imageURL ?? "")
        articleBodyLabel.text = resource.content
    }
    
       // MARK: - Styling (Corner Radius + Shadows)
       private func styleUI() {
           
           // Big Image Styling
           bigImageView.layer.cornerRadius = 20
           bigImageView.clipsToBounds = true
           
           // Category Pill
           categoryLabel.layer.cornerRadius = 10
           categoryLabel.clipsToBounds = true
           
           // Bottom Card (matches your design)
           bottomCardView.layer.cornerRadius = 20
           bottomCardView.layer.masksToBounds = false
           bottomCardView.layer.shadowColor = UIColor.black.cgColor
           bottomCardView.layer.shadowOpacity = 0.08
           bottomCardView.layer.shadowRadius = 12
           bottomCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
           bottomCardView.backgroundColor = .white
           
           // Explore Button Styling
           exploreButton.layer.cornerRadius = 22
           exploreButton.backgroundColor = .systemPink
           exploreButton.setTitleColor(.white, for: .normal)
           exploreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
