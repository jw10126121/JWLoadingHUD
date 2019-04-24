//
//  HUDConfig.swift
//  JWLoadingHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit
import ObjectiveC

/// HUD配置
public class JWHUDStyle: NSObject {
    
    
    ///  背景蒙层类型
    public var markType: JWLoadingHUDMarkType = .defaultMarkType
    
    /// 四边最小边距
    public var minInsetMargin: CGFloat = 20
    
    /// 图文间距
    public var contentSpacing: CGFloat = 10
    
    /// 内容偏移
    public var offset: CGPoint = CGPoint.zero
    
    /// HUD背景色
    public var backgroundColor: UIColor = UIColor(white: 0, alpha: 0.8)
    
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

public enum JWLoadingHUDMarkType {
    
    /// 固定颜色
    case color(UIColor?, isUserInteractionEnabled: Bool)
    /// 渐变色
    case gradient(UIColor, isUserInteractionEnabled: Bool)
    /// 高斯模糊(背景模糊，不可点击)
    case blur(style: UIBlurEffect.Style, tintColor: UIColor?)
    
    
    /// 默认配置
    public static let defaultMarkType = JWLoadingHUDMarkType.color(MarkDefaultColor.defaultMarkColor, isUserInteractionEnabled: true)
    
    /// 默认渐变配置
    public static let darkGradient = JWLoadingHUDMarkType.gradient(MarkDefaultColor.darkGradient, isUserInteractionEnabled: false)
    
    
    private struct MarkDefaultColor {
        static let defaultMarkColor = UIColor.clear
        static let darkGradient: UIColor = UIColor(white: 0, alpha: 0.4)
    }

    
    /// 是否可操作
    internal var isUserInteractionEnabled: Bool {
        switch self {
        case let .color(_, isUserInteractionEnabled: enable):
            return enable
        case let .gradient(_, isUserInteractionEnabled: enable):
            return enable
        default:
            return false
        }
    }
    
    
    
}
