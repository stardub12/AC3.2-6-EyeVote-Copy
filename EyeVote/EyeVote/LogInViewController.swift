//
//  ViewController.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/6/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit
import SnapKit

class LogInViewController: UIViewController {


   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = EveVoteColor.primaryColor
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
        
        let usernameTextField = UITextField()
        view.addSubview(usernameTextField)
        usernameTextField.text = "USERNAME"
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.layer.borderWidth = 5
        usernameTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(imageView.snp.bottom).offset(20)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview().multipliedBy(0.8)
            view.height.equalTo(44)
        })
        
        let passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        passwordTextField.text = "PASSWORD"
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
        registerButton.setTitleColor(UIColor.black, for: .normal)
        registerButton.layer.borderColor = UIColor.black.cgColor
        registerButton.layer.borderWidth = 5
        registerButton.snp.makeConstraints({ (view) in
            view.bottom.equalTo(self.view.snp.bottom).inset(20)
            view.width.equalTo(150)
            view.height.equalTo(44)
            view.centerX.equalTo(self.view.snp.centerX)
        })
        registerButton.addTarget(self, action: #selector(tappedRegisterButton(sender:)), for: .touchUpInside)
        
        let loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.setTitle("LOG IN", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 5
        loginButton.snp.makeConstraints({ (view) in
            view.bottom.equalTo(self.view.snp.bottom).inset(70)
            view.width.equalTo(150)
            view.height.equalTo(44)
            view.centerX.equalTo(self.view.snp.centerX)
        })
        loginButton.addTarget(self, action: #selector(tappedLoginButton(sender:)), for: .touchUpInside)
    }
    
    internal func tappedLoginButton(sender: UIButton) {
        print("Log In Pressed")
    }
    
    internal func tappedRegisterButton(sender: UIButton) {
        print("Register pressed")
    }
}
