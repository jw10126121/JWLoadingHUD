//
//  JWLoadingHUDHelper.swift
//  JWLoadingHUD
//
//  Created by LjwMac on 2019/4/24.
//

import Foundation

internal func transformRotationAngle(from io: UIInterfaceOrientation, deviceOrientation: UIDeviceOrientation = .portrait) -> CGAffineTransform {
    
    var t: CGAffineTransform = CGAffineTransform.identity
    
    switch interfaceOrientation(from: deviceOrientation) {
        
    case .portraitUpsideDown:
        
        switch io {
        case .portrait:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            break
        case .landscapeLeft:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            break
        case .landscapeRight:
            t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            break
        default: break
        }
        break
        
    case .landscapeLeft:
        
        switch io {
        case .portrait:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            break
        case .portraitUpsideDown:
            t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            break
        case .landscapeRight:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            break
        default: break
        }
        
        break
    case .landscapeRight:
        
        switch io {
        case .portrait:
            t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            break
        case .portraitUpsideDown:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            break
        case .landscapeLeft:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            break
        default: break
        }
        
        
        break
    default:
        
        switch io {
        case .portraitUpsideDown:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            break
        case .landscapeRight:
            t = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            break
        case .landscapeLeft:
            t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
            break
        default: break
        }
        
        
        break
    }
    
    //    if io == UIInterfaceOrientation.landscapeLeft {
    //        t = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    //    } else if io == UIInterfaceOrientation.landscapeRight {
    //        t = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
    //    }
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

