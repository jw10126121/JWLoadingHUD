//
//  UIView+MBProgressHUD+JW.swift
//  JWProgressHUD
//
//  Created by LjwMac on 2019/4/21.
//

import UIKit
import MBProgressHUD

/// 拓展UIView+MBProgressHUD
public extension UIView {
    
    var hudManager: JWHUDManager {
        
        set {
            objc_setAssociatedObject(self,
                                     &UIView_MBProgressHUD_Key.hudManagerKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            let extObject = (objc_getAssociatedObject(self, &UIView_MBProgressHUD_Key.hudManagerKey) as? JWHUDManager)
            if let extObject = extObject {
                return extObject
            } else {
                let aObject = JWHUDManager(containerView: self)
                objc_setAssociatedObject(self,
                                         &UIView_MBProgressHUD_Key.hudManagerKey,
                                         aObject,
                                         objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
                return aObject
            }
        }
        
    }
    
    /// HUD对象
    internal var hud: MBProgressHUD {
        
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
                let aObject = MBProgressHUD(view: self).config { $0.setupHUD() }
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
        static var hudInstanceKey: String = "com.jw.JWProgressHUD.UIView.MBProgressHUD.hudInstanceKey"
        static var hudManagerKey: String = "com.jw.JWProgressHUD.UIView.MBProgressHUD.hudManagerKey"
    }
    
}
