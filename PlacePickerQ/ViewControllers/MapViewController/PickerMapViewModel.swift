//
//  PickerMapViewModel.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

public protocol PickerMapViewModelDelegate: class {
    func send_Selected_Text_MapView(_ address: String, _ coord: CLLocationCoordinate2D)
    func pan_gesture_Action(_ recognizer: UIPanGestureRecognizer)
}

public class PickerMapViewModel: NSObject {
    
    public weak var delegate: PickerMapViewModelDelegate?
   // public weak var mainView_Delegate: PickerMapViewModelDelegate?
    let locationManager = CLLocationManager()

    var nearbyPlacesModels = [NearbyPlacesModel]()
    var locsModel = [LocModel]()
    var coordsArray = [CLLocationCoordinate2D]()
    var current_Lat = ""
    var current_Long = ""
    var markers = [Picker_PlaceMarker]()
    var nearByPlacesListViewController: NearByPlacesListViewController?
    var calledOnce = false
    var gmsAutocompleteViewController: GMSAutocompleteViewController?
    var placesField: GMSPlaceField?
    
    var estimatedY_axis: CGFloat = 0.0
    var bottomPos: CGFloat = 0.0
    
    static  let forFourS: CGFloat = 250
    static let forEightAnd6: CGFloat = 300
    static  let forPlus: CGFloat = 350
    static let forXXsPlus: CGFloat = 400
    
    static  let forFourS_gap: CGFloat = 60
    static let forEightAnd6_gap: CGFloat = 60
    static  let forPlus_gap: CGFloat = 60
    static let forXXsPlus_gap: CGFloat = 90
    
    var gapValue: CGFloat = {
        let flao = UIViewController().adjustViewForIPhonesOnly2(fourAndS: forFourS_gap, fiveAndS: forFourS_gap, sixSevenEight: forEightAnd6_gap, forPlus: forPlus_gap, xAndxs: forXXsPlus_gap, xr: forXXsPlus_gap, xsMax: forXXsPlus_gap)
        
        return flao ?? 100
    }()
    
    var centerPanelExpandedOffset: CGFloat = {
       let flao = UIViewController().adjustViewForIPhonesOnly2(fourAndS: forFourS, fiveAndS: forFourS, sixSevenEight: forEightAnd6, forPlus: forPlus, xAndxs: forXXsPlus, xr: forXXsPlus, xsMax: forXXsPlus)
        
        return flao ?? 400
    }()
    
    //MARK:
    func set_Delegates(_ main: UIViewController, _ mapView: GMSMapView) {
        locationManager.delegate = main as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = main as? GMSMapViewDelegate

    }
    
    //MARK:
    func callNearby_places_list_View(_ main: UIViewController) {
        guard let vc = UIStoryboard.nearByPlacesListViewController() else {return}
        vc.funcs.nearbyPlacesModels = nearbyPlacesModels
        let nav = UINavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        main.present(nav, animated: true, completion: nil)
    }
    
