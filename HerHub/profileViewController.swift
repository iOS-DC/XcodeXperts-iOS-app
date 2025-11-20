//
//  ProfileViewController.swift
//  HerHub
//

import UIKit

class profileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileCard: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var cycleCard: UIView!
    @IBOutlet weak var periodCard: UIView!

    @IBOutlet weak var cycleValueLabel: UILabel!
    @IBOutlet weak var periodValueLabel: UILabel!

    @IBOutlet weak var settingsStackContainer: UIView!   // 🔥 add outlet for full settings section bg
    @IBOutlet weak var notificationRow: UIView!
    @IBOutlet weak var helpRow: UIView!
    @IBOutlet weak var aboutRow: UIView!

    private let profileGradient = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileGradient.frame = profileCard.bounds    // 🔥 FIX gradient overflow
    }
}

// MARK: - UI SETUP
extension profileViewController {

    func setupUI() {
        setupNavigationBar()
        setupProfileCard()
        setupMetricCards()
        setupSettingsRows()
    }

    // MARK: Navigation Bar
    private func setupNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: Profile Card (Gradient + Round Corners)
    private func setupProfileCard() {
        profileCard.layer.cornerRadius = 24
        profileCard.clipsToBounds = true

        // gradient
        profileGradient.colors = [
            UIColor.systemPurple.withAlphaComponent(0.75).cgColor,
            UIColor.systemPink.withAlphaComponent(0.75).cgColor
        ]
        profileGradient.startPoint = CGPoint(x: 0, y: 0)
        profileGradient.endPoint = CGPoint(x: 1, y: 1)
        profileCard.layer.insertSublayer(profileGradient, at: 0)

        // profile image
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        profileImage.backgroundColor = UIColor.white.withAlphaComponent(0.35)

        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .white
    }

    // MARK: Metric Cards
    private func setupMetricCards() {
        let cards = [cycleCard, periodCard]

        for card in cards {
            guard let card = card else { continue }
            card.layer.cornerRadius = 18
            card.backgroundColor = .white

            card.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
            card.layer.shadowOpacity = 1
            card.layer.shadowOffset = CGSize(width: 0, height: 3)
            card.layer.shadowRadius = 6
        }
    }

    // MARK: Settings Rows (Rounded only TOP + BOTTOM rows)
    private func setupSettingsRows() {

        // Round full container
        settingsStackContainer.layer.cornerRadius = 18
        settingsStackContainer.clipsToBounds = true
        settingsStackContainer.backgroundColor = .clear

        // 🔥 Top row
        notificationRow.layer.cornerRadius = 18
        notificationRow.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        notificationRow.backgroundColor = .white

        // Middle row – no rounding
        helpRow.layer.cornerRadius = 0
        helpRow.backgroundColor = .white

        // 🔥 Bottom row
        aboutRow.layer.cornerRadius = 18
        aboutRow.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        aboutRow.backgroundColor = .white

        // Shadow on the container (not the rows)
        settingsStackContainer.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        settingsStackContainer.layer.shadowOpacity = 1
        settingsStackContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        settingsStackContainer.layer.shadowRadius = 10
    }
}
