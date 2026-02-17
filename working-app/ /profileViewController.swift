//
//  ProfileViewController.swift
//  HerHub
//
// this is the profile screen where user can see their info

import UIKit

class profileViewController: UIViewController {

    // UI elements - connected from storyboard
    @IBOutlet weak var profileCard: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var cycleCard: UIView!
    @IBOutlet weak var periodCard: UIView!

    @IBOutlet weak var cycleValueLabel: UILabel!
    @IBOutlet weak var periodValueLabel: UILabel!

    @IBOutlet weak var settingsStackContainer: UIView!
    @IBOutlet weak var notificationRow: UIView!
    @IBOutlet weak var EditProfile: UIView!
    @IBOutlet weak var LogOut: UIView!

    // gradient layers for background
    private let profileGradient = CAGradientLayer()
    private let backgroundGradient = CAGradientLayer()
    
    // store the current logged in user
    private var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Profile view loaded!") // debug
        setupUI() // setup all the UI stuff
        
        // Load user data when screen loads
        loadUserData()
        
        // listen for profile updates
        NotificationCenter.default.addObserver(self, selector: #selector(reloadProfileData), name: NSNotification.Name("UserProfileUpdated"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileGradient.frame = profileCard.bounds
        backgroundGradient.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Refresh data when view appears (in case it was updated elsewhere)
        loadUserData()
    }
    
    // reload the profile when data changes
    @objc private func reloadProfileData() {
        print("reloading profile data...")
        loadUserData()
    }
    
    // handle edit button tap
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        guard let user = currentUser else {
            print("No user data! trying to reload")
            
            // tell user to wait
            let alert = UIAlertController(
                title: "Loading Profile",
                message: "Please wait while we load your profile data...",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            
            // try loading again
            loadUserData()
            return
        }
        
        print("opening edit screen for user: \(user.userName ?? "no name")")
        
        // open edit profile screen
        let storyboard = UIStoryboard(name: "editProfile", bundle: nil)
        if let editVC = storyboard.instantiateInitialViewController() as? EditProfileViewController {
            editVC.currentUser = user // pass current user data
            editVC.modalPresentationStyle = .fullScreen
            present(editVC, animated: true, completion: nil)
        }
    }
    
    @objc func logoutTapped() {
        let alert = UIAlertController(
            title: "Log Out",
            message: "Are you sure you want to log out?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive) { _ in
            self.performLogout()
        })
        
        present(alert, animated: true)
    }
    
    private func performLogout() {
      
        AuthManager.shared.signOut()
        

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            if let authVC = storyboard.instantiateInitialViewController() {
                window.rootViewController = authVC
                window.makeKeyAndVisible()
            }
        }
    }
}

// UI setup functions
extension profileViewController {

    func setupUI() {
        // call all setup methods
        setupBackground()
        setupNavigationBar()
        setupProfileCard()
        setupCards()
        setupSettings()
    }
    
    // setup background gradient - TODO: maybe change colors later
    private func setupBackground() {
        backgroundGradient.frame = view.bounds
        // pink gradient colors
        backgroundGradient.colors = [
            UIColor(red: 1.0, green: 0.95, blue: 0.97, alpha: 1.0).cgColor,
            UIColor(red: 0.96, green: 0.85, blue: 0.92, alpha: 1.0).cgColor
        ]
        backgroundGradient.startPoint = CGPoint(x: 0.5, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(backgroundGradient, at: 0)
    }

    private func setupNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // setup the profile card at top
    private func setupProfileCard() {
        profileCard.layer.cornerRadius = 20 // rounded corners
        profileCard.clipsToBounds = true

        // purple to pink gradient
        profileGradient.colors = [
            UIColor.systemPurple.withAlphaComponent(0.7).cgColor,
            UIColor.systemPink.withAlphaComponent(0.7).cgColor
        ]
        profileGradient.startPoint = CGPoint(x: 0, y: 0)
        profileGradient.endPoint = CGPoint(x: 1, y: 1)
        profileCard.layer.insertSublayer(profileGradient, at: 0)

        // make profile image circular
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        profileImage.backgroundColor = UIColor.white.withAlphaComponent(0.3)

        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .white
    }

    // setup cycle and period cards
    private func setupCards() {
        let cards = [cycleCard, periodCard]

        for card in cards {
            guard let card = card else { continue }
            card.layer.cornerRadius = 15
            card.backgroundColor = .white
            // add shadow for depth
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOpacity = 0.1
            card.layer.shadowOffset = CGSize(width: 0, height: 4)
            card.layer.shadowRadius = 8
            card.layer.masksToBounds = false
        }
    }

    // setup settings section at bottom
    private func setupSettings() {
        settingsStackContainer.layer.cornerRadius = 15
        settingsStackContainer.clipsToBounds = true
        settingsStackContainer.backgroundColor = .clear

        notificationRow.layer.cornerRadius = 15
        notificationRow.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        notificationRow.backgroundColor = .white

        EditProfile.layer.cornerRadius = 0
        EditProfile.backgroundColor = .white

        LogOut.layer.cornerRadius = 15
        LogOut.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        LogOut.backgroundColor = .white
        
        // add tap gesture for logout
        let logoutTap = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
        LogOut.isUserInteractionEnabled = true
        LogOut.addGestureRecognizer(logoutTap)

        // shadow for settings container
        settingsStackContainer.layer.shadowColor = UIColor.black.cgColor
        settingsStackContainer.layer.shadowOpacity = 0.08
        settingsStackContainer.layer.shadowOffset = CGSize(width: 0, height: 3)
        settingsStackContainer.layer.shadowRadius = 10
        settingsStackContainer.layer.masksToBounds = false
    }
}

// loading and displaying user data
extension profileViewController {
    
    // load user data from database
    func loadUserData() {
        Task {
            do {
                // get current user from auth manager
                guard let user = AuthManager.shared.currentUser else {
                    print("no user logged in!")
                    return
                }
                
                print("Loading profile for: \(user.email ?? "unknown")")
                
                // get baseline profile data
                let baseline = try await CycleDataController.shared.getBaselineProfile(forUser: user.id)
                
                // update UI on main thread
                await MainActor.run {
                    updateProfileUI(user: user, baseline: baseline)
                }
            } catch {
                print("error loading profile: \(error)")
            }
        }
    }
    
    // update UI with user data
    func updateProfileUI(user: User, baseline: CycleBaselineProfile?) {
        // add baseline to user
        var updatedUser = user
        updatedUser.baselineProfile = baseline
        
        self.currentUser = updatedUser
        
        // set name label
        nameLabel.text = user.userName ?? user.email ?? user.phoneNumber ?? "User"
        
        // display cycle length
        if let cycleLength = baseline?.baseCycleLength {
            cycleValueLabel.text = "\(cycleLength) days"
        } else {
            cycleValueLabel.text = "-- days"
        }
        
        // display period length
        if let periodLength = baseline?.basePeriodLength {
            periodValueLabel.text = "\(periodLength) days"
        } else {
            periodValueLabel.text = "-- days"
        }
        
        print("profile updated successfully")
    }
}
