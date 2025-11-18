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
        testSupabaseConnection()
                // Fetch baseline profile data
//                fetchBaselineProfile()
        // Do any additional setup after loading the view.
    }
    
//    private func fetchBaselineProfile() {
//           Task {
//               do {
//                   // Fetch the baseline profile from the controller
//                   if let profile = try await CycleDataController.shared.getBaselineProfile() {
//                       // Update UI on main thread
//                       await MainActor.run {
//                           cycleLength.text = "\(profile.baseCycleLength) days"
//                           periodLength.text = "\(profile.basePeriodLength) days"
//                       }
//                   } else {
//                       // No profile found
//                       await MainActor.run {
//                           cycleLength.text = "Not set"
//                           periodLength.text = "Not set"
//                       }
//                   }
//               } catch {
//                   // Handle error
//                   print("Error fetching baseline profile: \(error)")
//                   await MainActor.run {
//                       cycleLength.text = "Error"
//                       periodLength.text = "Error"
//                       
//                       // Optionally show an alert
//                       showErrorAlert(message: "Unable to load profile data")
//                   }
//               }
//           }
//       }
//       
//       private func showErrorAlert(message: String) {
//           let alert = UIAlertController(
//               title: "Error",
//               message: message,
//               preferredStyle: .alert
//           )
//           alert.addAction(UIAlertAction(title: "OK", style: .default))
//           present(alert, animated: true)
//       }
    private func testSupabaseConnection() {
           Task {
               do {
                   print("🔄 Testing Supabase connection...")
                   
                   // Try to fetch all users to test connection
                   let users = try await UserDataManager().fetchAllUsers()
                   print("✅ Connection successful! Found \(users.count) users")
                   
                   // Create a test user
                   let testUser = User(
                       email: "dhruv.test@herhub.app",
                       phoneNumber: "+91 98765 43210",
                       password: "secure123"
                   )
                   
                   try await UserDataManager().createUser(testUser)
                   print("✅ Test user created successfully!")
                   
                   // Show success alert on main thread
                   await MainActor.run {
                       showSuccessAlert(message: "User created! Check console for details.")
                   }
                   
               } catch {
                   print("❌ Supabase Error: \(error)")
                   
                   // Show error alert on main thread
                   await MainActor.run {
                       showErrorAlert(message: "Connection failed: \(error.localizedDescription)")
                   }
               }
           }
       }
       
       private func showSuccessAlert(message: String) {
           let alert = UIAlertController(
               title: "✅ Success",
               message: message,
               preferredStyle: .alert
           )
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
       
       private func showErrorAlert(message: String) {
           let alert = UIAlertController(
               title: "❌ Error",
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
