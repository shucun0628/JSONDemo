//
//  RestAPIManager.swift
//  JSON
//
//  Created by Gu on 2016/1/26.
//  Copyright © 2016年 ShuCunGu. All rights reserved.
//

import Foundation

// 泛形接口
typealias ServiceResponse = (JSON, NSError?) -> Void

class RestAPIManger: NSObject {
    static let sharedInstance = RestAPIManger()
    
    let baseURL: String = "http://api.randomuser.me"
    
    func getRandomUser(onCompletion: (JSON) -> Void) {
        makeHTTPGetRequest(baseURL) { (json, error) -> Void in
            onCompletion(json)
        }
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) -> Void {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let json: JSON = JSON(data!)
            onCompletion(json, error)
        }
        
        task.resume()
        
    }
}