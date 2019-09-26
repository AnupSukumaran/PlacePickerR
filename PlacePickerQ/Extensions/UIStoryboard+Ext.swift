//
//  UIStoryboard+Ext.swift
//  SlideOutNavigation
//
//  Created by Qaptive Technologies on 02/05/19.
//  Copyright © 2019 James Frost. All rights reserved.
//

import UIKit

extension UIStoryboard {
  
    
    //MARK:-----------***For Picker Storyboard***-----------//
    //MARK: @@@PlacePicker
   public static func pickerStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "PlacePicker", bundle: Bundle.main)
    }

   static func nearByPlacesListViewController() -> NearByPlacesListViewController? {
        return pickerStoryboard().instantiateViewController(withIdentifier: "NearByPlacesListViewController") as? NearByPlacesListViewController
    }

   public static func mapViewController() -> MapViewController? {
        return pickerStoryboard().instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
    }
    
    
}
