//
//  UIBarButtonItem-Extension.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/13.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
     // 第一种
    /*
    convenience init(imageName : String) {
        self.init()
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.customView = btn
    }
 */
    
    // 第二种
    convenience init(imageName : String) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView : btn)
        
    }
    
    
    
}
