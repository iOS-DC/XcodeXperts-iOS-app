import UIKit

class TrackerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var checkInContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set main view background to white
        view.backgroundColor = .white
        
        // Set ContentView background color to match Figma (very light pink/lavender)
        contentView.backgroundColor = UIColor(red: 0.98, green: 0.94, blue: 0.98, alpha: 1.0)
        
        // Style the Today's Check-in container with 3D shadow
        if let containerView = checkInContainerView {
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 20
            containerView.layer.masksToBounds = false
            
            // 3D Shadow effect - softer and more subtle
            containerView.layer.shadowColor = UIColor(red: 0.85, green: 0.70, blue: 0.85, alpha: 0.25).cgColor
            containerView.layer.shadowOffset = CGSize(width: 0, height: 6)
            containerView.layer.shadowRadius = 15
            containerView.layer.shadowOpacity = 1.0
        }
    }
}
