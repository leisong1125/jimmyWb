//
//  UIButton-Extension.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/12.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

extension UIButton {
    
    // swift 中 Class开头的方法 类似于OC 中的 + 号方法
    
    class func createButton(imageName : String, bgImageName : String) -> UIButton {
        
        let btn = UIButton()
        
        btn.setBackgroundImage(UIImage(named : bgImageName), for: .normal)
        btn.setBackgroundImage(UIImage(named : bgImageName + "_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        
        btn.sizeToFit() // 根据图片大小设置尺寸
        return btn
    }
    
    // 使用 convenience 构造的函数叫做 遍历构造函数 通常用在对系统的类进行构造函数的扩充时使用
    /**
     遍历构造函数的特点
     1. 遍历构造函数通常写在 extension
     2. init 前面需要加载 convenience
     3. 在遍历构造函数中需要明确调用 self.init()
     
     */
    
    convenience init(imageName : String, bgImageName : String) {
        self.init()
        
        setBackgroundImage(UIImage(named : bgImageName), for: .normal)
        setBackgroundImage(UIImage(named : bgImageName + "_highlighted"), for: .highlighted)
        setImage(UIImage(named : imageName), for: .normal)
        setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        
        sizeToFit() // 根据图片大小设置尺寸
        
    }
    
}

