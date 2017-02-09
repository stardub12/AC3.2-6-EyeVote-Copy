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

class LogInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = EyeVoteColor.primaryColor
        setupViewHierarchy()
        configureConstraints()
        gesturesAndControl()
    }
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.view.addSubview(logo)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(imageButton)
    }
    
    private func configureConstraints(){
        self.edgesForExtendedLayout = []
        
        // Logo
        logo.snp.makeConstraints({ (view) in
            view.centerX.equalTo(self.view)
            view.width.height.equalTo(150)
            view.top.equalToSuperview().offset(10)
        })
        
        //Logo Button
        imageButton.snp.makeConstraints { (view) in
            view.centerX.equalTo(logo)
            view.width.height.equalTo(logo)
        }
        
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
    func gesturesAndControl() {
        registerButton.addTarget(self, action: #selector(tappedRegisterButton(sender:)), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(tappedLoginButton(sender:)), for: .touchUpInside)
        
         imageButton.addTarget(self, action: #selector(handleImageButton), for: .touchUpInside)
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
            
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let profilePic = self.logo.image, let dataUpload = UIImageJPEGRepresentation(profilePic, 0.1) {
                
                storageRef.put(dataUpload, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    if let profilePath = metadata?.downloadURL()?.absoluteString {
                        let login = ["userName": userName, "password": password, "profilePath": profilePath]
                        userReference.updateChildValues(login, withCompletionBlock: { (error, reference) in
                            
                            guard let error = error else {
                                print("Error detected")
                                return
                            }
                            
                            
                            if let user = user {
                                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(ok)
                                self.present(alert, animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        })
    }
    
    
    
    internal func handleImageButton() {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var imagePicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            imagePicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            imagePicker = originalImage
        }
        
        if let selectedImage = imagePicker {
            logo.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - Lazy Init
    internal lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        return imageView
    }()
    
    internal lazy var imageButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor.clear
        return button
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
