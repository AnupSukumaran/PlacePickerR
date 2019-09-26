//
//  ModelClassResponse.swift
//  EV Quiz
//
//  Created by Abraham VG on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


class ModelClassResponse: NSObject {
    
    
    //MARK: @@@PlacePicker
    var nearbyPlacesModels = [NearbyPlacesModel]()
    var locModel = [LocModel]()
    
    init(json: JSON) {
        
        //MARK: @@@PlacePicker
        if let results = json[Const.Keys.results] as? [JSON] {
            let nearbyPlacesModels = results.map{NearbyPlacesModel.init(json: $0)}.compactMap{$0}
            self.nearbyPlacesModels = nearbyPlacesModels
            
            let geometries = self.nearbyPlacesModels.map{$0.geometry}.compactMap{$0}
            
            let locations = geometries.map{$0[Const.Keys.location] as? JSON}.compactMap{$0}
            
            let locsModel = locations.map{LocModel.init(json: $0)}.compactMap{$0}
            
            self.locModel = locsModel
            
        } else {Logger.pnt("nearbyPlacesModels😩")}
        
        
    }
    
}
