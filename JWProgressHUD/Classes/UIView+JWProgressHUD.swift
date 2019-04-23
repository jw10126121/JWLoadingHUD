//
//  UIView+JWProgressHUD.swift
//  JWProgressHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit
import MBProgressHUD
import ObjectiveC

public extension UIView {
    
    /// 显示Toast
    func showHUD(config: JWHUDStyle = JWHUDStyle.defaultConfig,
                 mode: JWHUDMode,
                 animated: Bool = true,
                 hiddenDelay: TimeInterval = 0) {
        
        let customV = customView(config: config)
        let hud = MBProgressHUD(view: self)
        hud.isHidden = true
        hud.setup(config: config)
        addSubview(hud)
        bringSubviewToFront(hud)
        
        hud.mode = .customView
        hud.customView = customV
        configHUDCustomView(customView: customV, mode: mode)
        
        hud.show(in: self, animated: animated, hiddenDelay: hiddenDelay)
        
    }
    
    func dismissHUD(animated: Bool = true, afterDelay: TimeInterval = 0) {
        
    }
    
    /// 通过配置，生成自定义视图
    private func customView(config: JWHUDStyle) -> JWProgressHUDCustomView {
        let view = JWProgressHUDCustomView()
        view.titleLabel.font = config.textFont
        view.contentMargin = config.contentSpacing
        view.titleLabel.textColor = config.textColor
        view.titleLabel.numberOfLines = config.textLine
        return view
    }
    
    private func configHUDCustomView(customView: JWProgressHUDCustomView, mode: JWHUDMode) {
        
        switch mode {
        case .loading(let text):
            customView.loadingView.isHidden = false
            customView.iconImageView.isHidden = true
            
            customView.titleLabel.isHidden = (text?.isEmpty != false)
            customView.titleLabel.text = text
            
            customView.isLoading = true
            
            break
        case .imageText(let image, let text):
            customView.loadingView.isHidden = true
            customView.iconImageView.isHidden = false
            
            customView.titleLabel.isHidden = (text?.isEmpty != false)
            customView.titleLabel.text = text
            
            customView.iconImageView.image = image
            
            customView.isLoading = false
            
            break
        }
        
    }
    
    
}


extension UIView {
    
    private struct UIViewHUDKeys {
        static var timer        = "com.toast-swift.timer"
        static var duration     = "com.toast-swift.duration"
        static var point        = "com.toast-swift.point"
        static var completion   = "com.toast-swift.completion"
        static var activeToasts = "com.toast-swift.activeToasts"
        static var activityView = "com.toast-swift.activityView"
        static var queue        = "com.toast-swift.queue"
    }
    
    /// 当前活动的HUD
    private var activeHUDs: NSMutableArray {
        get {
            if let activeToasts = objc_getAssociatedObject(self, &UIViewHUDKeys.activeToasts) as? NSMutableArray {
                return activeToasts
            } else {
                let activeToasts = NSMutableArray()
                objc_setAssociatedObject(self, &UIViewHUDKeys.activeToasts, activeToasts, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activeToasts
            }
        }
    }
    
    /// 当前队列中的HUD
    private var queueHUDs: NSMutableArray {
        get {
            if let queue = objc_getAssociatedObject(self, &UIViewHUDKeys.queue) as? NSMutableArray {
                return queue
            } else {
                let queue = NSMutableArray()
                objc_setAssociatedObject(self, &UIViewHUDKeys.queue, queue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return queue
            }
        }
    }
    
}
