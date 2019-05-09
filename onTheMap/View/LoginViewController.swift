//
//  ViewController.swift
//  onTheMap
//
//  Created by Waiel Eid on 6/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        activityIndicator.startAnimating();
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if(email.isEmpty || password.isEmpty) {
            showAlert(title: "Information Required", message: "Email and Password can not be empty!\n Please fill the required fileds to login", handler: nil)
            return
        }
        
        login(username: email, password: password, completion: handleLoginResponse(success:error:))
        activityIndicator.stopAnimating();
    }

    func handleLoginResponse(success: Bool, error: Error?){
        if(success){
            performSegue(withIdentifier: "OnTheMapTabBar", sender: self)
        }else{
            showAlert(title: "Login Failed", message: "Invalid Username and Password \n Please try again.", handler: nil)
        }
    }

    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }

}


extension LoginViewController: UITextFieldDelegate {
    //hide keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //setup keyboard notification
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //remove keyboard notificaiton
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //get the keyboard layout height
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        //reaise keyboard for text editing
        if emailTextField.isEditing || passwordTextField.isEditing{
            let stackSize = self.stackView.frame.maxY;
            let keyboardSize = self.view.frame.height - getKeyboardHeight(notification)
            let offset = stackSize - keyboardSize
            
            if offset < 0 {
                return
            }
            view.frame.origin.y -= offset
        }
    }
    
    // When hiding return to original state
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
}
