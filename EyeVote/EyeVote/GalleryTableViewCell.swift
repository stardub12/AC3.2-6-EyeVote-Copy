//
//  TableViewCell.swift
//  EyeVote
//
//  Created by Edward Anchundia on 2/6/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    var categoryLabel = UILabel()
    var categoryImage = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        categoryImage.backgroundColor = UIColor.gray
        
        self.contentView.addSubview(categoryImage)
        self.contentView.addSubview(categoryLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryImage.snp.makeConstraints { (view) in
            view.width.equalTo(contentView.snp.width)
            view.height.equalTo(contentView.snp.height)
            view.center.equalTo(contentView.center)
        }
        
        categoryLabel.snp.makeConstraints { (view) in
            view.width.equalTo(100)
            view.height.equalTo(50)
            view.center.equalTo(categoryImage.snp.center)
        }
    }

}
