//
//  WelComeVC.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/18.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit
import SDWebImage

class WelComeVC: UIViewController {

    //MARK:- # 脱线属性
    @IBOutlet weak var iconViewBottom: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    //MARK:- # 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iconUrl = UserAccoutTool.shareTool.accout?.avatar_large
        
        let userNameStr = UserAccoutTool.shareTool.accout?.screen_name ?? ""
        
        userName.text = userNameStr + "，欢迎回来！"
        
        
        // ?? : 如果？？前面的可选类型有值，解包并复制， 如果？？前面的可选类型没有值，直接使用？？后面的值
        let url = URL(string: iconUrl ?? "")
        // 设置头像
        iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default"))
        
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.backgroundColor = UIColor.black.cgColor
        
        
        // 改变约束值
        iconViewBottom.constant = UIScreen.main.bounds.height - 200

        // 执行动画
        // delay 延迟执行
        // usingSpringWithDamping : 阻力系数， 值越大 弹动效果越不明显 0~1
        // initialSpringVelocity  : 初始化速度
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {() -> Void in
            
        self.view.layoutIfNeeded()
            
        }, completion: {(_) -> Void in
        
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            
        })
        
    }

}
