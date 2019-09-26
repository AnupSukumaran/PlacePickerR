//
//  UIViewController+Ext.swift
//  CustomActivityCollections
//
//  Created by Qaptive Technologies on 11/04/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

var vSpinner : UIView?
var gActIndic: NVActivityIndicatorView?

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    //MARK:
    func customShowCustomActivity(_ main : UIView,_ type:  NVActivityIndicatorType,_ color: UIColor, _ showActi: Bool) {
        guard showActi else {return}
        let spinnerView = UIView.init(frame: main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        guard vSpinner == nil else {Logger.pnt("vSpinner😓");return}
        let actIndic = NVActivityIndicatorView(frame: spinnerView.frame, type: type, color: color, padding: self.view.frame.width/2.4)
        actIndic.startAnimating()
        gActIndic = actIndic
        DispatchQueue.main.async {
            spinnerView.addSubview(actIndic)
            main.addSubview(spinnerView)
        }
        vSpinner = spinnerView
        main.layoutIfNeeded()
    }
    
    
    //MARK:
    func widerCustomActivity(_ main : UIView,_ type:  NVActivityIndicatorType,_ color: UIColor, _ showActi: Bool) {
        guard showActi else {return}
        let spinnerView = UIView(frame: main.frame)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        guard vSpinner == nil else {Logger.pnt("vSpinner😓");return}
        let actIndic = NVActivityIndicatorView(frame: spinnerView.frame, type: type, color: color, padding: self.view.frame.width/2.4)
        actIndic.startAnimating()
        gActIndic = actIndic
        DispatchQueue.main.async {
            spinnerView.addSubview(actIndic)
            main.addSubview(spinnerView)
        }
        vSpinner = spinnerView
        
    }
    //MARK:
    func showCustomActivity(_ main : UIView,_ type:  NVActivityIndicatorType,_ color: UIColor) {
 
        let spinnerView = UIView.init(frame: main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        guard vSpinner == nil else {Logger.pnt("vSpinner😓");return}
        let actIndic = NVActivityIndicatorView(frame: spinnerView.frame, type: type, color: color, padding: self.view.frame.width/2.4)
        actIndic.startAnimating()
        gActIndic = actIndic
        DispatchQueue.main.async {
            spinnerView.addSubview(actIndic)
            main.addSubview(spinnerView)
        }
        vSpinner = spinnerView
        
    }
    
    //MARK:
    func showCustomActivity2(_ main : UIView,_ table: UIView,_ type:  NVActivityIndicatorType,_ color: UIColor) {

        let spinnerView = UIView.init(frame: main.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        guard vSpinner == nil else {Logger.pnt("vSpinner😓");return}
        let actIndic = NVActivityIndicatorView(frame: spinnerView.frame, type: type, color: color, padding: self.view.frame.width/2.4)
        actIndic.startAnimating()
        gActIndic = actIndic
        DispatchQueue.main.async {
            spinnerView.addSubview(actIndic)
            main.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
        
    }
    
    //MARK:
    func stopActivityIndic() {
        guard let vSpinView = vSpinner else {return}
        DispatchQueue.main.async {
            vSpinView.removeFromSuperview()
            vSpinner = nil
            guard let indic = gActIndic else {return}
            indic.stopAnimating()
        }
    }
    
    //MARK:
    func getDeviceType() {
        _ = UIScreen.main.traitCollection.userInterfaceIdiom
    }
    
    //MARK:
    func adjustView(pad: Int, phone: Int ) -> Int {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch (deviceIdiom) {
            
        case .pad:
            // self.sideMenuWidth = 500
            Logger.pnt("iPad style UI")
            return pad
            // self.sideMenuWidth = 400
            
        case .phone:
            // frame.size.width = self.sideMenuWidth
            Logger.pnt("iPhone and iPod touch style UI")
            return phone
            
        case .tv:
            //  frame.size.width = self.sideMenuWidth
            Logger.pnt("tvOS style UI")
            return 0
            
        default:
            // frame.size.width = self.sideMenuWidth
            Logger.pnt("Unspecified UI idiom")
            return 0
            
        }
    }
    
    
    //MARK: Adapt view for iPhone only
    func adjustViewForIPhonesOnly( fourAndS: Int, fiveAndS: Int, sixSevenEight: Int, forPlus: Int, xAndxs: Int, xr: Int, xsMax: Int ) -> Int {
        let screenType = UIDevice.current.screenType
        
        switch screenType {
        case .iPhones_4_4S:
            return fourAndS
            
        case .iPhones_5_5s_5c_SE:
            return fiveAndS
            
        case .iPhones_6_6s_7_8:
            return sixSevenEight
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            return forPlus
            
        case .iPhones_X_XS:
            return xAndxs
            
        case .iPhone_XR:
            return xr
            
        case .iPhone_XSMax:
            return xsMax
            
        default:
            return 0
        }
        
    }
    
    //MARK: Adapt view for iPhone only
    func adjustViewForIPhonesOnly2<T>( fourAndS: T, fiveAndS: T, sixSevenEight: T, forPlus: T, xAndxs: T, xr: T, xsMax: T ) -> T? {
        let screenType = UIDevice.current.screenType
        
        switch screenType {
        case .iPhones_4_4S:
            return fourAndS
            
        case .iPhones_5_5s_5c_SE:
            return fiveAndS
            
        case .iPhones_6_6s_7_8:
            return sixSevenEight
            
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            return forPlus
            
        case .iPhones_X_XS:
            return xAndxs
            
        case .iPhone_XR:
            return xr
            
        case .iPhone_XSMax:
            return xsMax
            
        default:
            return T.self as? T
        }
        
    }
    
    //MARK:
    func animate(_ dur: TimeInterval,_ comp: @escaping() -> ()) {
        UIView.animate(withDuration: dur, animations: {
            comp()
        })
    }
}
