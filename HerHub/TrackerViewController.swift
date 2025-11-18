import UIKit

class TrackerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var checkInContainerView: UIView!
    @IBOutlet weak var forecastContainerView: UIView!
    @IBOutlet weak var todayInsightContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationTitle()

    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        styleCard(checkInContainerView)
        styleCard(forecastContainerView)
        styleInsightCard(todayInsightContainerView)   // UPDATED
    }
    
    // MARK: - Regular White Cards
    private func styleCard(_ containerView: UIView?) {
        guard let container = containerView else { return }
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.layer.masksToBounds = false
        
        container.layer.shadowColor = UIColor(
            red: 0.85, green: 0.70, blue: 0.85, alpha: 0.25
        ).cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 6)
        container.layer.shadowRadius = 15
        container.layer.shadowOpacity = 1.0
    }
    
    // MARK: - Today’s Insight (Soft Pink Gradient)
    private func styleInsightCard(_ containerView: UIView?) {
        guard let container = containerView else { return }
        
        container.layer.cornerRadius = 22
        container.layer.masksToBounds = true
        
        // ---- Gradient Layer ----
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 1.0, green: 0.93, blue: 0.98, alpha: 1).cgColor, // #FFE9F7
            UIColor(red: 1.0, green: 0.96, blue: 1.0, alpha: 1).cgColor   // #FFF5FF
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = container.bounds
        gradient.cornerRadius = 22
        gradient.name = "insightGradient"
        
        // Remove any old gradient to avoid duplicates
        container.layer.sublayers?
            .filter { $0.name == "insightGradient" }
            .forEach { $0.removeFromSuperlayer() }
        
        container.layer.insertSublayer(gradient, at: 0)
        
        // ---- Subtle border ----
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor(red: 1, green: 0.8, blue: 1, alpha: 0.35).cgColor
        
        // ---- Soft outside shadow ----
        container.layer.shadowColor = UIColor(red: 0.85, green: 0.70, blue: 0.85, alpha: 0.3).cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 10
        container.layer.shadowOpacity = 0.5
        container.layer.masksToBounds = false
    }
    private func setupNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Body Climate"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor(red: 0.82, green: 0.23, blue: 0.56, alpha: 1) // Figma pink
        titleLabel.textAlignment = .left
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        let currentDate = dateFormatter.string(from: Date())
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = currentDate
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.textAlignment = .left
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        
        navigationItem.titleView = stack
    }

    
    // Update gradient on layout changes (important!)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        todayInsightContainerView?.layer.sublayers?
            .first(where: { $0.name == "insightGradient" })?
            .frame = todayInsightContainerView.bounds
    }
}
