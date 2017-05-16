//
//  NewsTableVC.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/10.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class NewsTableVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setUpVistorViewInfo(iconName: "visitordiscover_image_message", title: "登录后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }
}
