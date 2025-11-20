import UIKit

class TrackerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var checkInContainerView: UIView!
    @IBOutlet weak var forecastContainerView: UIView!
    @IBOutlet weak var todayInsightContainerView: UIView!
    
    @IBOutlet weak var moodValueLabel: UILabel!
    
    @IBOutlet weak var cycleDayValueLabel: UILabel!
    @IBOutlet weak var nextPeriodValueLabel: UILabel!
    
    @IBOutlet weak var energyValueLabel: UILabel!
    @IBOutlet var dayLabels: [UILabel]!
    @IBOutlet var dateLabels: [UILabel]!
    @IBOutlet var moodLabels: [UILabel]!
    @IBOutlet var fertilityBoxes: [UILabel]!
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
// MARK: - Load Cycle Data
extension TrackerViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task { await loadCycleData() }
    }

//    private func loadCycleData() async {
//        do {
//            let checkIns = try await CycleDataController.shared.getCheckIns()
//            let predictions = try await CycleDataController.shared.getPredictions()
//
//            DispatchQueue.main.async {
//                if let lastCheckIn = checkIns.last {
//                    self.updateCheckInUI(lastCheckIn)
//                }
//                if let prediction = predictions.last {
////                    self.updateInsightUI(prediction)
//                    self.updateForecastUI(prediction.sevenDayForecast)
//                }
//            }
//
//        } catch {
//            print("❌ Error loading data:", error.localizedDescription)
//        }
//    }

    // MARK: - Update Check-In Section
    private func updateCheckInUI(_ checkIn: CycleCheckIn) {
        moodValueLabel.text = checkIn.symptomsPresent ? "Mixed" : "Good"
        cycleDayValueLabel.text = formattedDay(checkIn.date)
        nextPeriodValueLabel.text = checkIn.periodStartedToday == true ? "Started" : "No"
        energyValueLabel.text = checkIn.sleepHours >= 7 ? "High" : "Low"
    }

    private func formattedDay(_ date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return "\(day)"
    }

//    // MARK: - Update Insight Section
//    private func updateInsightUI(_ prediction: CyclePrediction) {
//        insightTitleLabel.text = "Today's Insight"
//
//        let today = prediction.sevenDayForecast.first
//        insightDescriptionLabel.text = today?.weatherDescription ?? "No insight available."
//    }

    // MARK: - Update 7-Day Forecast Section (Using forecastContainerView)
    private func updateForecastUI(_ items: [DailyForecast]) {

        guard items.count >= 7 else { return }

        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEE"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"

        for i in 0..<7 {

            let forecast = items[i]

            // DAY LABEL (Mon, Tue, ...)
            dayLabels[i].text = dayFormatter.string(from: forecast.date)
            dayLabels[i].textColor = UIColor.systemGray
            dayLabels[i].font = UIFont.systemFont(ofSize: 12, weight: .medium)

            // DATE LABEL (16, 17...)
            dateLabels[i].text = dateFormatter.string(from: forecast.date)
            dateLabels[i].font = UIFont.boldSystemFont(ofSize: 14)
            dateLabels[i].textColor = UIColor.black

            // MOOD LABEL (Good, Great...)
            moodLabels[i].text = forecast.phaseDescription   // we’ll define below
            moodLabels[i].font = UIFont.systemFont(ofSize: 12)
            moodLabels[i].textColor = UIColor.systemGray2

            // FERTILITY BOX (Low/Med/High)
            let box = fertilityBoxes[i]
            box.text = forecast.fertility.rawValue.capitalized
            box.textAlignment = .center
            box.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            box.textColor = .white
            box.layer.cornerRadius = 6
            box.layer.masksToBounds = true

            switch forecast.fertility {
            case .low:
                box.backgroundColor = UIColor(red: 1, green: 0.35, blue: 0.47, alpha: 1) // #FF5A78
            case .medium:
                box.backgroundColor = UIColor(red: 1, green: 0.80, blue: 0.25, alpha: 1) // #FFCC3F
            case .high:
                box.backgroundColor = UIColor(red: 0.25, green: 0.51, blue: 1, alpha: 1) // #3F82FF
            }
        }
    }

    private func makeForecastItem(day: DailyForecast, formatter: DateFormatter) -> UIView {

        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 4

        let dayLabel = UILabel()
        dayLabel.text = formatter.string(from: day.date)
        dayLabel.font = .systemFont(ofSize: 12)
        dayLabel.textColor = .darkGray

        let fertilityLabel = UILabel()
        fertilityLabel.text = day.fertility.rawValue.capitalized
        fertilityLabel.font = .systemFont(ofSize: 12)

        let energyLabel = UILabel()
        energyLabel.text = day.energy.rawValue.capitalized
        energyLabel.font = .systemFont(ofSize: 12)

        vStack.addArrangedSubview(dayLabel)
        vStack.addArrangedSubview(fertilityLabel)
        vStack.addArrangedSubview(energyLabel)

        return vStack
    }
    private func loadCycleData() async {

        // --------------------------------------
        // ✅ DUMMY DATA FOR INSTANT TESTING
        // --------------------------------------

        let dummyCheckIn = CycleCheckIn(
            date: Date(),
            symptomsPresent: false,
            currentStress: 3,
            sleepHours: 7.5,
            sickOrMeds: false,
            exerciseChange: .same,
            periodStartedToday: false
        )

        let dummyForecast: [DailyForecast] = [
            DailyForecast(date: Date(),
                          phase: .follicular,
                          fertility: .low,
                          energy: .high,
                          weatherDescription: "Sunny: strong focus + energy"),

            DailyForecast(date: Date().addingTimeInterval(86400 * 1),
                          phase: .follicular,
                          fertility: .medium,
                          energy: .high,
                          weatherDescription: "Clear skies: stable mood"),

            DailyForecast(date: Date().addingTimeInterval(86400 * 2),
                          phase: .ovulation,
                          fertility: .high,
                          energy: .high,
                          weatherDescription: "Peak day: confidence high"),

            DailyForecast(date: Date().addingTimeInterval(86400 * 3),
                          phase: .luteal,
                          fertility: .medium,
                          energy: .medium,
                          weatherDescription: "Cloudy: slight emotional dip"),

            DailyForecast(date: Date().addingTimeInterval(86400 * 4),
                          phase: .luteal,
                          fertility: .low,
                          energy: .medium,
                          weatherDescription: "Light rain: take breaks"),

            DailyForecast(date: Date().addingTimeInterval(86400 * 5),
                          phase: .menstrual,
                          fertility: .low,
                          energy: .low,
                          weatherDescription: "Rainy day: rest recommended"),

            DailyForecast(date: Date().addingTimeInterval(86400 * 6),
                          phase: .menstrual,
                          fertility: .low,
                          energy: .low,
                          weatherDescription: "Heavy clouds: go easy today")
        ]

        // --------------------------------------
        // 🔥 INJECT DUMMY DATA INTO EXISTING UI
        // --------------------------------------
        DispatchQueue.main.async {
            self.updateCheckInUI(dummyCheckIn)
//            self.updateInsightUI(dummyPrediction)
            self.updateForecastUI(dummyForecast)
        }

        // --------------------------------------
        // ❗ REMOVE BELOW WHEN READY FOR SUPABASE
        // ❗ Just delete this whole function and restore your old one
        // --------------------------------------
    }
}
extension DailyForecast {
    var phaseDescription: String {
        switch phase {
        case .follicular: return "Good"
        case .ovulation:  return "Happy"
        case .luteal:     return "Okay"
        case .menstrual:  return "Calm"
        }
    }
}
