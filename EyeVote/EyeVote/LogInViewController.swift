//
//  ViewController.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/6/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class LogInViewController: UIViewController {
    
    //status bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //navigationController?.title = "LOGIN/REGISTER"
        view.backgroundColor = EyeVoteColor.primaryColor
        
        setupView()
    }
    
    func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.snp.makeConstraints({ (view) in
            view.centerX.equalTo(self.view)
            view.width.height.equalTo(150)
            view.top.equalTo(130)
        })
        
        view.addSubview(usernameTextField)
        
        
        usernameTextField.text = "USERNAME"
        usernameTextField.textColor = EyeVoteColor.accentColor
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.layer.borderWidth = 5
        
        usernameTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(imageView.snp.bottom).offset(20)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview().multipliedBy(0.8)
            view.height.equalTo(44)
        })
        
        view.addSubview(passwordTextField)
        
        passwordTextField.text = "PASSWORD"
        passwordTextField.textColor = EyeVoteColor.accentColor
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 5
        
        passwordTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(usernameTextField.snp.bottom).offset(20)
            view.centerX.equalTo(self.view)
            view.width.equalTo(usernameTextField.snp.width)
            view.height.equalTo(44)
        })
        
        let registerButton = UIButton()
        view.addSubview(registerButton)
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.setTitleColor(EyeVoteColor.textIconColor, for: .normal)
        registerButton.layer.borderColor = EyeVoteColor.textIconColor.cgColor
        registerButton.layer.borderWidth = 5
        registerButton.snp.makeConstraints({ (view) in
            view.bottom.equalTo(self.view.snp.bottom).inset(70)
            view.width.equalTo(150)
            view.height.equalTo(44)
            view.centerX.equalTo(self.view.snp.centerX)
        })
        registerButton.addTarget(self, action: #selector(tappedRegisterButton(sender:)), for: .touchUpInside)
        
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.setTitleColor(EyeVoteColor.textIconColor, for: .normal)
        loginButton.layer.borderColor = EyeVoteColor.textIconColor.cgColor
        loginButton.layer.borderWidth = 5
        loginButton.snp.makeConstraints({ (view) in
            view.bottom.equalTo(self.view.snp.bottom).inset(120)
            view.width.equalTo(150)
            view.height.equalTo(44)
            view.centerX.equalTo(self.view.snp.centerX)
        })
        loginButton.addTarget(self, action: #selector(tappedLoginButton(sender:)), for: .touchUpInside)
    }
    
    internal func tappedLoginButton(sender: UIButton) {
        
        print("Log In Pressed IMPORT FIREBASE AND STUFF")
        
        guard let userName = usernameTextField.text, let password = passwordTextField.text else {
            print("cannot validate username/password")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: userName, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if user != nil {
                print("signed in")
            } else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    internal func tappedRegisterButton(sender: UIButton) {
        print("Register pressed")
        guard let userName = usernameTextField.text, let password = passwordTextField.text else {
            print("cannot validate username/password")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: userName, password: password, completion: { (user: FIRUser?, error) in
            
            guard let uid = user?.uid else { return }
            
            let reference = FIRDatabase.database().reference(fromURL: "https://eyevote-3f1e8.firebaseio.com/")
            let userReference = reference.child("users").child(uid)
            let login = ["userName": userName, "password": password]
            userReference.updateChildValues(login, withCompletionBlock: { (error, reference) in
                
                guard let error = error else {
                    print("Error detected")
                    return
                }
                if let user = user {
                    print("Got \(user.email)")
                } else {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        })
    }
    
    internal lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "USERNAME"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5
        return textField
    }()
    
    internal lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "PASSWORD"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5
        return textField
    }()
}
