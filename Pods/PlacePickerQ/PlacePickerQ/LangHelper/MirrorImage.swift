//
//  MirrorImage.swift
//  Loqqat
//
//  Created by Qaptive Technologies on 17/04/19.
//  Copyright © 2019 Qaptive_Technologies. All rights reserved.
//

import UIKit

class MirrorImage: NSObject {

    //MARK:
    static func flipUp(imageView: UIImageView, _ imgColor: UIColor) {
 
        if let image = imageView.image {
            
            imageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale , orientation: UIImage.Orientation.upMirrored)
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = imgColor
        }
 
    }
    
    //MARK:
  static func flipDown(imageView: UIImageView, _ imgColor: UIColor) {

        if let image = imageView.image {
            imageView.image = UIImage(cgImage: image.cgImage!, scale: image.scale , orientation: UIImage.Orientation.downMirrored)
            imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = imgColor
        }
    }
}
