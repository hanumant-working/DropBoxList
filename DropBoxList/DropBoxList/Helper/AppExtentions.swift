//
//  AppExtentions.swift
//  DropBoxList
//
//  Created by Hanumant S on 30/01/18.
//  Copyright © 2018 Hanumant S. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    // Load image from URL
    public func imageFromURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if error != nil {
                    // Set default placeholder image, after image fail to load from URL
                    self.image = UIImage(named: "placeholder")
                    print(error ?? "No Error")
                } else {
                    // Set image
                    let image = UIImage(data: data!)
                    self.image = image
                }
                
            })
        }).resume()
    }
}

