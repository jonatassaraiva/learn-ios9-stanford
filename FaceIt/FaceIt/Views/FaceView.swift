//
//  FaceView.swift
//  FaceIt
//
//  Created by Jonatas Saraiva on 11/02/17.
//  Copyright © 2017 jonatas saraiva. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var scale: CGFloat = 0.90
    
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeigth: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Rigth
    }
    
    private func getEyeCenter(eye: FaceView.Eye) -> CGPoint {
        let eyeOffeset = self.skullRadius / Ratios.SkullRadiusToEyeOffset
        
        var eyeCenter = self.skullCenter
         eyeCenter.y -= eyeOffeset
        
        switch eye {
            case .Left:
                eyeCenter.x -= eyeOffeset
            case .Rigth:
                eyeCenter.x += eyeOffeset
        }
        
        return eyeCenter
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: midPoint, radius: withRadius, startAngle: 0.0,
                            endAngle: CGFloat(2 * M_PI), clockwise: false)
        path.lineWidth = 5.0
        
        return path
    }
    
    private func pathForEye(eye: FaceView.Eye) -> UIBezierPath {
        let eyeRaduis = self.skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = self.getEyeCenter(eye: eye)
        
        return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRaduis)
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthHeigth = self.skullRadius / Ratios.SkullRadiusToMouthHeigth
        let mouthWidth = self.skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthOffset = self.skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: self.skullCenter.x - mouthWidth / 2, y: self.skullCenter.y +  mouthOffset,
                               width: mouthWidth, height: mouthHeigth)
        
        let mouthCurvature: Double = 1.0
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        
        let controlPoint1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y:  mouthRect.minY + smileOffset)
        let controlPoint2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y:  mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        
        self.pathForCircleCenteredAtPoint(midPoint: self.skullCenter, withRadius: self.skullRadius)
            .stroke()
        
        self.pathForEye(eye: Eye.Left)
            .stroke()
        self.pathForEye(eye: Eye.Rigth)
            .stroke()
        
        self.pathForMouth()
            .stroke()
    }
}
