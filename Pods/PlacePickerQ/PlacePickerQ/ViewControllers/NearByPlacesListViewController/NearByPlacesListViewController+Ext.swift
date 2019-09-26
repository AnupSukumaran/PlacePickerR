//
//  NearByPlacesListViewController+Ext.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

extension NearByPlacesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funcs.nearbyPlacesModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearbyPlacesTableViewCell", for: indexPath) as! NearbyPlacesTableViewCell
        cell.configCell(funcs.nearbyPlacesModels[indexPath.row])
        
        return cell
    }
    
}

extension NearByPlacesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name =  funcs.nearbyPlacesModels[indexPath.row].name ?? "-"
        let address = funcs.nearbyPlacesModels[indexPath.row].vicinity ?? "-"
        
        guard let geometry = funcs.nearbyPlacesModels[indexPath.row].geometry,let loc = geometry[Const.Keys.location] as? JSON, let lat = loc[Const.Keys.lat] as? CLLocationDegrees,let lng = loc[Const.Keys.lng] as? CLLocationDegrees else {Logger.pnt("geometry😓");return}
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        funcs.dismissAnd_SendAddress(self, name + ", " + address, coord)
    }
}



