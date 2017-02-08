//
//  GalleryCollectionViewCell.swift
//  EyeVote
//
//  Created by Simone on 2/8/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect){
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
