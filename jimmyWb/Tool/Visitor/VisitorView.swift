//
//  VisitorView.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/12.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView 
    }
    
    //MARK:- # 转盘 图标  文本
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    //MARK:- # 自定义函数
    func setUpVistorViewInfo(iconName : String, title : String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
    //MARK:- # 旋转动画
    func addRotationAnim() {
        
        let rorationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rorationAnim.fromValue = 0
        rorationAnim.toValue = 2 * M_PI
        rorationAnim.repeatCount = MAXFLOAT
        rorationAnim.duration = 5
        rorationAnim.isRemovedOnCompletion = false // 不被程序杀掉
        
       rotationView.layer.add(rorationAnim, forKey: nil)
        
//        rotationView.layer.speed
        
        
    }
    
}
