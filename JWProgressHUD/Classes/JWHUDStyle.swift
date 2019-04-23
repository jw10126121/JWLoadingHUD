//
//  HUDConfig.swift
//  JWProgressHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit
import ObjectiveC

/// HUD配置
public class JWHUDStyle: NSObject {
    
    /// 默认配置
    static public let defaultConfig: JWHUDStyle = JWHUDStyle()
    
    /// 模式
    public var mode: JWHUDMode = .loading(nil)
    
    /// 是否背景可点
    public var isUserInteractionEnabled: Bool = true
    
    /// 四边最小边距
    public var minInsetMargin: CGFloat = 20
    
    /// 图文间距
    public var contentSpacing: CGFloat = 10
    
    /// 内容偏移
    public var offset: CGPoint = CGPoint.zero
    
    /// 背景色
    public var backgroundColor: UIColor = UIColor(white: 0, alpha: 1.0)
    
    /// 圆角
    public var cornerRadius: CGFloat = 4.0
    
    /// 文字颜色
    public var textColor: UIColor = .white
    
    /// 文字字体
    public var textFont: UIFont = UIFont.systemFont(ofSize: 16)
    
    /// 文字行数
    public var textLine: Int = 0
    
    /// 最小大小
    public var minSize: CGSize = .zero
    

    
}
