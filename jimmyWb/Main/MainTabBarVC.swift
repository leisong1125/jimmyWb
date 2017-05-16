//
//  MainTabBarVC.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/10.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    // 弹出视图
    lazy var menu : HyPopMenuView = HyPopMenuView.sharedPopMenuManager()
    
    let model1  = PopMenuModel.allocPopMenuModel(withImageNameString: "tabbar_compose_idea", atTitleString: "文字/头条", atTextColor: UIColor.gray, at: PopMenuTransitionTypeCustomizeApi, atTransitionRenderingColor: nil)
    let model2  = PopMenuModel.allocPopMenuModel(withImageNameString: "tabbar_compose_photo", atTitleString: "相册/视频", atTextColor: UIColor.gray, at: PopMenuTransitionTypeCustomizeApi, atTransitionRenderingColor: nil)
    let model3  = PopMenuModel.allocPopMenuModel(withImageNameString: "tabbar_compose_camera", atTitleString: "拍摄/短视频", atTextColor: UIColor.gray, at: PopMenuTransitionTypeCustomizeApi, atTransitionRenderingColor: nil)
    let model4  = PopMenuModel.allocPopMenuModel(withImageNameString: "tabbar_compose_lbs", atTitleString: "签到", atTextColor: UIColor.gray, at: PopMenuTransitionTypeCustomizeApi, atTransitionRenderingColor: nil)
    let model5  = PopMenuModel.allocPopMenuModel(withImageNameString: "tabbar_compose_review", atTitleString: "点评", atTextColor: UIColor.gray, at: PopMenuTransitionTypeCustomizeApi, atTransitionRenderingColor: nil)
    let model16  = PopMenuModel.allocPopMenuModel(withImageNameString: "tabbar_compose_more", atTitleString: "更多", atTextColor: UIColor.gray, at: PopMenuTransitionTypeCustomizeApi, atTransitionRenderingColor: nil)
    
    
    
    // 弹出视图
    
    
    
     lazy var imageNames = ["tabbar_home", "tabbar_message_center", "","tabbar_discover", "tabbar_profile"]
    
    // 自定义 类方法
    lazy var composeBtn : UIButton = UIButton.createButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    // 遍历构造函数
//    lazy var composeBtn : UIButton = UIButton(imageName: "", bgImageName: "")
    
    // 一般写法
//    lazy var composeBtn : UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBarUI()
        
        setPopViewUI()
        
    }
    
    // 不在 viewWillAppear 调整时 每次 viewWillAppear 都会给还原
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTabBarItem()

    }
    
}


extension MainTabBarVC : HyPopMenuViewDelegate{
    
    
    func setPopViewUI() {
        
        menu.dataSource = [ model1, model2, model3, model4, model5, model16]
        
        menu.delegate = self
        
        menu.automaticIdentificationColor = false
        menu.animationType  = HyPopMenuViewAnimationType.viscous
        
        let topView : popMenvTopView = popMenvTopView.init(frame: CGRectMake(0, 44, self.view.frame.size.width, 92))
        menu.topView = topView
        
    }
    
    
    func popMenuView(_ popMenuView: HyPopMenuView!, didSelectItemAt index: UInt) {
        
    }
    
    
}




//MARK:- #  UI 添加 compose
extension MainTabBarVC {
    
    func setUpTabBarUI() {
        tabBar.addSubview(composeBtn)
        // selector 两种写法
        // 一： Selector("addClick")   二： "addClick"
        // swift 3.0 行不通 会有警告
        
        composeBtn.addTarget(self, action: #selector(MainTabBarVC.addClick), for: .touchUpInside)
        
        
        composeBtn.center.x = tabBar.center.x
        composeBtn.center.y = tabBar.bounds.size.height*0.5
    }
    
    func setTabBarItem ()
    {  // 在 storyboard 中也可以设置 可以不写
        for i in 0..<tabBar.items!.count {
            let item = tabBar.items![i]
            
            if i == 2 {
                item.isEnabled = false
                continue
            }
            item.selectedImage = UIImage(named: imageNames[i] + "_selected")
        }
    }
    
}

//MARK:- # compose 的点击事件
extension MainTabBarVC {
    
    func addClick() {
        
        print("++++")
        
        menu.backgroundType = HyPopMenuViewBackgroundTypeLightBlur
        menu.openMenu()
    }
    
}



//MARK:- # 纯代码创建 TabBar
extension MainTabBarVC {
    
    /*
     // 获取json路径
     guard let jsonPath = Bundle.main.path(forResource: "TabBarResouce", ofType: "json") else {
     
     return
     }
     print("1")
     // 读取json文件 转成 data
     guard let jsonData = NSData.init(contentsOfFile: jsonPath)  else {
     return
     }
     print("2")
     // 将Data转成数组
     // 一个方法后面有 throws 说明这个方法会抛出异常
     // swift 提供了三种处理异常的方式
     /*
     方式一： try
     手动处理异常
     do {
     try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
     } catch  {
     print(error)
     }
     
     方式二： try? （常用方式）
     系统帮我们处理异常，有异常返回nil，没有异常返回对象
     
     方式三： try!
     告诉系统该方法没有异常 ，一旦方法出现异常，程序就会崩溃
     
     
     */
     
     guard let anyObject  = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
     return
     }
     print("3")
     guard let dictAry = anyObject as? [[String : Any]] else {
     return
     }
     print("4")
     for dict in dictAry {
     
     guard let vcName = dict["vcName"] as? String else {
     continue
     }
     guard let title = dict["title"] as? String else {
     continue
     }
     guard let imageName = dict["imageName"] as? String else {
     continue
     }
     
     addChildViewController(childName: vcName, titleStr: title, image: imageName)
     
     }
     
     
     //        addChildViewController(childName: "HomeTabVC", titleStr: "首页", image: "tabbar_home")
     //        addChildViewController(childName: "NewsTableVC", titleStr: "消息", image: "tabbar_message_center")
     //        addChildViewController(childName: "FoundTableVC", titleStr: "发现", image: "tabbar_discover")
     //        addChildViewController(childName: "MineVC", titleStr: "我的", image: "tabbar_profile")
     
     }
     
     // swift 支持方法重载
     // 方法重载： 方法名相同， 参数不同（参数的类型不同或者参数的个数不同
     // private 私有方法
     private func addChildViewController(childName : String, titleStr : String, image: String)
     {
     // 获取命名空间
     guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
     // 因为用文件名 创建对应的 Class时 其实文件名之前是有一个 命名空间的， 加上命名空间才能创建对应的class
     return
     }
     // 根据字符串 创建对应的 Class
     guard let childClass = NSClassFromString(nameSpace + "." + childName) else {
     // 拼接之后 获取对应的 Class
     return;
     }
     // 将对应的Any 转成对应的控制器的类型
     guard let childVcType = childClass as? UIViewController.Type else {
     
     return
     }
     // 创建对应的控制器对象
     let childVC = childVcType.init()
     
     childVC.title = titleStr
     childVC.tabBarItem.image = UIImage(named: image)
     childVC.tabBarItem.selectedImage = UIImage(named: image + "_selected")
     
     let childNav = UINavigationController(rootViewController: childVC)
     
     addChildViewController(childNav)
     */
    
}

