//
//  APILibrary+.swift
//  Loqqat
//
//  Created by Sukumar Anup Sukumaran on 20/03/19.
//  Copyright © 2019 Qaptive_Technologies. All rights reserved.
//

import Foundation
import Alamofire

final class APILibrary {
    
    static let shared = APILibrary()
    private init(){}
    
    //MARK:
    func status_Code_Checker(_ response: DataResponse<Any>, completion: @escaping ResultCompBlk) {
        
        guard let statusCode = response.response?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            
            completion(.Error("Something went wrong!!.Please try again."))
            return
        }
    }
    
    //MARK: API-2 - GET - COUNTRY LIST API
    func get_Nearby_Places_API(loc: String, radius: String, googleApiKey: String, completion: @escaping ResultCompBlk) {
        
        let params = [Const.Keys.location: loc, Const.Keys.radius: radius, Const.Keys.key: googleApiKey] as JSON
        let urlLink = URLFormater_Picker.shared.returnUrl(params, withPathExtension: Const.PathExt.place_nearbysearch_json)
        
        Logger.pnt("*** urlLink - \(urlLink)😁")
        
        let request = Req.shared.makeGetRequest(url: urlLink)
        
        Alamofire.request(request).validate().responseJSON { (response) in
            
            self.status_Code_Checker(response, completion: completion)
            
            switch response.result {
            case .success(let data):
                
                guard let jsonData = data as? JSON else {Logger.pnt("Login😓");return}
                Logger.pnt("jsonData = \(jsonData)😁")
                
                completion(.Success(ModelClassResponse(json: jsonData)))
                
            case .failure(let error):
                completion(.Error(error.localizedDescription))
                
            }
        }
        
    }
    
}
