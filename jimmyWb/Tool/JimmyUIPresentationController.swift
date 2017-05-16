//
//  JimmyUIPresentationController.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/14.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class JimmyUIPresentationController: UIPresentationController {

    //MARK:- # 对外提供属性 修改 Frame
    var presendFrame : CGRect = CGRect.zero
    
    
    lazy var coverView : UIView = UIView()
     // 重写方法 改变视图大小
    override func containerViewWillLayoutSubviews() {
       super.containerViewWillLayoutSubviews()
        
        // 改变 frame
        presentedView?.frame = presendFrame
        
        // 设置蒙版
        setUpCoverView()
    }
    
}


//MARK:- # UI
extension JimmyUIPresentationController {
    
    func setUpCoverView() {
        
        containerView?.insertSubview(coverView, at: 0)
        
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        // 添加手势
        
        let tap = UITapGestureRecognizer(target: self, action:#selector(viewDiss))
        
        coverView.addGestureRecognizer(tap)
        
        
    }
}


//MARK:- # 监听方法
extension JimmyUIPresentationController {
    
    func viewDiss() {
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    
}

