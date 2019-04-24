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
        case let .darkGradient(color, isUserInteractionEnabled: _):
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

internal extension MBProgressHUD {
    
    /// runtime keys
    private struct MBProgressHUDKeys {
        static var gradientLayer = "com.jw.app.loadingHUD.MBProgressHUD.gradientLayer"
    }

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
    
}




