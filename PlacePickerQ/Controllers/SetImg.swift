//
//  SetImg.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 04/06/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class SetImg: NSObject {
    
    //MARK:
    func fromUrl(_ iconImg: UIImageView,_ urlString: String,_ placeholderImage: UIImage?) {
        iconImg.sd_setImage(with: URL(string: urlString), placeholderImage: placeholderImage, options: .highPriority) { (img, error, cache, url) in
            //do some actions
        }
    }
    
}
