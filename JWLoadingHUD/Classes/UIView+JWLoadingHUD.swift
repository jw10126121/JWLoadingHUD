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
        
        self.loadingHUDer.show(config: style, mode: mode, animated: animated, hiddenDelay: hiddenDelay)
        
        //        let hud = MBProgressHUD(view: self)
        //        showMBHUD(hud, config: config, mode: mode, animated: animated, hiddenDelay: hiddenDelay)
        
    }
    
    func dismissHUD(animated: Bool = true, afterDelay: TimeInterval = 0) {
        
        //        guard let activeHud = activeHUDs.firstObject as? MBProgressHUD else { return }
        //        dismissMBHUD(hud: activeHud, animated: animated, afterDelay: afterDelay)
        
        self.loadingHUDer.dismiss(animated: animated, afterDelay: afterDelay)
        
    }
    
    private func dismissAllHUD(animated: Bool = true, afterDelay: TimeInterval = 0) {
        activeHUDs.compactMap { $0 as? MBProgressHUD }
            .forEach { dismissMBHUD(hud: $0, animated: animated) }
    }
    
    private func showMBHUD(_ hud: MBProgressHUD,
                           style: JWHUDStyle = JWHUDManager.shared.defaultStyle,
                           mode: JWHUDMode,
                           animated: Bool = true,
                           hiddenDelay: TimeInterval = 0) {
        

        let customV = customView(style: style)
        hud.animationType = .zoom
        hud.isHidden = true
        hud.setup(style: style)
        
        hud.mode = .customView
        hud.customView = customV
        configHUDCustomView(customView: customV, mode: mode)
        
        addSubview(hud)
        bringSubviewToFront(hud)
        
        hud.show(in: self, animated: animated, hiddenDelay: hiddenDelay)
        
        
    }
    
    
    private func dismissMBHUD(hud: UIView?, animated: Bool = true, afterDelay: TimeInterval = 0) {
        if let hud = hud as? MBProgressHUD {
            hud.dismiss(animated: animated)
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
    
    /// 配置 JWLoadingCustomView
    private func configHUDCustomView(customView: JWLoadingCustomView, mode: JWHUDMode) {
        
        customView.mode = mode
    }
    
    
}


extension UIView {
    
    /// runtime keys
    private struct UIViewHUDKeys {
        static var activeHUDs = "com.jw.app.loadingHUD.activeHUDs"
        static var queueHUDs  = "com.jw.app.loadingHUD.queueHUDs"
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
    
}

