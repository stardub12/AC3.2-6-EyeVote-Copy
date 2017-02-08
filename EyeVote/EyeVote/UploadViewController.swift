//
//  UploadViewController.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/6/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var progressView: UIProgressView!
    var progressLabel: UILabel!
    
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
        
        self.view.addSubview(backgroundDimmer)
        backgroundDimmer.addSubview(progressContainer)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.center = self.progressContainer.center
        progressContainer.addSubview(progressView!)
        
        progressLabel = UILabel()
        let frame = CGRect(x: progressContainer.center.x, y: progressContainer.center.y, width: 100, height: 50)
        progressLabel.frame = frame
        progressView.addSubview(progressLabel!)

    }
    
    func updateProgress() {
        progressView?.progress += 0.05
        let progressValue = self.progressView?.progress
        progressLabel?.text = "\(progressValue! * 100) %"
    }
    
    //MARK: - UICollectionView
    
    private let reuseId = "cellID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        return CGSize(width: 1, height: 1) //placeholder values
    }
    
    //MARK:- Controls
    
    internal lazy var progressContainer: UIView = {
        let pc: UIView = UIView()
        pc.backgroundColor = EyeVoteColor.primaryColor
        return pc
    }()
    
    internal lazy var backgroundDimmer: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.2
        return view
    }()
    
    //add gestures to the progress container
    func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        
        progressContainer.addGestureRecognizer(tap)
        progressContainer.addGestureRecognizer(doubleTap)
        tap.require(toFail: doubleTap)
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .began {
            progressLabel.text = "Progress Paused"
            progressView.progressTintColor = UIColor.red
            
        }

    }
    
    func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .began {
             progressView.progress = 0
            progressLabel.text = "Upload Cancelled"
        }
    }
    
  }
