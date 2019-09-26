//
//  NearByPlacesListViewController.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit

class NearByPlacesListViewController: UIViewController {
    
    @IBOutlet weak var top_Address_LB: UILabel!
    @IBOutlet weak var locationList: UITableView!
    @IBOutlet weak var top_Address_btn: UIButton!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var selectThisAddress_Title: UILabel!
    
    var funcs = NearByPlacesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImg.image = #imageLiteral(resourceName: "iconDefault")
        iconView.layer.cornerRadius = 10
        if GVars.FROM_AUTOCOMP, let address = GVars.ADDRESS {
            top_Address_LB.text = address
            GVars.FROM_AUTOCOMP = false
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func top_Address_btn(_ sender: UIButton) {
        guard let coor = funcs.coord else {return}
        funcs.dismissAnd_SendAddress(self, top_Address_LB.text ?? "-", coor)
    }
    
}
