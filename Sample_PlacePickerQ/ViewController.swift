//
//  ViewController.swift
//  Sample_PlacePickerQ
//
//  Created by Qaptive Technologies on 19/06/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import PlacePickerQ
import GoogleMaps

class ViewController: UIViewController {
    
    @IBOutlet weak var addressLable: UILabel!
    

    @IBAction func pickerAction(_ sender: Any) {
        pickerVC(self)
    }
    
    
    func pickerVC(_ main: UIViewController) {

        guard let vc = UIStoryboard.mapViewController() else {return}

        vc.funcs.delegate = main as? PickerMapViewModelDelegate
        let nav = UINavigationController.init(rootViewController: vc)
        nav.modalPresentationStyle  = .fullScreen
        main.present(nav, animated: true, completion: nil)
    }
    
}

extension ViewController: PickerMapViewModelDelegate {
    
    func didCancelSelection() {

    }

    func pan_gesture_Action(_ recognizer: UIPanGestureRecognizer) {

    }

    func send_Selected_Text_MapView(_ address: String, _ coord: CLLocationCoordinate2D) {
        addressLable.text = address
    }


}
