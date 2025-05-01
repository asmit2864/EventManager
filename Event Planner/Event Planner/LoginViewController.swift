//
//  LoginViewController.swift
//  Event Planner
//
//  Created by ARUN KUMAR YADAV on 28/04/25.
//

import UIKit

struct User {
    var username: String
    var password: String
}

class LoginViewController: UIViewController {
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func homebtn(_ sender: Any) {
        if let loginSignupVC = storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") {
                loginSignupVC.modalPresentationStyle = .fullScreen
                present(loginSignupVC, animated: true, completion: nil)
            }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                print("Username or Password is empty")
            
                let alert = UIAlertController(title: "Missing Fields", message: "Please fill all required fields.", preferredStyle: .alert)
            
                alert.addAction(UIAlertAction(title: "OK", style: .default))
            
                present(alert, animated: true)
            
                return
            }
            
        // Check if user exists
        for user in users {
            if user.username == username && user.password == password {
                    print("Login successful")
                    // Navigate to TabBarController
                    if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
                            tabBarVC.modalPresentationStyle = .fullScreen
                            present(tabBarVC, animated: true, completion: nil)
                        }
                    return
                }
            }
            
            print("Invalid username or password")
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
                print("Username or Password is empty")
                let alert = UIAlertController(title: "Missing Fields", message: "Please fill all required fields.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            // Check if username already exists
            for user in users {
                if user.username == username {
                    print("Username already exists")
                    return
                }
            }
            
            // If not then create new user
            let newUser = User(username: username, password: password)
            users.append(newUser)
            print("User signed up successfully")
        
        
            let alert = UIAlertController(title: "Success", message: "Signed up successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
