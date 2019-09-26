//
//  MapViewController+Ext.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

//MARK:-----------***CLLocationManagerDelegate***-----------//

extension MapViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {return}
        funcs.locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {return}
        funcs.current_Lat = "\(location.coordinate.latitude)"
        funcs.current_Long = "\(location.coordinate.longitude)"
        mapView.clear()
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 17.5, bearing: 0, viewingAngle: 0)
        
        funcs.locationManager.stopUpdatingLocation()
        
        funcs.callingAPI(funcs.current_Lat, funcs.current_Long, mapView, self, pinVerticalCenter_Constrain, location.coordinate)
       
    }
}

//MARK:-----------***GMSMapViewDelegate***-----------//

extension MapViewController: GMSMapViewDelegate {
    
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        mapView.clear()
        funcs.calledOnce = false
        funcs.slide_ChildView_Down(self, mapView)
    }
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
        funcs.callingAPI(funcs.current_Lat, funcs.current_Long, mapView, self, pinVerticalCenter_Constrain, position.target)
        
    }
    
    public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {}
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {}
}


//MARK:-----------***UIGestureRecognizerDelegate***-----------//

extension MapViewController: UIGestureRecognizerDelegate {}

//MARK:-----------***MapViewModelDelegate***-----------//

extension MapViewController: PickerMapViewModelDelegate {
    public func didCancelSelection() {}
    
    public func send_Selected_Text_MapView(_ address: String, _ coord: CLLocationCoordinate2D) {
        funcs.delegate?.send_Selected_Text_MapView(address, coord)
    }
    
    public func pan_gesture_Action(_ recognizer: UIPanGestureRecognizer) {
        funcs.gestureAction(recognizer, self)
    }
    
}

//MARK:-----------***NearByPlacesViewModelDelegate***-----------//

extension MapViewController: NearByPlacesViewModelDelegate {
    
    func send_Selected_Text(_ address: String, _ coord: CLLocationCoordinate2D) {
        delegate?.send_Selected_Text_MapView(address, coord)
    }
    
}

//MARK:-----------***GMSAutocompleteViewControllerDelegate***-----------//

extension MapViewController: GMSAutocompleteViewControllerDelegate {
    public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let placeAddress = place.formattedAddress ?? "-"
        GVars.ADDRESS = placeAddress
        GVars.FROM_AUTOCOMP = true
        let coord = place.coordinate
        self.dismiss(animated: true, completion: nil)
        funcs.current_Lat = "\(coord.latitude)"
        funcs.current_Long = "\(coord.longitude)"
        funcs.move_Map_To_Loc(coord, mapView)

    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {}
    
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
