//
//  profileViewController.swift
//  HerHub
//
//  Created by Dhruv on 17/11/25.
//

import UIKit

class profileViewController: UIViewController {

    @IBOutlet weak var cycleLength: UILabel!
    @IBOutlet weak var periodLength: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial placeholder text
        // Use dummy data for now
                cycleLength.text = "28 days"
                periodLength.text = "5 days"
                // Fetch baseline profile data
                fetchBaselineProfile()
        // Do any additional setup after loading the view.
    }
    
    private func fetchBaselineProfile() {
           Task {
               do {
                   // Fetch the baseline profile from the controller
                   if let profile = try await CycleDataController.shared.getBaselineProfile() {
                       // Update UI on main thread
                       await MainActor.run {
                           cycleLength.text = "\(profile.baseCycleLength) days"
                           periodLength.text = "\(profile.basePeriodLength) days"
                       }
                   } else {
                       // No profile found
                       await MainActor.run {
                           cycleLength.text = "Not set"
                           periodLength.text = "Not set"
                       }
                   }
               } catch {
                   // Handle error
                   print("Error fetching baseline profile: \(error)")
                   await MainActor.run {
                       cycleLength.text = "Error"
                       periodLength.text = "Error"
                       
                       // Optionally show an alert
                       showErrorAlert(message: "Unable to load profile data")
                   }
               }
           }
       }
       
       private func showErrorAlert(message: String) {
           let alert = UIAlertController(
               title: "Error",
               message: message,
               preferredStyle: .alert
           )
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
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
