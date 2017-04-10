//
//  FaceView.swift
//  Faceit
//
//  Created by Janet Zhang on 4/9/17.
//  Copyright © 2017 Janet Zhang. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.9
    var eyesOpen: Bool = false
    
    private var skullRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var skullCenter: CGPoint{
        return CGPoint(x:bounds.midX, y:bounds.midY)
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += (eye == .left ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRaidusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        
        let path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        
        path.lineWidth = 5.0
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.skullRaidusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRaidusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRaidusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        let path = UIBezierPath(rect: mouthRect)
        return path
    }
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.black.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRaidusToEyeRadius: CGFloat = 10
        static let skullRaidusToMouthWidth: CGFloat = 1
        static let skullRaidusToMouthHeight: CGFloat = 3
        static let skullRaidusToMouthOffset: CGFloat = 3
        
    }
}
