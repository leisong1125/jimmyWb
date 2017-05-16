
//
//  NSDate-Extension.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/19.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func creatDateStr(creatAt : String) -> String {
        
        // Mon Dec 19 19:26:33 +0800 2016
        // 1. 创建时间格式化对象
        let fm = DateFormatter()
        fm.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        
        
        //2. 将字符串时间转换成Date
        guard let creatDate = fm.date(from: creatAt) else {
            return ""
        }
        
        // 3. 创建当前时间
        let nowDate = Date()
        
        // 4.计算创建时间和当前时间的时间差
        let intervar = Int(nowDate.timeIntervalSince(creatDate))
        
        
        // 5. 对时间间隔处理
        if intervar < 60 {
            return "刚刚"
        }
        
        if intervar < 60*60 {
            return "\(intervar/60)分钟前"
        }
        
        if intervar < 60*60*24 {
            return "\(intervar/(60*60))小时前"
        }
        
        //创建日历对象
        let calendar = Calendar.current

        if calendar.isDateInYesterday(creatDate) {
            fm.date(from: "昨天 HH:mm")
            let timeStr = fm.string(from: creatDate)
            return timeStr
        }
        
        let cmps  = (calendar as NSCalendar).components(.year, from: creatDate, to: nowDate, options: [])
        if cmps.year! < 1 {
            fm.date(from: "MM-dd HH:mm")
            let timeStr = fm.string(from: creatDate)
            return timeStr
        }
        
        fm.date(from: "yyyy-MM-dd HH:mm")
        
        return fm.string(from: creatDate)
    }
    
}
