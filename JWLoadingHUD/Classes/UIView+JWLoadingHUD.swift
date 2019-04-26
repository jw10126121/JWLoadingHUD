//
//  UIView+JWLoadingHUD.swift
//  JWLoadingHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit
import MBProgressHUD
import ObjectiveC

public extension UIView {
    
    /// 显示Toast
    func showHUD(style: JWHUDStyle = JWHUDManager.shared.defaultStyle,
                 mode: JWHUDMode,
                 animated: Bool = true,
                 hiddenDelay: TimeInterval = 0) {
        
        let hud = self.hud
        
        showMBHUD(hud,
                  style: style,
                  mode: mode,
                  animated: animated,
                  hiddenDelay: hiddenDelay)
        
    }
    

    
    @objc private func didChangeStatusBarOrientationNotificationHandle(notification: Notification?) {
        
        /// 当前状态栏方向
        let currentIO = UIApplication.shared.statusBarOrientation
//        let deviceIO = interfaceOrientation(from: UIDevice.current.orientation)
    
//        if deviceIO == .portrait {
            UIView.animate(withDuration: 0.3) {
                self.hud.bezelView.transform = transformRotationAngle(from: currentIO, deviceOrientation: UIDevice.current.orientation)
            }
//        }

    }
    
    func dismissHUD(animated: Bool = true, afterDelay: TimeInterval = 0) {
        
        if self.hud.hudStyle.isFollowStatusBarOrientation {
            NotificationCenter.default.removeObserver(self, name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
        }

        dismissMBHUD(hud: self.hud, animated: animated, afterDelay: afterDelay)
        
    }
    
    private func dismissAllHUD(animated: Bool = true, afterDelay: TimeInterval = 0) {
        activeHUDs.compactMap { $0 as? JWMBProgressHUD }
            .forEach { dismissMBHUD(hud: $0, animated: animated) }
    }
    
    private func showMBHUD(_ hud: JWMBProgressHUD,
                           style: JWHUDStyle = JWHUDManager.shared.defaultStyle,
                           mode: JWHUDMode,
                           animated: Bool = true,
                           hiddenDelay: TimeInterval = 0) {
        

        /// 配置动画
        hud.animationType = .zoom
        hud.isHidden = true
        /// 配置风格
        hud.setup(style: style)
        
        hud.mode = .customView
        /// 配置hud自定义视图
        let customV = customView(style: style)
        hud.customView = customV
        customV.mode = mode

        /// 添加视图
        if hud.superview != self { addSubview(hud) }
        bringSubviewToFront(hud)
        
        hud.hudStyle = style
        
        if style.isFollowStatusBarOrientation {
            NotificationCenter.default.addObserver(forName: UIApplication.didChangeStatusBarOrientationNotification,
                                                   object: nil,
                                                   queue: OperationQueue.main) { [weak self] notif in
                                                    guard let self = self else { return }
                                                    debugPrint("UIApplication.didChangeStatusBarOrientationNotification")
                                                    self.didChangeStatusBarOrientationNotificationHandle(notification: notif)
            }
        }
        
        hud.show(in: self, animated: animated, hiddenDelay: hiddenDelay)
//        didChangeStatusBarOrientationNotificationHandle(notification: nil)
        
    }
    
    
    private func dismissMBHUD(hud: UIView?, animated: Bool = true, afterDelay: TimeInterval = 0) {
        if let hud = hud as? JWMBProgressHUD {
            hud.dismiss(animated: animated, afterDelay: afterDelay)
        }
    }
    
    
    /// 通过配置，生成自定义视图
    private func customView(style: JWHUDStyle) -> JWLoadingCustomView {
        let view = JWLoadingCustomView()
        view.titleLabel.font = style.textFont
        view.contentMargin = style.contentSpacing
        view.titleLabel.textColor = style.textColor
        view.titleLabel.numberOfLines = style.textLine
        return view
    }
    
    
}


extension UIView {
    
    /// runtime keys
    private struct UIViewHUDKeys {
        static var activeHUDs = "com.jw.app.loadingHUD.activeHUDs"
        static var queueHUDs  = "com.jw.app.loadingHUD.queueHUDs"
        static var viewHud = "com.jw.app.loadingHUD.viewHud"
    }
    
    /// 当前活动的HUD
    private var activeHUDs: NSMutableArray {
        get {
            if let activeToasts = objc_getAssociatedObject(self, &UIViewHUDKeys.activeHUDs) as? NSMutableArray {
                return activeToasts
            } else {
                let activeToasts = NSMutableArray()
                objc_setAssociatedObject(self,
                                         &UIViewHUDKeys.activeHUDs,
                                         activeToasts,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activeToasts
            }
        }
    }
    
    /// 当前队列中的HUD
    private var queueHUDs: NSMutableArray {
        get {
            if let queue = objc_getAssociatedObject(self, &UIViewHUDKeys.queueHUDs) as? NSMutableArray {
                return queue
            } else {
                let queue = NSMutableArray()
                objc_setAssociatedObject(self,
                                         &UIViewHUDKeys.queueHUDs,
                                         queue,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return queue
            }
        }
    }
    
    /// HUD对象
    internal var hud: JWMBProgressHUD {
        
        set {
            objc_setAssociatedObject(self,
                                     &UIViewHUDKeys.viewHud,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            
            
            
            if let userHud = objc_getAssociatedObject(self, &UIViewHUDKeys.viewHud) as? JWMBProgressHUD {
                /// 用户设置的HUD
                return userHud
            }
//            else if let extedHud = JWMBProgressHUD(for: self) {
//                /// 已存在的HUD
//                return extedHud
//            }
            else {
                /// 生成一个新的HUD
                let aObject = JWMBProgressHUD(view: self)
                    .config { $0.setup(style: JWHUDManager.shared.defaultStyle) }
                objc_setAssociatedObject(self,
                                         &UIViewHUDKeys.viewHud,
                                         aObject,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return aObject
            }
        }
        
    }
    

    
}

