//
//  DailyCheckInViewController.swift
//  HerHub
//
//  Created by Dhruv on 10/11/25.
//

import UIKit

class DailyCheckInViewController: UIViewController {

    // MARK: - UI Components
    
    // Background Blur
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Container for content (white card look)
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 30
        view.layer.cornerCurve = .continuous
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Header
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        // Dynamic greeting based on time of day
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:
            label.text = "Good Morning ☀️"
        case 12..<17:
            label.text = "Good Afternoon 🌤️"
        case 17..<21:
            label.text = "Good Evening 🌅"
        default:
            label.text = "Good Night 🌙"
        }
        
        label.font = UIFont(name: "SFProRounded-Bold", size: 28) ?? .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        label.text = formatter.string(from: Date())
        label.font = UIFont(name: "SFProRounded-Medium", size: 16) ?? .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // SLEEP SECTION
    private let sleepContainer = UIView()
    private let sleepTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sleep Duration 😴"
        label.font = UIFont(name: "SFProRounded-Semibold", size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sleepValueLabel: UILabel = {
        let label = UILabel()
        label.text = "7.0 hrs"
        label.font = UIFont(name: "SFProRounded-Bold", size: 32) ?? .boldSystemFont(ofSize: 32)
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.6, alpha: 1) // Deep Blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sleepSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 12
        slider.value = 7.0
        slider.minimumTrackTintColor = UIColor(red: 0.2, green: 0.2, blue: 0.6, alpha: 1)
        slider.thumbTintColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    // STRESS SECTION
    private let stressContainer = UIView()
    private let stressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stress Level 🧠"
        label.font = UIFont(name: "SFProRounded-Semibold", size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stressEmojiLabel: UILabel = {
        let label = UILabel()
        label.text = "😐"
        label.font = .systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stressValueLabel: UILabel = {
        let label = UILabel()
        label.text = "5 / 10"
        label.font = UIFont(name: "SFProRounded-Bold", size: 24) ?? .boldSystemFont(ofSize: 24)
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = 5
        slider.minimumTrackTintColor = .systemOrange
        slider.thumbTintColor = .white
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    // PERIOD STARTED TOGGLE
    private let periodToggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Period Started Today?"
        label.font = UIFont(name: "SFProRounded-Semibold", size: 18) ?? .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let periodSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = UIColor(red: 0.82, green: 0.23, blue: 0.56, alpha: 1) // Figma pink
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    // SAVE BUTTON
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Check-in", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 18) ?? .boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.5, alpha: 1) // Rose Pink
        button.layer.cornerRadius = 25
        button.layer.cornerCurve = .continuous
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    // MARK: - Properties
    var onSave: (() -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear // Transparent for modal presentation style
        setupUI()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Add Blur
        view.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Add Card
        view.addSubview(contentContainer)
        
        // Layout: Fill the sheet
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: view.topAnchor),
            contentContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add Components to Container
        [titleLabel, dateLabel, sleepTitleLabel, sleepValueLabel, sleepSlider,
         stressTitleLabel, stressEmojiLabel, stressValueLabel, stressSlider,
         periodToggleLabel, periodSwitch, saveButton].forEach {
            contentContainer.addSubview($0)
        }
        
        // Constraints
        NSLayoutConstraint.activate([
            // Header
            titleLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            // Sleep Section
            sleepTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            sleepTitleLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            sleepValueLabel.topAnchor.constraint(equalTo: sleepTitleLabel.bottomAnchor, constant: 10),
            sleepValueLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            sleepSlider.topAnchor.constraint(equalTo: sleepValueLabel.bottomAnchor, constant: 10),
            sleepSlider.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 30),
            sleepSlider.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -30),
            
            // Stress Section
            stressTitleLabel.topAnchor.constraint(equalTo: sleepSlider.bottomAnchor, constant: 30),
            stressTitleLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            stressEmojiLabel.topAnchor.constraint(equalTo: stressTitleLabel.bottomAnchor, constant: 10),
            stressEmojiLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            stressValueLabel.topAnchor.constraint(equalTo: stressEmojiLabel.bottomAnchor, constant: 5),
            stressValueLabel.centerXAnchor.constraint(equalTo: contentContainer.centerXAnchor),
            
            stressSlider.topAnchor.constraint(equalTo: stressValueLabel.bottomAnchor, constant: 15),
            stressSlider.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 30),
            stressSlider.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -30),
            
            // PERIOD TOGGLE (New)
            periodToggleLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 40),
            periodToggleLabel.centerYAnchor.constraint(equalTo: periodSwitch.centerYAnchor),
            
            periodSwitch.topAnchor.constraint(equalTo: stressSlider.bottomAnchor, constant: 40),
            periodSwitch.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -40),
            
            // BUTTON
            saveButton.bottomAnchor.constraint(equalTo: contentContainer.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            saveButton.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 30),
            saveButton.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupActions() {
        sleepSlider.addTarget(self, action: #selector(sleepChanged), for: .valueChanged)
        stressSlider.addTarget(self, action: #selector(stressChanged), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func sleepChanged(_ sender: UISlider) {
        // Snap to 0.5 increments
        let step: Float = 0.5
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        sleepValueLabel.text = "\(String(format: "%.1f", roundedValue)) hrs"
    }
    
    @objc private func stressChanged(_ sender: UISlider) {
        let value = Int(round(sender.value))
        sender.value = Float(value)
        stressValueLabel.text = "\(value) / 10"
        
        switch value {
        case 1...3:
            stressValueLabel.textColor = UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1) // Green
            stressEmojiLabel.text = "😌"
            sliderColor(UIColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1))
        case 4...7:
            stressValueLabel.textColor = .systemOrange
            stressEmojiLabel.text = "😐"
            sliderColor(.systemOrange)
        case 8...10:
            stressValueLabel.textColor = .systemRed
            stressEmojiLabel.text = "😫"
            sliderColor(.systemRed)
        default: break
        }
    }
    
    private func sliderColor(_ color: UIColor) {
        stressSlider.minimumTrackTintColor = color
        stressSlider.thumbTintColor = color
    }
    
    @objc private func saveTapped() {
        guard let currentUser = AuthManager.shared.currentUser else { return }
        
        let sleep = Double(sleepSlider.value)
        let stress = Int(stressSlider.value)
        let didStartParams = periodSwitch.isOn // Capture toggle value
        
        // Create Check-In Object
        var checkIn = CycleCheckIn(
            id: UUID(),
            user_id: currentUser.id,
            date: Date(),
            symptomsPresent: false, // Default for now
            currentStress: stress,
            sleepHours: sleep,
            sickOrMeds: false,
            exerciseChange: .same,
            periodStartedToday: didStartParams
        )
        
        // Save Logic
        Task {
            do {
                try await CycleDataController.shared.saveCheckIn(checkIn, forUser: currentUser.id)
                print(" [DailyCheckIn] Saved successfully")
                
                await MainActor.run {
                    self.onSave?() // Clean callback
                    self.dismiss(animated: true)
                }
            } catch {
                print(" [DailyCheckIn] Error saving: \(error)")
            }
        }
    }
}
