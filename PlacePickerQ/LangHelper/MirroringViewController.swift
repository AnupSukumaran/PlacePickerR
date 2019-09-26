//
//  MirroringViewController.swift
//  tesing ms
//
//  Created by Moath_Othman on 1/27/16.
//  Copyright © 2016 Moath_Othman. All rights reserved.
//

import UIKit
//import XLPagerTabStrip



extension UIViewController {
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        
        if subviews.count > 0 {
            
            for subView in subviews {
                
                if (subView is UIImageView) && subView.tag < 0 {
                    
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                        
                    }
                }
                
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }
}


extension UITableViewCell {
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        
        if subviews.count > 0 {
            
            for subView in subviews {
                
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    
                    if let _img = toRightArrow.image {
                        
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                    }
                }
                
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }
    
    func loopImagesToNormal(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.downMirrored)
                    }
                }
                
                loopImagesToNormal(subviews: subView.subviews)
            }
        }
    }
}



class MirroringViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if L102Language.currentAppleLanguage() == "ar" {
            loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: self.view.subviews)
        }
    }
}

class MirroringTableCell: UITableViewCell {
    
    //MARK:
    func mirrorImages() {
        if GVars.isArabic {
            loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: contentView.subviews)
        } else {
            loopImagesToNormal(subviews: contentView.subviews)
        }
    }
    
}
