//
//  GVars.swift
//  Loqqat
//
//  Created by Sukumar Anup Sukumaran on 20/03/19.
//  Copyright © 2019 Qaptive_Technologies. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import NVActivityIndicatorView

class GVars {
    
    static var testBool = false
    static var HASINTERNET = false
    static var STUD_VIEW_SHOWED = false
    static var FCM_TOKEN = ""
    static var oldLoc: CLLocationCoordinate2D?
    static var oldBearing: CLLocationDegrees?
    static var NOTIFIC_STATUS: Int?
    static var STUD_ID: String?
    static var NOTIFIC_BODY = ""
    static var HALF_UP = false
    static var NOTIFIC_VIEWED = false
    static var NOTIFIC_COUNT = 0
    static var NOTIFIC_CAME = false
    static var calledOnce = false
    static var correctCount = 0
    static var indicType: NVActivityIndicatorType = .circleStrokeSpin
    static var VERSION_CODE = ""
    static var VERSION_NAME = ""
    static var MAJOR = ""
    static var MAP_VIEW_PASSED = false
    static var VERSION_CHECKED_ONCE = false
    static var index = 0
    static var parent_name = ""
    static var FROM_AUTOCOMP = false
    static var ADDRESS: String?
    
    static var isArabic: Bool {
        return L102Language.currentAppleLanguage() == Const.Keys.ar ? true : false
    }

    //MARK: Func to set Not Data View
    fileprivate static func toSetNotDataView(_ dataEmpty: Bool, _ view: UIView) {
        switch dataEmpty {
        case true:
            NoDataView.added(view)
            
        case false:
            NoDataView.remove(view)
        }
    }

    
}
