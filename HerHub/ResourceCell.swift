//
//  ResourceCell.swift
//  HerHub
//

import UIKit

class ResourceCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Card styling
        cardView.layer.cornerRadius = 20
        cardView.layer.masksToBounds = false
        cardView.backgroundColor = .white
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.12
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.layer.shadowRadius = 8
        
        
        
        // Image
        thumbImageView.layer.cornerRadius = 16
        thumbImageView.clipsToBounds = true
        thumbImageView.contentMode = .scaleAspectFill
        
        // Badge label
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.clipsToBounds = true
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        badgeLabel.textColor = .white
        //        badgeLabel.backgroundColor = .systemPink
        badgeLabel.textAlignment = .center
        
        // Time label
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        
        // Title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        
        // Description
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.textColor = .darkGray
        descLabel.numberOfLines = 0
        
        // Read button styling (acts like the pink text link in your design)
        //                readButton.setTitle("Read Article →", for: .normal)
        //                readButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        //                readButton.setTitleColor(.systemPink, for: .normal)
        //                readButton.contentHorizontalAlignment = .left
        ////                readButton.backgroundColor = .clear
        //
        //                // Hook button action
        //                readButton.addTarget(self, action: #selector(readButtonTapped), for: .touchUpInside)
        //    }
        
    }
        
        func configure(with resource: Resource) {
            titleLabel.text = resource.title
            descLabel.text = resource.description
            timeLabel.text = resource.estimatedReadTime
            badgeLabel.text = resource.category.rawValue
            thumbImageView.image = UIImage(named: resource.imageURL ?? "")
            
            // Correct category colors
            switch resource.category {
                
            case .featured:
                badgeLabel.backgroundColor = UIColor.systemPink
                
            case .health:
                badgeLabel.backgroundColor = UIColor.systemTeal
                
            case .wellness:
                badgeLabel.backgroundColor = UIColor.systemPurple
                
            case .lifestyle:
                badgeLabel.backgroundColor = UIColor.systemOrange
                
            case .fitness:
                badgeLabel.backgroundColor = UIColor.systemGreen
                
            case .skincare:
                badgeLabel.backgroundColor = UIColor.systemBlue
            }
            
            badgeLabel.layer.masksToBounds = true
        }
}
