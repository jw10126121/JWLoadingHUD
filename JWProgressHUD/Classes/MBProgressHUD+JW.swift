//
//  MBProgressHUD+JW.swift
//  JWProgressHUD
//
//  Created by LjwMac on 2019/4/21.
//

import Foundation
import MBProgressHUD


internal extension MBProgressHUD {
    
    func setup(config: JWHUDStyle) {
        
        /// 隐藏后移除
         removeFromSuperViewOnHide = true
         isSquare = false
        
         isUserInteractionEnabled = !config.isUserInteractionEnabled
         margin = config.minInsetMargin
         offset = config.offset
         bezelView.color = config.backgroundColor
         bezelView.layer.cornerRadius = config.cornerRadius
         label.font = config.textFont
         minSize = config.minSize
        
        
    }
    
    /// 配置样式
    @discardableResult func setupHUD() -> MBProgressHUD {
        
        /// 隐藏时，移出父视图
        self.removeFromSuperViewOnHide = true
        /// 不可点击
        self.isUserInteractionEnabled = false
        ///
        self.isSquare = false
        /// 间距
        self.margin = 20
        ///
        self.offset = CGPoint(x: 0, y: -20)
        
        // HUD背景设置
        
        /// HUD背景颜色
        self.bezelView.color = .black
        /// HUD背景圆角
        self.bezelView.layer.cornerRadius = 4
        /// HUD背景样式
        self.bezelView.style = .solidColor
        
        self.minSize = CGSize(width: 100, height: 80)
        /// 内容颜色
        self.contentColor = .white
        
        // 文字配置
        
        self.label.font = UIFont.systemFont(ofSize: 15)
        self.label.numberOfLines = 3;
        
        return self
    }
    
    /// 配置(链式调用)
    @discardableResult func config(_ config: (MBProgressHUD) -> Void) -> MBProgressHUD {
        config(self)
        return self
    }
    
    @discardableResult func showInMainThread(animated: Bool = true) -> MBProgressHUD {
        
        DispatchQueue.main.async(execute: {
            if self.superview != nil {
                self.show(animated: animated)
            }
        })
        return self
    }
    
    @discardableResult func show(in view: UIView? = UIApplication.shared.keyWindow, animated: Bool = true, hiddenDelay: TimeInterval = 0) -> MBProgressHUD {
        
        if let view = view {
            
            DispatchQueue.main.async(execute: {
                self.isHidden = false
                if self.superview != view {
                    if self.superview != nil { self.removeFromSuperview() }
                    view.addSubview(self)
                }
                view.bringSubviewToFront(self)
                self.show(animated: animated)
                
                if hiddenDelay > 0 {
                    self.hide(animated: animated, afterDelay: hiddenDelay)
                }
                
            })
        }

        return self
    }
    
    @discardableResult func dismiss(animated: Bool = true, afterDelay: TimeInterval = 0) -> MBProgressHUD {
        DispatchQueue.main.async(execute: {
            self.hide(animated: animated, afterDelay: afterDelay)
        })
        return self
    }
    

}
