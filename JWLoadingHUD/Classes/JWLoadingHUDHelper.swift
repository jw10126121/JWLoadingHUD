//
//  JWLoadingHUDHelper.swift
//  JWLoadingHUD
//
//  Created by LjwMac on 2019/4/24.
//

import Foundation


internal func transformRotationAngle(from io: UIInterfaceOrientation) -> CGAffineTransform {
    var t: CGAffineTransform = CGAffineTransform.identity
    if io == UIInterfaceOrientation.landscapeLeft {
        t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    } else if io == UIInterfaceOrientation.landscapeRight {
        t = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
    }
    return t
}

// 设备方向转化为屏幕方向
internal func interfaceOrientation(from deviceO: UIDeviceOrientation) -> UIInterfaceOrientation {
    
    switch deviceO {
    case .landscapeLeft:
        return .landscapeRight
    case .landscapeRight:
        return .landscapeLeft
    case .unknown:
        return .unknown
    case .portrait:
        return .portrait
    case .portraitUpsideDown:
        return .portraitUpsideDown
    default:
        return .portrait
        
    }
}
