//
//  ProgressHUDCustomView.swift
//  JWLoadingHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit

/// 自定义指示器
public class JWLoadingCustomView: UIView {
    
    /// 保存mode
    public var mode: JWHUDMode =  .loading(nil) {
        didSet {
            let customView = self
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
    
    /// 加载
    public var isLoading: Bool = true {
        didSet {
            if loadingView.superview != nil, !isLoading {
                loadingView.removeFromSuperview()
            } else if loadingView.superview == nil, isLoading {
                containerStackView.insertArrangedSubview(loadingView, at: 0)
            }
        }
    }

    /// 内容之间的间距
    public var contentMargin: CGFloat = 10 {
        didSet {
            containerStackView.spacing = contentMargin
            setNeedsLayout()
        }
    }
    
    /// 图标
    public lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIView.ContentMode.center
        return view
    }()
    
    /// 文字
    public lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 14)
        view.numberOfLines = 0
        return view
    }()
    
    /// 加载图
    public lazy var loadingView: JWLoadingAnimatedView = {
        let view = JWLoadingAnimatedView()
        view.radius = 18
        view.strokeColor = .white
        view.strokeThickness = 2
        view.sizeToFit()
        return view
    }()
    
    /// 内容容器
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = contentMargin
        view.distribution = .equalCentering
        view.alignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    
    ///
    private func setup() {
        
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(loadingView)
        containerStackView.addArrangedSubview(iconImageView)
        containerStackView.addArrangedSubview(titleLabel)
        
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
}
