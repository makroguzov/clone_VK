//
//  CustomLoginViewController.swift
//  vk
//
//  Created by MACUSER on 07.09.2020.
//  Copyright © 2020 MACUSER. All rights reserved.
//

import UIKit
import Firebase

class CustomLoginViewController: UIViewController {
    static let segueIdentifier = "LogInSegue"
    
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var logInTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.addTarget(self, action: #selector(signInButtonAction(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.addTarget(self, action: #selector(registerButtonAction(_:)), for: .touchUpInside)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listener = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard user != nil else { return }
            
            self?.logInTextField.text = ""
            self?.passwordTextField.text = ""
            
            self?.performSegue(withIdentifier: CustomLoginViewController.segueIdentifier, sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let listener = listener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    @objc func signInButtonAction(_ sender: UIButton) {
        
        guard let email = logInTextField.text, let password = passwordTextField.text else {
            showAlert(message: "Некорректно введен логин или пароль.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (results, error) in
            
            if let error = error {
                self?.showAlert(title: "error", message: error.localizedDescription)
            } 
        }
    }
    
    @objc func registerButtonAction(_ sender: UIButton) {
        
        guard let email = logInTextField.text, let password = passwordTextField.text else {
            showAlert(message: "Некорректно введен логин или пароль.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (results, error) in
            
            if let error = error {
                self?.showAlert(title: "error", message: error.localizedDescription)
            } else {
                Auth.auth().signIn(withEmail: email, password: password)
            }
        }
    }

}
