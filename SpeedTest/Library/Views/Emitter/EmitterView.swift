//
//  EmitterView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-12.
//

import UIKit


class EmitterView: UIView {
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let emitter = layer as? CAEmitterLayer,
              let particleImage = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate),
              let turquoiseParticleImage = particleImage.recolor(to: #colorLiteral(red: 0.08137629181, green: 0.7185662389, blue: 0.7331223488, alpha: 1)),
              let grayParticleImage = particleImage.recolor(to: #colorLiteral(red: 0.6435351372, green: 0.6973400712, blue: 0.7438098788, alpha: 1)),
              let purpeParticleImage = particleImage.recolor(to: #colorLiteral(red: 0.5639237761, green: 0.4082424939, blue: 0.7163909078, alpha: 1)) else {
            return
        }

        emitter.emitterShape = .cuboid
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitter.emitterSize = bounds.size
        emitter.renderMode = .additive

        emitter.emitterCells = [
            createEmitterCell(withVelocity: 80, scale: 0.15, image: turquoiseParticleImage),
            createEmitterCell(withVelocity: 50, scale: 0.09, image: grayParticleImage),
            createEmitterCell(withVelocity: 40, scale: 0.08, image: purpeParticleImage),
        ]
    }
    
    
    private func createEmitterCell(withVelocity velocity: CGFloat, scale: CGFloat, image: UIImage) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 40
        cell.lifetimeRange = 20
        cell.velocity = 0
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = scale
        cell.scaleRange = scale / 3

        cell.contents = image.cgImage
        
        return cell
    }
}


// MARK: - UIIMage Helper Extension

private extension UIImage {
    func recolor(to newColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        
        newColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        newImage.accessibilityIdentifier = accessibilityIdentifier
        return newImage
    }
}
