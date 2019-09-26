//
//  LocModel.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit

class LocModel: NSObject {

    let lat: Double?
    let lng: Double?
    
    init?(json: JSON) {
       
        lat = json[Const.Keys.lat] as? Double
        lng = json[Const.Keys.lng] as? Double

    }
}
