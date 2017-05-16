//
//  HomeTabVC.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/10.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class HomeTabVC: BaseViewController {

    // 在闭包中如果使用当前对象或调用方法，也需要加 self
    // 两个地方需要用self 1> 如果在一个函数中出现歧义 2>如果使用当前对象或调用方法
    // 注意防止循环引用
    lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[weak self] (presentState) in
        self?.titleBtn.isSelected = presentState
        
    }
    //MARK:- # 懒加载
    lazy var titleBtn : TitleButton = TitleButton()
    
    lazy var statusDataAry : [StatusModel] = [StatusModel]()
    
    
    //MARK:- # 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        setUpNaviViewItem()
        
        loadData()
    }

}

//MARK:- # 设置 UI
extension HomeTabVC {
    
    func setUpNaviViewItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("雷松", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        
        
        navigationItem.titleView = titleBtn
        
    }
    
    
  
    
}

//MARK:- # 事件监听
extension HomeTabVC {
    
    func titleBtnClick(titleBtn : TitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        let popoverVC = PopoverViewController()
        
        // 设置控制器的弹出样式 保证弹出后面的视图还存在
        popoverVC.modalPresentationStyle = .custom
        
        // 设置转场动画代理（改变 Frame 和 弹出样式）
        popoverVC.transitioningDelegate = popoverAnimator
        
        popoverAnimator.presentedFrame = CGRectMake(100, 55, 180, 250)
        
        present(popoverVC, animated: true, completion: nil) 
        
    }
}

//MARK:- # 请求数据
extension HomeTabVC {
    
    func loadData() {
        
        AFNetworkTools.shareInstance.loadStatuses(finished: {(result : [[String : AnyObject]]?, error : Error?) -> Void in
            if error != nil {
                print(error!)
                return
            }
            guard let dataAry = result else {
                return
            }
            
            for dataDic in dataAry {
               let status = StatusModel(dict: dataDic)
                
               self.statusDataAry.append(status)
            }
            self.tableView.reloadData() // 刷新
        })
        
    }
}


extension HomeTabVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusDataAry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell_ID", for: indexPath)
        
        let statusModel = statusDataAry[indexPath.row]
        
        cell.textLabel?.text = statusModel.text
        
        return cell
    }
    
    
    
}







