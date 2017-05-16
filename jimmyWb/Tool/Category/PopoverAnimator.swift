//
//  PopoverAnimator.swift
//  jimmyWb
//
//  Created by jimmy on 2016/12/14.
//  Copyright © 2016年 jimmy. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {

    var isPresent: Bool = false
    
    var presentedFrame : CGRect = CGRect.zero
    
    // 闭包 回传 给 HomeTabVC 改变 titleBtn Image 的状态 
    
    var callBlock : ((_ presentState : Bool) -> ())?
    
    //MARK:- # 自定义构造函数
    // 如果自定义了一个构造函数，但是没有对默认的init()重写，那么自定义的构造函数会覆盖默认的init()函数
    
//    override init() {
//        
//    }
    
    init(callBlock : @escaping (_ presentState : Bool) -> ()) {
       self.callBlock = callBlock
    }
    
}


//MARK:- # 转场动画代理
extension PopoverAnimator : UIViewControllerTransitioningDelegate{
    // 改变弹出视图的 Frame
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentation = JimmyUIPresentationController(presentedViewController: presented, presenting: presenting)
        presentation.presendFrame = presentedFrame
        
        return presentation
    }
    
    // 自定义 弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        callBlock!(isPresent)
        return self
    }
    
    // 自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        callBlock!(isPresent)
        return self
    }
    
}

//MARK:- # 弹出 消失 代理方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning{
    
    // 动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.4
    }
    
    // 获取转场 上下文 ，通过上下文 获取弹出View和消失view
    // UITransitionContextFromViewKey, 获取消失View
    // UITransitionContextToViewKey  获取弹出View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresent ? animationForPresentView(using: transitionContext) : animationForDisPresentView(using: transitionContext)
        
    }
    
    // 弹出
    private func animationForPresentView(using transitionContext: UIViewControllerContextTransitioning) {
        // 获取弹出View
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        
        // 将弹出的View添加到containerView
        transitionContext.containerView.addSubview(presentView)
        
        // 执行动画
        
        presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        presentView.layer.anchorPoint = CGPointMake(0.5, 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() -> Void in
            presentView.transform = CGAffineTransform.identity
        }) { (_) -> Void in
            
            // 必须告诉转场上下文已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    // 消失
    private func animationForDisPresentView(using transitionContext: UIViewControllerContextTransitioning) {
        // 获取消失View
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        // 执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() -> Void in
            dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
        }) { (_) -> Void in
            dismissView.removeFromSuperview()
            // 必须告诉转场上下文已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    
    
}

