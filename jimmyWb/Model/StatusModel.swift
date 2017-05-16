//
//  StatusModel.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/19.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class StatusModel: NSObject {

    //MARK:- # 属性
    var created_at : String? {      // 创建时间
        didSet {
            guard let created_at = created_at, created_at != "" else {
                return
            }
           createAtText = NSDate.creatDateStr(creatAt: created_at)
        }
    
    }
    var source : String? {         // 微博来源
        didSet {
            guard let source = source, source != "" else {
                return
            }
            // <a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>
            // 获取字符串的起始位置和长度
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
    }
    var text : String?             // 正文
    var id : Int = 0               // 微博ID
    
    
    //MARK:- # 对数据处理后的展示数据
    var sourceText : String?
    var createAtText : String?
    
    
    
    
    //MARK:- # 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
