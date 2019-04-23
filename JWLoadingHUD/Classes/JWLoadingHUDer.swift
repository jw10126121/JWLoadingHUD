//
//  JWLoadingHUD.swift
//  JWLoadingHUD
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

public class JWLoadingHUDer {
    
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
    }
    
    /// 配置文件
    internal var style: JWHUDStyle = JWHUDStyle()
    
    internal func configHud(style: JWHUDStyle) {
        
        self.style = style

        /// 隐藏后移除
        containerView.hud.removeFromSuperViewOnHide = true
        containerView.hud.isSquare = false
        containerView.hud.mode = .customView
        containerView.hud.customView = hudContainerView
        containerView.hud.animationType = .zoom
        
        containerView.hud.isUserInteractionEnabled = !style.isUserInteractionEnabled
        containerView.hud.margin = style.minInsetMargin
        containerView.hud.offset = style.offset
        containerView.hud.bezelView.color = style.backgroundColor
        containerView.hud.bezelView.layer.cornerRadius = style.cornerRadius
        containerView.hud.label.font = style.textFont
        containerView.hud.minSize = style.minSize
        
        hudContainerView.titleLabel.font = style.textFont
        hudContainerView.contentMargin = style.contentSpacing
        hudContainerView.titleLabel.textColor = style.textColor
        hudContainerView.titleLabel.numberOfLines = style.textLine
        
     }
    
    func configHud(mode: JWHUDMode) {
        self.mode = mode
        hudContainerView.sizeToFit()
    }
    
    /// 显示HUD
    @discardableResult internal func show(config: JWHUDStyle = JWHUDManager.shared.defaultStyle,
                                          mode: JWHUDMode,
                                          animated: Bool = true,
                                          hiddenDelay: TimeInterval = 0) -> JWLoadingHUDer {
        
        let view = containerView
        let hudView = view.hud
        configHud(style: config)
        configHud(mode: mode)
        hudView.show(in: view, animated: animated, hiddenDelay: hiddenDelay)
        
        return self
        
    }
    
    @discardableResult internal func dismiss(animated: Bool = true, afterDelay: TimeInterval = 0) -> JWLoadingHUDer {
        
        let hudView = containerView.hud
        hudView.dismiss(animated: animated, afterDelay: afterDelay)
        
        return self
    }
    

    
    
    
    
}


