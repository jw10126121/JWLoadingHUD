//
//  JWProgressHUD.swift
//  JWProgressHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit
import MBProgressHUD

/// HUD模式
public enum JWHUDMode {
    
    /// HUD模式：加载图
    case loading(String?)
    /// HUD模式：图文
    case imageText(UIImage?, String?)
    
}

public class JWHUDHandle {
    
    /// 模式
    private var mode: JWHUDMode = .loading(nil) {
        didSet {
            switch mode {
            case .loading(let text):
                hudContainerView.loadingView.isHidden = false
                hudContainerView.iconImageView.isHidden = true

                hudContainerView.titleLabel.isHidden = (text?.isEmpty != false)
                hudContainerView.titleLabel.text = text

                hudContainerView.isLoading = true

                break
            case .imageText(let image, let text):
                hudContainerView.loadingView.isHidden = true
                hudContainerView.iconImageView.isHidden = false

                hudContainerView.titleLabel.isHidden = (text?.isEmpty != false)
                hudContainerView.titleLabel.text = text

                hudContainerView.iconImageView.image = image

                hudContainerView.isLoading = false

                break
            }
        }
    }
    
    /// HUD内容
    public lazy var hudContainerView: JWLoadingCustomView = {
        let view = JWLoadingCustomView()
        return view
    }()
    

    private let containerView: UIView
    init(containerView: UIView) {
        self.containerView = containerView
        setup(hud: containerView.hud)
    }

    /// 配置样式
    @discardableResult fileprivate func setup(hud: MBProgressHUD) -> JWHUDHandle {
        
        /// 隐藏时，移出父视图
        hud.removeFromSuperViewOnHide = true
        /// 不可点击
        hud.isUserInteractionEnabled = !config.isUserInteractionEnabled
        ///
        hud.isSquare = false
        /// 间距
        hud.margin = config.minInsetMargin
        ///
        hud.offset = config.offset
        
        // HUD背景设置
        
        /// HUD背景颜色
        hud.bezelView.color = config.backgroundColor
        /// HUD背景圆角
        hud.bezelView.layer.cornerRadius = config.cornerRadius
        /// HUD背景样式
        hud.bezelView.style = .solidColor
        
        hud.minSize = config.minSize
        /// 内容颜色
        hud.contentColor = config.textColor
        
        // 文字配置
        
        hud.label.font = config.textFont
        hud.label.numberOfLines = 1
        
        hud.mode = .customView
        hud.customView = hudContainerView
        hudContainerView.sizeToFit()
        
        hud.label.text = nil
        
        return self
    }
    
    /// 配置文件
    internal var config: JWHUDStyle = JWHUDStyle()
    
    internal func configHud(config: JWHUDStyle) {
        
        self.config = config

        /// 隐藏后移除
        containerView.hud.removeFromSuperViewOnHide = true
        containerView.hud.isSquare = false
        containerView.hud.mode = .customView
        containerView.hud.customView = hudContainerView

        containerView.hud.isUserInteractionEnabled = !config.isUserInteractionEnabled
        containerView.hud.margin = config.minInsetMargin
        containerView.hud.offset = config.offset
        containerView.hud.bezelView.color = config.backgroundColor
        containerView.hud.bezelView.layer.cornerRadius = config.cornerRadius
        containerView.hud.label.font = config.textFont
        containerView.hud.minSize = config.minSize
        
        hudContainerView.titleLabel.font = config.textFont
        hudContainerView.contentMargin = config.contentSpacing
        hudContainerView.titleLabel.textColor = config.textColor
        hudContainerView.titleLabel.numberOfLines = config.textLine
        
     }
    
    func configHud(mode: JWHUDMode) {
        self.mode = mode
        hudContainerView.sizeToFit()
    }
    
    /// 显示HUD
    @discardableResult public func show(config: JWHUDStyle = JWHUDStyle.defaultConfig,
                                        mode: JWHUDMode,
                                        animated: Bool = true,
                                        hiddenDelay: TimeInterval = 0) -> JWHUDHandle {
        
        let view = containerView
        let hudView = view.hud
        configHud(config: config)
        configHud(mode: mode)
        hudView.show(in: view, animated: animated, hiddenDelay: hiddenDelay)
        
        return self
        
    }
    
    @discardableResult public func dismiss(animated: Bool = true, afterDelay: TimeInterval = 0) -> JWHUDHandle {
        
        let hudView = containerView.hud
        hudView.dismiss(animated: animated, afterDelay: afterDelay)
        
        return self
    }
    

    
    
    
    
}

///// 拓展UIView+MBProgressHUD
//public extension JWHUDManager {
//
//        fileprivate struct UIView_MBProgressHUD_Key {
//            static var hudInstanceKey: String = "com.jw.JWProgressHUD.UIView.MBProgressHUD.hudInstanceKey"
//        }
//
//
//    /// HUD对象
//    var hud: MBProgressHUD {
//
//        set {
//            objc_setAssociatedObject(self,
//                                     &JWHUDManager.UIView_MBProgressHUD_Key.hudInstanceKey,
//                                     newValue,
//                                     objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//
//        get {
//            if let userHud = objc_getAssociatedObject(self, &JWHUDManager.UIView_MBProgressHUD_Key.hudInstanceKey) as? MBProgressHUD {
//                /// 用户设置的HUD
//                return userHud
//            } else if let extedHud = MBProgressHUD(for: self) {
//                /// 已存在的HUD
//                return extedHud
//            } else {
//                /// 生成一个新的HUD
//                return MBProgressHUD(frame: UIScreen.main.bounds).config { $0.setupHUD() }
//            }
//        }
//
//    }
//
//}
