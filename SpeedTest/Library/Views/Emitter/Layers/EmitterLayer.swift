//
//  EmitterLayer.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-13.
//

import UIKit


class EmitterLayer: CAEmitterLayer {
    

    // MARK: - EmissionSource
    
    enum EmissionSource: CaseIterable {
        case bottomLeft
        case bottomRight
        case center
        case middleLeft
        case middleRight
        case topLeft
        case topRight
    }
    
    
    // MARK: - Private Properties
    
    private let source: EmissionSource
    
    private let particleImage = UIImage(systemName: "circle.fill")!.withRenderingMode(.alwaysTemplate)
    private lazy var turquoiseParticleImage = particleImage.recolor(to: #colorLiteral(red: 0.08235294118, green: 0.7176470588, blue: 0.7333333333, alpha: 1))!
    private lazy var purpeParticleImage = particleImage.recolor(to: #colorLiteral(red: 0.5639237761, green: 0.4082424939, blue: 0.7163909078, alpha: 1))!
    
    
    // MARK: - Init
    
    init(source: EmissionSource, bounds: CGRect) {
        self.source = source
        
        super.init()
        
        setup(with: source, bounds: bounds)
    }
    
    override init(layer: Any) {
        self.source = .center
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This init is not supported")
    }
    
    
    // MARK: - Public Methods
    
    func startEmission() {
        guard (emitterCells ?? []).isEmpty else {
            birthRate = 1
            return
        }
        
        switch source {
        case .bottomLeft:
            emitterCells = [
                createEmitterCell(withVelocity: 70, birthRate: 1, lifetime: 1.5, scale: 0.12, image: turquoiseParticleImage, emissionLongitude: (5 * .pi) / 3),
                createEmitterCell(withVelocity: 80, birthRate: 1, lifetime: 1.4, scale: 0.3, image: turquoiseParticleImage, emissionLongitude: (7 * .pi) / 4)
            ]
            
        case .bottomRight:
            emitterCells = [
                createEmitterCell(withVelocity: 90, birthRate: 1, lifetime: 1.6, scale: 0.14, image: turquoiseParticleImage, emissionLongitude: (5 * .pi) / 4),
                createEmitterCell(withVelocity: 50, birthRate: 1, lifetime: 2, scale: 0.11, image: turquoiseParticleImage, emissionLongitude: (4 * .pi) / 3)
            ]
            
            
        case .center:
            emitterCells = [
                createEmitterCell(withVelocity: 50, birthRate: 1, lifetime: 4, scale: 0.15, image: purpeParticleImage, emissionLongitude: .pi, emissionRange: 2 * .pi),
                createEmitterCell(withVelocity: 40, birthRate: 1, lifetime: 4, scale: 0.095, image: purpeParticleImage, emissionLongitude: .pi, emissionRange: 2 * .pi),
                createEmitterCell(withVelocity: 45, birthRate: 1.2, lifetime: 3, scale: 0.1, image: purpeParticleImage, emissionLongitude: .pi, emissionRange: 2 * .pi),
            ]

        case .middleLeft:
            emitterCells = [
                createEmitterCell(withVelocity: 70, birthRate: 1, lifetime: 1.5, scale: 0.15, image: turquoiseParticleImage, emissionLongitude: 2 * .pi),
                createEmitterCell(withVelocity: 80, birthRate: 1, lifetime: 1.4, scale: 0.3, image: turquoiseParticleImage, emissionLongitude: (11 * .pi) / 6)
            ]
            
        case .middleRight:
            emitterCells = [
                createEmitterCell(withVelocity: 90, birthRate: 1, lifetime: 1.6, scale: 0.2, image: turquoiseParticleImage, emissionLongitude: .pi),
                createEmitterCell(withVelocity: 50, birthRate: 1, lifetime: 2, scale: 0.11, image: turquoiseParticleImage, emissionLongitude: (7 * .pi) / 6)
            ]

        case .topLeft:
            emitterCells = [
                createEmitterCell(withVelocity: 100, birthRate: 1, lifetime: 1, scale: 0.2, image: turquoiseParticleImage, emissionLongitude: .pi / 4),
                createEmitterCell(withVelocity: 120, birthRate: 1, lifetime: 0.9, scale: 0.12, image: turquoiseParticleImage, emissionLongitude: .pi / 6)
            ]
            
        case .topRight:
            emitterCells = [
                createEmitterCell(withVelocity: 70, birthRate: 1, lifetime: 1.5, scale: 0.15, image: turquoiseParticleImage, emissionLongitude: (3 * .pi) / 4),
                createEmitterCell(withVelocity: 100, birthRate: 1, lifetime: 1, scale: 0.15, image: turquoiseParticleImage, emissionLongitude: (5 * .pi) / 6)
            ]
            
        }
    }
    
    func stopEmission() {
        birthRate = 0
//        emitterCells = []
    }
    
    
    // MARK: - Private Methods
    
    private func setup(with source: EmissionSource, bounds: CGRect) {
        emitterShape = .point
//        emitterSize = CGSize(width: 100, height: 100)
//        emitterSize = bounds.size
        renderMode = .additive

//        fillMode = .backwards
        
        switch source {
        case .bottomLeft:
            emitterPosition = CGPoint(x: 0, y: bounds.maxY)
            
        case .bottomRight:
            emitterPosition = CGPoint(x: bounds.maxX, y: bounds.maxY)
            
        case .center:
            emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
            
        case .middleLeft:
            emitterPosition = CGPoint(x: 0, y: bounds.midY)
            
        case .middleRight:
            emitterPosition = CGPoint(x: bounds.maxX, y: bounds.midY)
            
        case .topLeft:
            emitterPosition = .zero
            
        case .topRight:
            emitterPosition = CGPoint(x: bounds.maxX, y: 0)
            
        }
    }
    
    private func createEmitterCell(withVelocity velocity: CGFloat,
                                   birthRate: Float,
                                   lifetime: Float,
                                   scale: CGFloat,
                                   image: UIImage,
                                   emissionLongitude: CGFloat,
                                   emissionRange: CGFloat = 0) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = birthRate
        cell.lifetime = lifetime
        cell.lifetimeRange = lifetime / 2
        cell.velocity = velocity
        cell.emissionLongitude = emissionLongitude
        cell.emissionRange = emissionRange
        cell.scale = scale
        cell.scaleRange = scale / 2

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
