//
//  ImageView.swift
//  EyeVote
//
//  Created by Simone on 2/8/17.
//  Copyright © 2017 Edward Anchundia. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImagesWithCache(url: String) {
        self.image = nil
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = image
            return
        }
        let newURL = URL(string: url)!
        URLSession.shared.dataTask(with: newURL, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let imageToDownload = UIImage(data: data!) {
                    imageCache.setObject(imageToDownload, forKey: newURL as AnyObject)
                    self.image = imageToDownload
                }
            }
            
        }).resume()
    }
}
