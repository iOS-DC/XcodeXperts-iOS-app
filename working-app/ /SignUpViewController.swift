//
//  SignUpViewController.swift
//  HerHub
//
//  create new account screen
//

import UIKit

// signup controller
    
class SignUpViewController: UIViewController {
    
    // text input fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("signup screen loaded") // debug
        setupUI() // setup UI
    }
    
    // setup UI
    private func setupUI() {
        errorLabel?.isHidden = true // hide errors initially
        passwordTextField?.isSecureTextEntry = true // hide password
        confirmPasswordTextField?.isSecureTextEntry = true // hide confirm password
        
        // disable autocorrect for passwords
        passwordTextField?.textContentType = .oneTimeCode
        confirmPasswordTextField?.textContentType = .oneTimeCode
        
        // set text field delegates
        [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField].forEach {
            $0?.delegate = self
        }
        
        // tap to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        signUpButton?.layer.cornerRadius = 10 // round corners
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // when signup button is tapped
    @IBAction func signUpButtonTapped(_ sender: Any) {
        // check all fields are filled
        guard let name = nameTextField?.text, !name.isEmpty else {
            showError("Please enter your name")
            return
        }
        
        guard let email = emailTextField?.text, !email.isEmpty else {
            showError("Please enter your email")
            return
        }
        
        // validate email format
        guard isValidEmail(email) else {
            showError("Please enter a valid email")
            return
        }
        
        guard let password = passwordTextField?.text, !password.isEmpty else {
            showError("Please enter a password")
            return
        }
        
        // check passwords match
        guard let confirmPassword = confirmPasswordTextField?.text, password == confirmPassword else {
            showError("Passwords do not match")
            return
        }
        
        signUp(name: name, email: email, password: password) // create account
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    private func signUp(name: String, email: String, password: String) {
        signUpButton?.isEnabled = false
        signUpButton?.setTitle("Creating account...", for: .normal)
        errorLabel?.isHidden = true
        Task {
            do {
                let user = try await AuthManager.shared.signUp(name: name, email: email, password: password)
                
                await MainActor.run {
                    print("[SignUp] Account created: \(user.email ?? "")")
                    self.navigateToOnboarding()
                }
            } catch {
                await MainActor.run {
                    self.showError(error.localizedDescription)
                    self.signUpButton?.isEnabled = true
                    self.signUpButton?.setTitle("Create Account", for: .normal)
                }
            }
        }
    }
    
    private func showError(_ message: String) {
        errorLabel?.text = message
        errorLabel?.isHidden = false
    }
    
    private func navigateToOnboarding() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let storyboard = UIStoryboard(name: "BaselineOnboarding", bundle: nil)
            if let onboardingVC = storyboard.instantiateInitialViewController() {
                window.rootViewController = onboardingVC
                window.makeKeyAndVisible()
            }
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField?.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField?.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signUpButtonTapped(self)
        }
        return true
    }
}
