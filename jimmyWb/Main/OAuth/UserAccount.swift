//
//  UserAccount.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/17.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {

    var access_token : String?
    // 过期日期
    var expires_in : TimeInterval = 0.0 {
        didSet {
           expires_date = NSDate(timeIntervalSinceNow: expires_in) as Date
        }
    }
    var uid : String?
    
    var expires_date : Date? 
    
    // 昵称
    var screen_name : String?
    
    //头像
    var avatar_large : String?
    
    
    
    
    //MARK:- # 自定义构造函数
    init(dic : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "screen_name", "avatar_large"]).description
    }
    
    //MARK:- # 归档和解挡
    // 解挡
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    // 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        
    }
    
    
    
    
}
