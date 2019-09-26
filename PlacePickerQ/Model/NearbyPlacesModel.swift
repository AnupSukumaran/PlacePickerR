//
//  NearbyPlacesModel.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit

class NearbyPlacesModel: NSObject {

    let geometry: JSON?
    let name: String?
    let vicinity:String?
    let icon: String?
    
    init?(json: JSON) {
        geometry = json[Const.Keys.geometry] as? JSON
        name = json[Const.Keys.name] as? String
        vicinity = json[Const.Keys.vicinity] as? String
        icon = json[Const.Keys.icon] as? String
    }
}
