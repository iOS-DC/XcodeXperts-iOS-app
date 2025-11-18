//
//  ForecastViewController.swift
//  HerHub
//
//  Created by Nihar Sandhu on 18/11/25.
//

import UIKit

class ForecastViewController: UIViewController {

    // MARK: - Outlets (connect from storyboard)
        @IBOutlet weak var topDateContainer: UIView!
        @IBOutlet weak var selectedDateView: UIView!
        @IBOutlet weak var selectedDateLabel: UILabel!
        @IBOutlet weak var selectedDayLabel: UILabel!
        
        @IBOutlet weak var phaseCard: UIView!
        @IBOutlet weak var fertilityCard: UIView!
        @IBOutlet weak var energyCard: UIView!
        
        @IBOutlet weak var symptomsCard: UIView!
        @IBOutlet weak var recommendationsCard: UIView!
        @IBOutlet weak var aboutCard: UIView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
        }
    }


    // MARK: - UI Setup
    extension ForecastViewController {
        
        func setupUI() {
            view.backgroundColor = UIColor(hex: "#F5D3EB")   // soft pink
            
            setupDateStrip()
            setupCards()
            setupTagCards()
        }
        
        
        // MARK: TOP DATE STRIP (rounded white box with shadow)
        private func setupDateStrip() {
            topDateContainer.layer.cornerRadius = 18
            topDateContainer.layer.masksToBounds = false
            topDateContainer.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
            topDateContainer.layer.shadowOpacity = 1
            topDateContainer.layer.shadowRadius = 12
            topDateContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        
        
        // MARK: SELECTED DATE (purple rounded pill)
        private func setupSelectedDate() {
            selectedDateView.layer.cornerRadius = 12
            selectedDateView.backgroundColor = UIColor(hex: "#B84BE2")
            
            selectedDayLabel.textColor = .white
            selectedDateLabel.textColor = .white
            selectedDayLabel.font = UIFont.boldSystemFont(ofSize: 14)
            selectedDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        
        // MARK: BIG WHITE CARDS (phase, symptoms, recommendations, about)
        private func setupCards() {
            
            let allCards = [phaseCard, symptomsCard, recommendationsCard, aboutCard]
            
            allCards.forEach { card in
                card?.layer.cornerRadius = 20
                card?.backgroundColor = .white
                card?.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
                card?.layer.shadowOpacity = 1
                card?.layer.shadowRadius = 16
                card?.layer.shadowOffset = CGSize(width: 0, height: 6)
            }
        }
        
        
        // MARK: FERTILITY + ENERGY TAG CARDS
        private func setupTagCards() {
            
            fertilityCard.layer.cornerRadius = 14
            fertilityCard.backgroundColor = UIColor(hex: "#FDE7EC")
            
            energyCard.layer.cornerRadius = 14
            energyCard.backgroundColor = UIColor(hex: "#ECD3FF")
            
            fertilityCard.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
            fertilityCard.layer.shadowOpacity = 1
            fertilityCard.layer.shadowRadius = 10
            
            energyCard.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
            energyCard.layer.shadowOpacity = 1
            energyCard.layer.shadowRadius = 10
        }

}

// MARK: UIColor HEX helper
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgbValue & 0x0000FF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
