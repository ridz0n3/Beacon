//
//  NetworkManager.swift
//  Beacon Demo
//
//  Created by ME-Tech Mac User 1 on 12/12/15.
//  Copyright © 2015 Me-tech. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {

    func sharedClient() -> NetworkManager{
        let shareClient = NetworkManager()
        return shareClient
    }
    
    func createRequest(serviceName:String, completion:(result:AnyObject) -> Void){
        
        Alamofire.request(.GET, serviceName, parameters: nil).responseJSON { (response) -> Void in
            completion(result: response.result.value!)
        }
    }
}
