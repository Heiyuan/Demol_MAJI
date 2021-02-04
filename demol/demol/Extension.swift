//
//  Extension.swift
//  demol
//
//  Created by Dayuan on 2021/2/3.
//

import UIKit

extension String {
    //时间戳转化为日期
    func timeWithTimeInterval(Forment:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let fotmatter = DateFormatter.init()
        fotmatter.timeZone = TimeZone.init(identifier: "shanghai")
        fotmatter.dateFormat = Forment
        let date = Date.init(timeIntervalSince1970: Double(self)!)
        let dataStr = fotmatter.string(from: date)
        return dataStr;
        
    }
    static func getCurrentTimeStampWithS() -> String {
        let time = NSDate.init().timeIntervalSince1970;
        return "\(time)"
    }
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    /**
     + (NSString *)getCurrentTimeStampWithS
     {
         NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
         NSString *result = [NSString stringWithFormat:@"%ld",(long)time];
         return result;
     }
     */
}
