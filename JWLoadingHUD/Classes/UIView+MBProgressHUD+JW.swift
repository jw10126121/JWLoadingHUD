//
//  UIView+MBProgressHUD+JW.swift
//  JWLoadingHUD
//
//  Created by LjwMac on 2019/4/21.
//

import UIKit
import MBProgressHUD

/// 拓展UIView+MBProgressHUD
internal extension UIView {
    
var loadingHUDer: JWLoadingHUDer {
        
        set {
            objc_setAssociatedObject(self,
                                     &UIView_MBProgressHUD_Key.hudManagerKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let extObject = (objc_getAssociatedObject(self, &UIView_MBProgressHUD_Key.hudManagerKey) as? JWLoadingHUDer)
            if let extObject = extObject {
                return extObject
            } else {
                let aObject = JWLoadingHUDer(containerView: self)
                objc_setAssociatedObject(self,
                                         &UIView_MBProgressHUD_Key.hudManagerKey,
                                         aObject,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return aObject
            }
        }
        
    }
    
    /// HUD对象
    var hud: MBProgressHUD {
        
        set {
            objc_setAssociatedObject(self,
                                     &UIView_MBProgressHUD_Key.hudInstanceKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }

        get {
            if let userHud = objc_getAssociatedObject(self, &UIView_MBProgressHUD_Key.hudInstanceKey) as? MBProgressHUD {
                /// 用户设置的HUD
                return userHud
            } else if let extedHud = MBProgressHUD(for: self) {
                /// 已存在的HUD
                return extedHud
            } else {
                /// 生成一个新的HUD
                let aObject = MBProgressHUD(view: self)
                    .config { $0.setup(style: JWHUDManager.shared.defaultStyle) }
                objc_setAssociatedObject(self,
                                         &UIView_MBProgressHUD_Key.hudInstanceKey,
                                         aObject,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return aObject
            }
        }
    
    }
    

    
}


internal extension UIView {
    
    struct UIView_MBProgressHUD_Key {
        static var hudInstanceKey: String = "com.jw.app.JWLoadingHUD.UIView.MBProgressHUD.hudInstanceKey"
        static var hudManagerKey: String = "com.jw.Japp.JWLoadingHUD.UIView.MBProgressHUD.hudManagerKey"
    }
    
}
