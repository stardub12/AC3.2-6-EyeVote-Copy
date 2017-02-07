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
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = EyeVoteColor.primaryColor
        setupViewHierarchy()
        configureConstraints()
        buttonTapped()
    }
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.view.addSubview(logo)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
    }
    
    private func configureConstraints(){
        self.edgesForExtendedLayout = []
        
        // Logo
        logo.snp.makeConstraints({ (view) in
            view.centerX.equalTo(self.view)
            view.width.height.equalTo(150)
            view.top.equalToSuperview().offset(10)
        })
        
        // UserName TextField
        usernameTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(logo.snp.bottom).offset(40)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview().multipliedBy(0.8)
            view.height.equalTo(44)
        })
        
        //Password TextField
        passwordTextField.snp.makeConstraints({ (view) in
            view.top.equalTo(usernameTextField.snp.bottom).offset(20)
            view.centerX.equalTo(self.view)
            view.width.equalTo(usernameTextField.snp.width)
            view.height.equalTo(44)
        })
        
        // Login Button
        loginButton.snp.makeConstraints({ (view) in
            view.bottom.equalTo(self.view.snp.bottom).inset(75)
            view.width.equalTo(270)
            view.height.equalTo(44)
            view.centerX.equalTo(self.view.snp.centerX)
        })
        
        // Register Button
        registerButton.snp.makeConstraints({ (view) in
            view.bottom.equalTo(self.view.snp.bottom).inset(20)
            view.width.equalTo(270)
            view.height.equalTo(44)
            view.centerX.equalTo(self.view.snp.centerX)
        })
    }
    
    // MARK: - Actions
    func buttonTapped() {
        registerButton.addTarget(self, action: #selector(tappedRegisterButton(sender:)), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(tappedLoginButton(sender:)), for: .touchUpInside)
    }
    
    internal func tappedLoginButton(sender: UIButton) {
        print("Log In Pressed IMPORT FIREBASE AND STUFF")
        
    }
    
    internal func tappedRegisterButton(sender: UIButton) {
        print("Register pressed")
    }
    
    // MARK: - Lazy Init
    internal lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        return imageView
    }()
    
    internal lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = EyeVoteColor.textIconColor
        textField.attributedPlaceholder = NSAttributedString(string: "USERNAME", attributes: [NSForegroundColorAttributeName : EyeVoteColor.accentColor ])
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5
        return textField
    }()
    
    internal lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName : EyeVoteColor.accentColor ])
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 5
        textField.textColor = EyeVoteColor.textIconColor
        return textField
    }()
    
    internal lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.setTitleColor(EyeVoteColor.textIconColor, for: .normal)
        button.layer.borderColor = EyeVoteColor.textIconColor.cgColor
        button.layer.borderWidth = 0.8
        return button
    }()
    
    internal lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(EyeVoteColor.textIconColor, for: .normal)
        button.layer.borderColor = EyeVoteColor.textIconColor.cgColor
        button.layer.borderWidth = 0.8
        return button
    }()
}
