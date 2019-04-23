//
//  JWProgressAnimatedView.swift
//  JWLoadingHUD
//
//  Created by linjw on 2019/4/23.
//

import UIKit

public class JWLoadingAnimatedView: UIView {

    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview != nil {
            layoutAnimationLayer()
            startAnimation()
        } else {
            stopAnimation()
            ringAnimatedLayer.removeFromSuperlayer()
        }
        
    }

    public var radius: CGFloat = 18 {
        didSet {
            stopAnimation()
            ringAnimatedLayer.removeFromSuperlayer()

            if self.superview != nil {
                layoutAnimationLayer()
            }
        }
    }
    
    public var strokeThickness: CGFloat = 2 {
        didSet {
            ringAnimatedLayer.lineWidth = strokeThickness
        }
    }
    
    var strokeColor: UIColor = UIColor.white {
        didSet {
            ringAnimatedLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    private lazy var maskLayer: CALayer = {
        let maskLayer = CALayer();
        let currentBundle = Bundle(for: type(of: self))
        let bundlePath = currentBundle.path(forResource: "JWLoadingHUD", ofType: ".bundle") ?? ""
        let path = Bundle(path: bundlePath)?.path(forResource: "angle-mask", ofType: "png") ?? ""
        maskLayer.contents = UIImage(contentsOfFile: path)?.cgImage
        return maskLayer
    }()
    
    private lazy var maskLayerAnimation: CABasicAnimation = {
        let animationDuration: TimeInterval = 1.0
        let linearCurve = CAMediaTimingFunction(name: .linear)
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi*2
        animation.duration = animationDuration
        animation.timingFunction = linearCurve
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.infinity
        animation.fillMode = .forwards
        animation.autoreverses = false;
        return animation
    }()
    
    /// 动画
    private lazy var ringAnimation: CAAnimationGroup = {
        let animationDuration: TimeInterval = 1.0
        let linearCurve = CAMediaTimingFunction(name: .linear)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = Float.infinity
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = linearCurve
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.015
        strokeStartAnimation.toValue = 0.515
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.485
        strokeEndAnimation.toValue = 0.985
        return animationGroup
    }()
    
    private lazy var ringAnimatedLayer: CAShapeLayer = {
        
        let arcCenter = CGPoint(x: self.radius+self.strokeThickness/2+5, y: self.radius+self.strokeThickness/2+5)
        let smoothedPath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: -CGFloat.pi/2.0, endAngle: CGFloat.pi*3.0/2.0, clockwise: true)
        let object = CAShapeLayer()
        
        object.contentsScale = UIScreen.main.scale
        object.frame = CGRect(x: 0.0, y: 0.0, width: arcCenter.x*2, height: arcCenter.y*2)
        object.fillColor = UIColor.clear.cgColor
        object.strokeColor = strokeColor.cgColor
        object.lineWidth = strokeThickness
        object.lineCap = .round
        object.lineJoin = .bevel
        object.path = smoothedPath.cgPath
        
        maskLayer.frame = object.bounds
        object.mask = maskLayer
        
        return object
    }()
    
    private func layoutAnimationLayer() {
        
        let layer = self.ringAnimatedLayer
        self.layer.addSublayer(layer)
        
        let widthDiff = bounds.width - layer.bounds.width
        let heightDiff = bounds.height - layer.bounds.height
        
        layer.position = CGPoint(x: bounds.width - layer.bounds.width / 2.0 - widthDiff / 2.0,
                                 y: bounds.height - layer.bounds.height / 2.0 - heightDiff / 2.0)
        
    }
    
    fileprivate var isAnimating: Bool = false
    

    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: (radius + strokeThickness/2.0 + 5.0) * 2.0, height: (radius + strokeThickness/2.0 + 5.0) * 2.0)
    }
    
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: (radius + strokeThickness/2.0 + 5.0) * 2.0, height: (radius + strokeThickness/2.0 + 5.0) * 2.0)
    }
    
}

extension JWLoadingAnimatedView: JWLoadingAnimatedViewable {
    
    /// 动画开始
    public func startAnimation() {
        
        if !isAnimating {
            isAnimating = true
            ringAnimatedLayer.mask?.add(maskLayerAnimation, forKey: "rotate")
            ringAnimatedLayer.add(ringAnimation, forKey: "progress")
        }
        
    }
    
    /// 动画结束
    public func stopAnimation() {
        if isAnimating {
            isAnimating = false
            ringAnimatedLayer.mask?.removeAnimation(forKey: "rotate")
            ringAnimatedLayer.removeAnimation(forKey: "progress")
        }
    }
    
}
