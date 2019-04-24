//
//  MBProgressHUD+JW.swift
//  JWLoadingHUD
//
//  Created by LjwMac on 2019/4/21.
//

import Foundation
import MBProgressHUD


internal extension MBProgressHUD {
    
    func setup(style: JWHUDStyle) {
        
        /// 隐藏后移除
         removeFromSuperViewOnHide = true
         isSquare = false
        
         isUserInteractionEnabled = !style.isUserInteractionEnabled
         margin = style.minInsetMargin
         offset = style.offset
         bezelView.color = style.backgroundColor
         bezelView.layer.cornerRadius = style.cornerRadius
         label.font = style.textFont
         minSize = style.minSize
        
        backgroundView.blurEffectStyle = style.blurStyle
    }
    
    /// 配置(链式调用)
    @discardableResult func config(_ config: (MBProgressHUD) -> Void) -> MBProgressHUD {
        config(self)
        return self
    }
    
    @discardableResult func show(in view: UIView? = UIApplication.shared.keyWindow,
                                 animated: Bool = true,
                                 hiddenDelay: TimeInterval = 0) -> MBProgressHUD {
        
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
                    self.dismiss(animated: animated, afterDelay: hiddenDelay)
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
