 //
//  OAuthVC.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/17.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthVC: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavUI() // 设置导航视图
        
        // 加载登录页面
        loadWebView()
        
        
        
        
    }

}


//MARK:- # 设置 UI
extension OAuthVC {
    
    func setNavUI() {
        // 左侧
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeView))
        
        // 右侧
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "填充", style: .plain, target: self, action: #selector(fileItme))
        
        title = "登录页面"
    }
    
    // 加载网络页面
    func loadWebView() {
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_uri)"
        
        // 创建 url 报错 省略了 直接用
        
//        guard let url = NSURL(string: urlString) else {
//            return
//        }
//        
//        guard let requeset = NSURLRequest(url: url as! URL) else {
//            return
//        }
        
        
        webView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)
    }
    
}

//MARK:- # WebViewDelegate
extension OAuthVC: UIWebViewDelegate {
    // 网页开始加载
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    // 网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    // 网页加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    // 当准备执行某一个页面时 会执行这个方法
    // 返回值 ：true --> 继续加载页面  false --> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        
        let urlString =  url.absoluteString
        
        guard urlString.contains("code") else {
            return true
        }
        
        let code =  urlString.components(separatedBy: "code=").last!
        
        loadAccessToken(code: code)
        
        return true
    }
    
}


//MARK:- # 请求数据
extension OAuthVC {
    
    func loadAccessToken(code : String) {
        AFNetworkTools.shareInstance.loadAccessToken(code: code, finished: {(result : [String : AnyObject]?, error : NSError?) -> () in
            if error != nil {
                return
            }
            guard let dic = result else {
                return
            }
            
            let accout = UserAccount(dic: dic)
            print(accout)
            
            self.loadUserInfo(accout: accout)
        
        })
    }
    
    private func loadUserInfo(accout : UserAccount) {
        // 获取 Access_Token
        guard let accessToken = accout.access_token else {
            return
        }
        // 获取 uid
        guard let uid = accout.uid else {
            return
        }
        AFNetworkTools.shareInstance.loadUserInfo(access_token: accessToken, uid: uid, finished: {(result : [String : AnyObject]?, error : NSError?) -> () in
           
            if error != nil {
                return
            }
            
            guard let dic = result else {
                return
            }
        
            accout.screen_name = dic["screen_name"] as? String
            accout.avatar_large = dic["avatar_large"] as? String
            
            // 保存数据
            // 1. 获取沙盒路径
            // 2. 保存对象
            NSKeyedArchiver.archiveRootObject(accout, toFile: UserAccoutTool.shareTool.accoutPath)
            
            // 把对象赋值给单利，因为单利在判断有没有登录的时候取到的沙盒路劲是空，所以在这里要赋值
            UserAccoutTool.shareTool.accout = accout
            
            // 显示 欢迎页面 先退出当前页面
            self.dismiss(animated: false, completion: {() -> Void in
              UIApplication.shared.keyWindow?.rootViewController = WelComeVC()
            
            })
            
        })
        
        
    }
    
    
    
}

//MARK:- # 请求用户信息
extension OAuthVC {
    
 }
 

//MARK:- # 事件监听
extension OAuthVC {
    // 关闭
    func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    // 填充
    func fileItme() {
        // 自动填充的话 要写 JS 代码 来改变 webView的内容
        
        // 1.书写 js 代码
        let jsCode = "document.getElementById('userId').value='15670522743';document.getElementById('passwd').value='l11254101125hsds';"
        

        //2. 执行 js 代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
        
        
    }
    
    
}



