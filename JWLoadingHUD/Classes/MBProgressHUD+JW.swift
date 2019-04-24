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
        
        self.backgroundColor = UIColor.clear
        
        /// 隐藏后移除
         removeFromSuperViewOnHide = true
         isSquare = false
        
         isUserInteractionEnabled = !style.markType.isUserInteractionEnabled
         margin = style.minInsetMargin
         offset = style.offset
         bezelView.color = style.backgroundColor
         bezelView.layer.cornerRadius = style.cornerRadius
         label.font = style.textFont
         minSize = style.minSize
        

        switch style.markType {
        case let .color(color, isUserInteractionEnabled: _):
            backgroundView.style = .solidColor
            backgroundView.color = color ?? UIColor.clear
            if gradientLayer.superlayer != nil { gradientLayer.removeFromSuperlayer() }
            break
        case let .gradient(color, isUserInteractionEnabled: _):
            backgroundView.style = .solidColor
            backgroundView.color = UIColor.clear
            if gradientLayer.superlayer != backgroundView {
                backgroundView.layer.insertSublayer(gradientLayer, at: 0)
            }

            gradientLayer.backgroundColor = color.cgColor
            gradientLayer.frame = backgroundView.bounds
            backgroundView.backgroundColor = UIColor.clear
            gradientLayer.gradientCenter = CGPoint(x: gradientLayer.frame.width / 2.0, y: gradientLayer.frame.height / 2.0)
            gradientLayer.setNeedsDisplay()
            
            debugPrint(backgroundView.bounds)
            
            break
        case .blur(let style, let tintColor):
            backgroundView.style = .blur
            backgroundView.color = tintColor ?? UIColor.clear
            backgroundView.blurEffectStyle = style
            if gradientLayer.superlayer != nil { gradientLayer.removeFromSuperlayer() }
            break
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didChangeStatusBarOrientationNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] notif in
                                                guard let self = self else { return }
                        self.didChangeStatusBarOrientationNotificationHandle(notification: notif)
        }
        
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { [weak self] notif in
                                                guard let self = self else { return }
                                                self.orientationDidChangeNotificationHandle(notification: notif)
        }
        
    }
    
    @objc private func didChangeStatusBarOrientationNotificationHandle(notification: Notification) {
        
//        debugPrint("状态栏旋转")
//        debugPrint("\(backgroundView.bounds)")
        if gradientLayer.superlayer != nil {
            gradientLayer.frame = backgroundView.bounds
            gradientLayer.gradientCenter = CGPoint(x: gradientLayer.frame.width / 2.0, y: gradientLayer.frame.height / 2.0)
            gradientLayer.setNeedsDisplay()
        }
        
//        let radians = UIApplication.shared.statusBarOrientation.isLandscape ? -CGFloat.pi/2.0: CGFloat.pi/2.0
//        if UIApplication.shared.statusBarOrientation.isLandscape {
//            self.hud.transform = CGAffineTransform(rotationAngle: radians)
//        } else {
//            self.hud.transform = CGAffineTransform.identity
//        }
        
    }
    
    @objc private func orientationDidChangeNotificationHandle(notification: Notification) {
        
        if gradientLayer.superlayer != nil {
            gradientLayer.frame = backgroundView.bounds
            gradientLayer.gradientCenter = CGPoint(x: gradientLayer.frame.width / 2.0, y: gradientLayer.frame.height / 2.0)
            gradientLayer.setNeedsDisplay()
        }
        
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
        
//        NotificationCenter.default.removeObserver(self, name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
//        self.completionBlock = { _ -> Void in
//
//        }
        DispatchQueue.main.async(execute: {
        
            self.hide(animated: animated, afterDelay: afterDelay)
        })
        return self
    }
    

}

internal extension MBProgressHUD {
    
    /// runtime keys
    private struct MBProgressHUDKeys {
        static var gradientLayer = "com.jw.app.loadingHUD.MBProgressHUD.gradientLayer"
        static var isShowGradientLayer = "com.jw.app.loadingHUD.MBProgressHUD.isShowGradientLayer"
    }

    /// 渐变图层
     var gradientLayer: JWLoadingHUDGradientLayer {
        get {
            if let aLayer = objc_getAssociatedObject(self, &MBProgressHUDKeys.gradientLayer) as? JWLoadingHUDGradientLayer {
                return aLayer
            } else {
                let aLayer = JWLoadingHUDGradientLayer()
                aLayer.backgroundColor = UIColor(white: 0, alpha: 0.4).cgColor
                objc_setAssociatedObject(self,
                                         &MBProgressHUDKeys.gradientLayer,
                                         aLayer,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return aLayer
            }
        }
    }
    
    /// 是否显示
    private var isShowGradientLayer: Bool {
        set {
            objc_setAssociatedObject(self,
                                     &MBProgressHUDKeys.gradientLayer,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            if let value = objc_getAssociatedObject(self, &MBProgressHUDKeys.gradientLayer) as? Bool {
                return value
            }
            return false
        }
    }
    
    
}




