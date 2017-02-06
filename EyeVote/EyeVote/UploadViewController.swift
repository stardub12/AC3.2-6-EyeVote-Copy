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
    }
    
    func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let container = UIView()
        view.addSubview(container)
        container.backgroundColor = UIColor.brown
        container.snp.makeConstraints({ (view) in
            view.width.equalToSuperview()
            view.height.equalTo(50)
            view.top.equalToSuperview().offset(20)
        })
        
        
    }

}
