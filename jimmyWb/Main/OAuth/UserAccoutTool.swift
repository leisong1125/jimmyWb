//
//  UserAccoutTool.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/18.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class UserAccoutTool {
    
    //MARK:- # 将类设计成单利
    static let shareTool : UserAccoutTool = UserAccoutTool()
    
    
    var accout : UserAccount?
    
    //MARK:- # 计算属性
    var accoutPath : String {
        var accoutPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accoutPath = accoutPath + "/accout.plist"
        
        return accoutPath
    }
    
    
    //MARK:- # 重写 init 
     init() {
        // 解挡
        accout = NSKeyedUnarchiver.unarchiveObject(withFile: accoutPath) as? UserAccount
    }
    
    
    func islogin() -> Bool {
        if accout == nil {
            return false
        }
        
        guard let expires_date = accout?.expires_date else {
            return false
        }
        return expires_date.compare(Date()) == ComparisonResult.orderedDescending // 升序
        
    }
    

}
