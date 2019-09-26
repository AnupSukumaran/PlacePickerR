//
//  RequestMaker.swift
//  MyPlacePicker
//
//  Created by Qaptive Technologies on 30/05/19.
//  Copyright © 2019 Qaptive Technologies. All rights reserved.
//

import UIKit

class Req: NSObject {
    
    static let shared = Req()

    //MARK: Make Get Request
    func makeGetRequest(url: URL) -> URLRequest {
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        //sd
        return req
    }
}
