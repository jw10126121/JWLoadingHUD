//
//  JWLoadingHUDGradientLayer.swift
//  JWLoadingHUD
//
//  Created by LjwMac on 2019/4/24.
//

import UIKit
import QuartzCore

/// 渐变图层
internal class JWLoadingHUDGradientLayer: CALayer {
    
    
    var gradientCenter: CGPoint = CGPoint.zero
    
    override func draw(in ctx: CGContext) {
        
        let locationsCount: Int = 2
        
        let locations: [CGFloat] = [0.0, 1.0]
        
        let colors: [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locationsCount) else {
            return
        }
//        CGColorSpaceRelease(colorSpace)
        let radius = min(self.bounds.width, self.bounds.height)
        
        ctx.drawRadialGradient(gradient, startCenter: self.gradientCenter, startRadius: 0, endCenter: self.gradientCenter, endRadius: radius, options: [.drawsAfterEndLocation])
        
//        CGGradientRelease(gradient)

    }
    

}
