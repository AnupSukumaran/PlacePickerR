//
//  MapViewController.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import GoogleMaps

public protocol MapViewControllerDelegate: class {
    func didCancelSelection()
    func send_Selected_Text_MapView(_ address: String, _ coord: CLLocationCoordinate2D)
}

public class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pinVerticalCenter_Constrain: NSLayoutConstraint!
    @IBOutlet weak var pinImg: UIImageView!
    
    public weak var delegate: MapViewControllerDelegate?
    public var funcs = PickerMapViewModel()
    
    let kMapStyle = "[" +
        "  {" +
        "    \"featureType\": \"poi.business\"," +
        "    \"elementType\": \"labels.icon\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"on\"" +
        "      }" +
        "    ]" +
        "  }," +
    "]"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
       
        funcs.delegate = self
        mapView.settings.rotateGestures = false
        funcs.set_Delegates(self, mapView)
    }
    
    @IBAction func viewListView(_ sender: UIBarButtonItem) {
        funcs.autoCompView(self)
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        delegate?.didCancelSelection()
        dismiss(animated: true, completion: nil)
        
    }
    

    fileprivate func customizeMapView() {
        do {
            mapView.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
   
}