    //MARK: API
    func callingAPI(_ current_Lat: String, _ current_Long: String, _ mapView: GMSMapView, _ main: UIViewController, _ pinVerticalCenter_Constrain: NSLayoutConstraint, _ coord: CLLocationCoordinate2D ) {
        let latAndLong = "\(current_Lat), \(current_Long)"
        
        APILibrary.shared.get_Nearby_Places_API(loc: latAndLong, radius: "500", googleApiKey: PlacePickerQ_API.key) { (response) in
            switch response {
            case .Success(let data):
                self.nearbyPlacesModels = data.nearbyPlacesModels
                self.locsModel = data.locModel
                self.set_markers_on_map(self.locsModel, mapView)
                guard !self.calledOnce else {return}
                self.calledOnce = true
                if self.nearbyPlacesModels.count > 0 {
                    self.addingCenterChildView(main, mapView, pinVerticalCenter_Constrain, coord)
                }
                
            case .Error(let error):
                Logger.pnt("error = \(error)😁")
            }
        }
    }
    
    
    //MARK:
    func set_markers_on_map(_ locsModel: [LocModel],_ mapView: GMSMapView) {
        coordsArray = locsModel.map{coord_Maker($0.lat ?? 0.0, $0.lng ?? 0.0)}
        Logger.pnt("%%% lat = \(coordsArray.map{$0.latitude})")
        
        _ = coordsArray.map{
            
            let marker = Picker_PlaceMarker(location: $0, markerImg: #imageLiteral(resourceName: "pin2"), mapView: mapView)
            markers.append(marker)
            marker.map = mapView
        }
        
       
    }
    
    //MARK:
    func coord_Maker(_ lat: CLLocationDegrees, _ lng: CLLocationDegrees) -> CLLocationCoordinate2D {
    
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    func reverseGeocodeCoordinate_V2(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            guard let address = response?.firstResult(), let lines = address.lines else {return}
            let dragged_Address = lines.joined(separator: "\n")
            self.nearByPlacesListViewController?.top_Address_LB.text = dragged_Address
        
        }
    }
    
    
    //MARK:
    func addingCenterChildView(_ main: UIViewController, _ mapView: GMSMapView, _ pinVerticalCenter_Constrain: NSLayoutConstraint, _ coord: CLLocationCoordinate2D) {
        
        if !GVars.FROM_AUTOCOMP {
            reverseGeocodeCoordinate_V2(coord)
        }
        
        nearByPlacesListViewController = UIStoryboard.nearByPlacesListViewController()
        guard let vc = nearByPlacesListViewController else {return}
        vc.funcs.nearbyPlacesModels = nearbyPlacesModels
        vc.funcs.coord = coord
        vc.funcs.delegate = main as? NearByPlacesViewModelDelegate
        main.view.addSubview(vc.view)
        main.addChild(vc)
        vc.didMove(toParent: main)
        vc.view.frame.origin.y = main.view.bounds.height
        
        animated_BottomList_Setter(vc, mapView)
        addPanGesture(main)
    }
    
    
    
    //MARK:
    func animated_BottomList_Setter(_ main: UIViewController, _ mapView: GMSMapView) {
        UIView.animate(withDuration: 0.5) {
            self.bottomPos = self.centerPanelExpandedOffset - 20
            self.estimatedY_axis = main.view.bounds.height - (self.bottomPos)
            main.view.frame.origin.y = self.estimatedY_axis
            mapView.padding = UIEdgeInsets(top: self.bottomPos  , left: 0,
                                           bottom: self.bottomPos  , right: 0)
            main.view.layoutIfNeeded()
        }
    }
    
    //MARK:
    func addPanGesture(_ main: UIViewController) {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
       guard let vc = nearByPlacesListViewController else {return}
        vc.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK:
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        delegate?.pan_gesture_Action(recognizer)
    }
    
    //MARK:
    func gestureAction(_ recognizer: UIPanGestureRecognizer, _ main: UIViewController) {
        
        switch recognizer.state {
        case .began:
            break
            
        case .changed:
            changed(recognizer, main)
            
        case .ended:
            ended(recognizer, main)
            
        default:
            break
            
        }
        
    }
    
    //MARK:
    func changed(_ recognizer: UIPanGestureRecognizer, _ main: UIViewController) {
        if let rview = recognizer.view {
            rview.center.y = rview.center.y + recognizer.translation(in: main.view).y
            recognizer.setTranslation(CGPoint.zero, in: main.view)
        }
    }
    
    //MARK:
    func ended(_ recognizer: UIPanGestureRecognizer, _ main: UIViewController) {
        if let rview = recognizer.view {
            
            let hasMovedHalfwayUp = rview.center.y < (main.view.bounds.size.height - centerPanelExpandedOffset + 300)
            
            guard let vc = nearByPlacesListViewController else {return}
            
            
            if hasMovedHalfwayUp {
                
                let targetPos:CGFloat = main.view.bounds.size.height - (main.view.bounds.size.height - gapValue)
                
                animateCenterPanelYPosition(targetPosition: targetPos, vc)
                
            } else {
                
                let targetPos = self.estimatedY_axis
                animateCenterPanelYPosition(targetPosition: targetPos, vc)
                
            }
            
        }
    }
    
    func animateCenterPanelYPosition(targetPosition: CGFloat, _ main: UIViewController, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            main.view.frame.origin.y = targetPosition
        }, completion: completion)
    }
    
    //MARK:
    func slide_ChildView_Down(_ main: UIViewController, _ mapView: GMSMapView) {
        UIView.animate(withDuration: 0.5) {
            guard let vc = self.nearByPlacesListViewController else {return}
            vc.view.frame.origin.y = main.view.bounds.height
            mapView.padding = UIEdgeInsets(top: 0, left: 0,bottom: 0, right: 0)
            main.view.layoutIfNeeded()
        }
    }
    
    //MARK:
    func autoCompView(_ main: UIViewController) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = main as? GMSAutocompleteViewControllerDelegate
        acController.modalPresentationStyle = .fullScreen
        main.present(acController, animated: true, completion: nil)
    }
    
    //MARK:
    func move_Map_To_Loc(_ coord: CLLocationCoordinate2D, _ mapView: GMSMapView) {
        
        let camera = GMSCameraUpdate.setTarget(coord)
        mapView.animate(with: camera)
    }
    
}
