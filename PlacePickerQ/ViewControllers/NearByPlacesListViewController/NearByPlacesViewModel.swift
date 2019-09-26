//
//  NearByPlacesViewModel.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

protocol  NearByPlacesViewModelDelegate: class {
    func send_Selected_Text(_ address: String, _ coord: CLLocationCoordinate2D)
}

class NearByPlacesViewModel: NSObject {
    
    public weak var delegate: NearByPlacesViewModelDelegate?
    var nearbyPlacesModels = [NearbyPlacesModel]()
    var coord: CLLocationCoordinate2D?
    
    
    //MARK:
    func dismissAnd_SendAddress(_ main: UIViewController, _ address: String, _ coord: CLLocationCoordinate2D) {
        main.dismiss(animated: true, completion: nil)
        delegate?.send_Selected_Text(address, coord)
    }
}
