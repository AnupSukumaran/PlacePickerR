//
//  Const.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit

 class Const: NSObject {
    
    struct ApiBase {
       
        static let APIScheme = "https"
        
        static let APIHost = "maps.googleapis.com"

        static let APIPath = "/maps/api"

        
    }
    
    struct Keys {
        static let location = "location"
        static let radius = "radius"
        static let key = "key"
        static let results = "results"
        static let status = "status"
        static let geometry = "geometry"
        static let lat = "lat"
        static let lng = "lng"
        static let viewport = "viewport"
        static let northeast = "northeast"
        static let southwest = "southwest"
        static let icon = "icon"
        static let id = "id"
        static let name = "name"
        static let photos = "photos"
        static let place_id = "place_id"
        static let reference = "reference"
        static let scope = "scope"
        static let types = "types"
        static let user_ratings_total = "user_ratings_total"
        static let vicinity = "vicinity"
        //Language keys
        static let en = "en"
        static let ar = "ar"
    }
    
//    struct Val {
//        static var Map_APIKey = ""
//    }
//
    struct PathExt {
        static let place_nearbysearch_json = "/place/nearbysearch/json"
    }
}
