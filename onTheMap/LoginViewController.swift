//
//  ViewController.swift
//  onTheMap
//
//  Created by Waiel Eid on 6/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        activityIndicator.startAnimating();
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if( email.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Information required", message: "Email and Password can not be empty!\n Please fill the required fileds to login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil) )
            
            self.present(alert, animated: true)
        }
        
        
        activityIndicator.stopAnimating()
        
    }
    
}

