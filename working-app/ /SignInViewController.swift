//
//  SignInViewController.swift
//  HerHub
//
//  login screen
//

import UIKit

class SignInViewController: UIViewController {
    
    // text fields and buttons
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sign in screen loaded") // debug
        setupUI() // setup UI elements
    }
    
    // setup UI elements
    private func setupUI() {
        errorLabel?.isHidden = true // hide error initially
        passwordTextField?.isSecureTextEntry = true // hide password text
        
        emailTextField?.delegate = self
        passwordTextField?.delegate = self
        
        // dismiss keyboard on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        signInButton?.layer.cornerRadius = 10 // rounded button
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // handle sign in button tap
    @IBAction func signInButtonTapped(_ sender: Any) {
        // validate inputs
        guard let email = emailTextField?.text, !email.isEmpty else {
            showError("Please enter your email")
            return
        }
        guard let password = passwordTextField?.text, !password.isEmpty else {
            showError("Please enter your password")
            return
        }
        signIn(email: email, password: password) // call sign in function
    }
    

    
    private func signIn(email: String, password: String) {
        signInButton?.isEnabled = false
        signInButton?.setTitle("Signing in...", for: .normal)
        errorLabel?.isHidden = true
        
        Task {
            do {
                let user = try await AuthManager.shared.signIn(email: email, password: password)
                
                await MainActor.run {
                    print("[SignIn] Success: \(user.email ?? "")")
                    self.navigateToMainApp()
                }
            } catch {
                await MainActor.run {
                    self.showError(error.localizedDescription)
                    self.signInButton?.isEnabled = true
                    self.signInButton?.setTitle("Sign In", for: .normal)
                }
            }
        }
    }
    
    private func showError(_ message: String) {
        errorLabel?.text = message
        errorLabel?.isHidden = false
    }
    
    private func navigateToMainApp() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let tabBarVC = storyboard.instantiateInitialViewController() {
                window.rootViewController = tabBarVC
                window.makeKeyAndVisible()
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signInButtonTapped(self)
        }
        return true
    }
}
