//
//  ProfileViewController.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/7/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let reuseableCellIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewHierarchy()
        configureConstraints()
    }
    
    //MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseableCellIdentifier, for: indexPath) as! ProfileTableViewCell
        
        let image = #imageLiteral(resourceName: "user_icon")
        cell.pictureUploaded.image = image
        cell.pictureUploaded.layer.cornerRadius = image.size.width/2
        print(image.size.width/2)
        cell.voteDescriptionLabel.text = "You voted picture up."
        cell.timeStamp.text = "03:14PM"
        
        return cell
    }
    
    //MARK: Collection View
    
    private let reuseId = "cellID"
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! UploadCollectionViewCell
        
        cell.uploadImage.image = #imageLiteral(resourceName: "user_icon")
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        return CGSize(width: 20, height: 20) //placeholder values
//    }
    
    //MARK: LOG OUT BUTTON
    func logOutButton() {
        
    }
    
    func setupViewHierarchy() {
        self.view.addSubview(profileImage)
        self.view.addSubview(votesTableView)
        self.view.addSubview(uploadCollectionView)
        self.view.addSubview(yourUploadLabel)
    }
    

    private func configureConstraints() {
        self.edgesForExtendedLayout = []
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .plain, target: self, action: #selector(logOutButton))
        
        //Profile Picture
        profileImage.snp.makeConstraints({ (view) in
            view.top.width.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.3)
        })
        
        //Votes Table View
        votesTableView.snp.makeConstraints({ (view) in
            view.top.equalTo(profileImage.snp.bottom)
            view.width.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.5)
        })
        votesTableView.delegate = self
        votesTableView.dataSource = self
        votesTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: reuseableCellIdentifier)
        
        
        //Upload Picture Collection View
        uploadCollectionView.snp.makeConstraints({ (view) in
            view.top.equalTo(votesTableView.snp.bottom)
            view.width.equalToSuperview()
            view.bottom.equalTo(yourUploadLabel.snp.top)
        })
        uploadCollectionView.delegate = self
        uploadCollectionView.dataSource = self
        uploadCollectionView.register(UploadCollectionViewCell.self, forCellWithReuseIdentifier: reuseId)
        
        //Your Upload Label
        yourUploadLabel.snp.makeConstraints({ (view) in
            view.width.equalToSuperview()
            view.height.equalTo(20)
            view.top.equalTo(uploadCollectionView.snp.bottom)
            view.bottom.equalToSuperview()
        })
    }
    
    internal lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user_icon")
        return imageView
    }()
    
    internal lazy var votesTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.black
        return tableview
    }()
    
    internal lazy var uploadCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.backgroundColor = UIColor.darkGray
        return cv
    }()
    
    internal lazy var yourUploadLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = EyeVoteColor.darkPrimaryColor
        label.text = "YOUR UPLOADS"
        return label
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
