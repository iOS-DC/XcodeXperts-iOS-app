//
//  ArticleDetailViewController.swift
//  HerHub
//
//  Created by mahika behal on 17/11/25.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var resource: Resource?

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
   // @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var readTimeLabel: UILabel!
    @IBOutlet weak var articleBodyLabel: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var bottomCardView: UIView!
        @IBOutlet weak var exploreButton: UIButton!
        @IBOutlet weak var articleCompleteLabel: UILabel!
        @IBOutlet weak var moreInfoLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var categoryIconView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!

    
    var currentUserId: UUID? {
        return AuthManager.shared.currentUser?.id
    }

      override func viewDidLoad() {
          super.viewDidLoad()

          navigationItem.title = "Article"
          navigationItem.largeTitleDisplayMode = .never

          updateUI()
          styleUI()
          updateLikeButton()
      }
   
      @IBAction func likeTapped(_ sender: UIButton) {
          guard let resource = resource,
                let userId = currentUserId else {
              print("[ArticleDetail] Error: No user logged in - cannot like resource")
              return
          }

          ResourceManager.shared.toggleLike(resourceId: resource.id, userId: userId)

          self.resource = ResourceManager.shared
              .getAllResources()
              .first(where: { $0.id == resource.id })

          updateLikeButton()
          
          NotificationCenter.default.post(name: NSNotification.Name("likeStatusChanged"), object: nil)

      }

      private func updateLikeButton() {
          guard let resource = resource else { return }

          let isLiked = currentUserId.map { resource.isLikedBy(userID: $0) } ?? false

          let icon = isLiked ? "heart.fill" : "heart"
          likeButton.setImage(UIImage(systemName: icon), for: .normal)
          likeButton.tintColor = isLiked ? .systemPink : .lightGray
      }

      @IBAction func shareTapped(_ sender: UIButton) {
          guard let resource else { return }

          let shareText = "\(resource.title)\n\n\(resource.description)"
          let activityVC = UIActivityViewController(activityItems: [shareText],
                                                    applicationActivities: nil)
          present(activityVC, animated: true)
      }

      private func updateUI() {
          guard let resource else { return }

          articleTitleLabel.text = resource.title
          subtitleLabel.text = resource.detailSubtitle
          authorLabel.text = resource.author
          readTimeLabel.text = resource.estimatedReadTime
          articleBodyLabel.text = resource.summary?.cleanedText() ?? "No summary added yet."



          if let imageName = resource.imageURL {
              bigImageView.image = UIImage(named: imageName)
          }
          setCategoryUI(for: resource.category) 
         

      }
    private func setCategoryUI(for category: ResourceCategory) {

        categoryLabel.text = category.rawValue

        switch category {
        case .featured:
            categoryIconView.image = UIImage(systemName: "star.fill")
            categoryIconView.tintColor = .systemPink

        case .health:
            categoryIconView.image = UIImage(systemName: "heart.text.square")
            categoryIconView.tintColor = .systemGreen

        case .wellness:
            categoryIconView.image = UIImage(systemName: "leaf.fill")
            categoryIconView.tintColor = .systemMint

        case .lifestyle:
            categoryIconView.image = UIImage(systemName: "person.fill.checkmark")
            categoryIconView.tintColor = .systemOrange

        case .fitness:
            categoryIconView.image = UIImage(systemName: "figure.run")
            categoryIconView.tintColor = .systemBlue

        case .skincare:
            categoryIconView.image = UIImage(systemName: "drop.fill")
            categoryIconView.tintColor = .systemTeal
        }

        // Make it circular soft background (just like your screenshot)
        categoryIconView.backgroundColor = UIColor.systemGray6
        categoryIconView.layer.cornerRadius = 18
        categoryIconView.clipsToBounds = true
    }

      private func styleUI() {

          bigImageView.layer.cornerRadius = 15
          bigImageView.clipsToBounds = true

          bottomCardView.layer.cornerRadius = 15
          bottomCardView.layer.masksToBounds = false
          bottomCardView.layer.shadowColor = UIColor.black.cgColor
          bottomCardView.layer.shadowOpacity = 0.08
          bottomCardView.layer.shadowRadius = 12
          bottomCardView.layer.shadowOffset = CGSize(width: 0, height: 4)

          exploreButton.layer.cornerRadius = 15
          exploreButton.backgroundColor = .systemPink
          exploreButton.setTitleColor(.white, for: .normal)
          exploreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      }



      @IBAction func exploreMoreTapped(_ sender: UIButton) {
          guard let link = resource?.sourceURL,
                    let url = URL(string: link) else { return }

              UIApplication.shared.open(url)
          
      }



  }
extension String {
    func cleanedText() -> String {
        return self
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "•", with: "• ")
            .replacingOccurrences(of: "  ", with: " ")
            .replacingOccurrences(of: "\n                ", with: "\n")
            .replacingOccurrences(of: "\n            ", with: "\n")
            .replacingOccurrences(of: "\n        ", with: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    


}
