//
//  UploadViewController.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/6/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "up_arrow"), style: .plain, target: self, action: #selector(uploadButtonPressed))
    }
    
    func setupView() {
        self.edgesForExtendedLayout = []
        
        let container = UIView()
        view.addSubview(container)
        container.backgroundColor = EyeVoteColor.primaryColor
        container.snp.makeConstraints({ (view) in
            view.width.equalToSuperview()
            view.height.equalTo(75)
            view.top.equalToSuperview()
        })
        
        let titleTextField = UITextField()
        titleTextField.text = "TITLE"
        titleTextField.layer.borderColor = UIColor.black.cgColor
        titleTextField.layer.borderWidth = 5
        container.addSubview(titleTextField)
        titleTextField.snp.makeConstraints({ (view) in
            view.width.equalTo(container.snp.width).multipliedBy(0.8)
            view.height.equalTo(30)
            view.top.equalTo(container.snp.top).offset(5)
            view.centerX.equalTo(container.snp.centerX)
        })
        
//        let categoriesCollectionView = UICollectionView()
//        container.addSubview(categoriesCollectionView)
//        categoriesCollectionView.snp.makeConstraints({ (view) in
//            view.width.equalTo(container.snp.width)
//            view.top.equalTo(titleTextField.snp.bottom)
//            view.bottom.equalTo(container.snp.bottom)
//        })
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.brown
        view.addSubview(imageView)
        imageView.snp.makeConstraints({ (view) in
            view.width.equalToSuperview()
            view.height.equalTo(self.view.snp.width)
            view.top.equalTo(container.snp.bottom)
        })
        
//        let imageCollectionView = UICollectionView()
//        view.addSubview(imageCollectionView)
//        imageCollectionView.snp.makeConstraints({ (view) in
//            view.width.equalToSuperview()
//            view.top.equalTo(imageView.snp.bottom)
//            view.bottom.equalToSuperview()
//        })
        
    }
    
    func uploadButtonPressed() {
        
    }

}
