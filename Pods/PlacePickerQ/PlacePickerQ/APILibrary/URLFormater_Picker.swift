//
//  URLFormater.swift
//  Loqqat
//
//  Created by Sukumar Anup Sukumaran on 20/03/19.
//  Copyright © 2019 Qaptive_Technologies. All rights reserved.
//

import Foundation

class URLFormater_Picker {
    
    static let shared = URLFormater_Picker()
    private init() {}
    
    // create a URL from parameters
    func returnUrl(_ parameters: JSON, withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Const.ApiBase.APIScheme
        components.host = Const.ApiBase.APIHost
        components.path = Const.ApiBase.APIPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        guard let url = components.url else {fatalError("URL Not valid")}
        return url
    }
    
}

