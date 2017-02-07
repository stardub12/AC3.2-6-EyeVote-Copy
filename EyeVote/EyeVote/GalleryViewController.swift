//
//  ViewController.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/6/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        var categoryTableView = UITableView()
        categoryTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.rowHeight = 200
        categoryTableView.register(GalleryTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(categoryTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GalleryTableViewCell
        
        cell.categoryLabel.text = "TEST"
        cell.categoryLabel.textAlignment = .center
        
        return cell
    }

}

