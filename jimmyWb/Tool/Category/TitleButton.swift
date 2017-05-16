//
//  TitleButton.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/13.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named : "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named : "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
    }
    
    // swift中规定 重写控件init（frame）或者 init（）必须重写 init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 5
        
    }
    
}
