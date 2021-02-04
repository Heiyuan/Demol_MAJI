//
//  DYApiTool.swift
//  demol
//
//  Created by Dayuan on 2021/2/3.
//

import UIKit
import Alamofire
import SwiftyJSON

class DYApiTool: NSObject {
    class func request(_ url: String, method: HTTPMethod = .get,complete: @escaping (_ data: JSON,_ statusCode:Int) -> Void, error: @escaping (_ data: JSON) -> Void) {
    
        let serverUrl = url.urlEncoded()
        
        AF.request(serverUrl, method: method, encoding: JSONEncoding.default).responseJSON { (response) in
           
            let code = response.response!.statusCode;
            
            if response.value == nil {
                complete(JSON(),code)
                return;
            }
            switch response.result {
            case .success:
                let json = JSON(response.value!)
                complete(json, code)

            case .failure(_):
                error(JSON())
            }
        }
    }

}
