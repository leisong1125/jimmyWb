//
//  BaseViewController.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/12.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    var isLogin : Bool = UserAccoutTool.shareTool.islogin()
    
    
    override func loadView() {

        isLogin ? super.loadView() : setUpNaivItem ()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNaivItem()
    }
}

//MARK:- # 设置 UI 视图
extension BaseViewController {
     // 访客视图
     func setUpVisitorView() {
        view = visitorView
        
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginBtnClick), for: .touchUpInside)
        
    }
    
    // 设置导航栏 左右 Item
    func setUpNaivItem() {
        
        let isLogin = UserAccoutTool.shareTool.islogin()
        
        if !isLogin {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(BaseViewController.registerBtnClick))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(BaseViewController.loginBtnClick))
        }

    }
    
}

//MARK:- # 事件监听
extension BaseViewController {
    
    func registerBtnClick() {
        
    }
    
    func loginBtnClick() {
        
        let Oauth = OAuthVC()
        
        let OAuthNav = UINavigationController.init(rootViewController: Oauth)
        
        present(OAuthNav, animated: true, completion: nil)
        
    }
    
}





