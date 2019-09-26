//
//  NearbyPlacesTableViewCell.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class NearbyPlacesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeNameLB: UILabel!
    @IBOutlet weak var addressLB: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImg: UIImageView!
    
    
    func configCell(_ nearbyPlacesModel: NearbyPlacesModel) {
        placeNameLB.text = nearbyPlacesModel.name ?? "-"
        addressLB.text = nearbyPlacesModel.vicinity ?? "-"
        SetImg().fromUrl(iconImg, nearbyPlacesModel.icon ?? "-", nil)
        iconView.layer.cornerRadius = 10
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
