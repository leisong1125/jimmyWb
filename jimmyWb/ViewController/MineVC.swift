//
//  MineVC.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/12.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class MineVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setUpVistorViewInfo(iconName: "visitordiscover_image_profile", title: "登录后，你的微博、相册、个人资料都会显示在这里，展示给别人")
    }
}
