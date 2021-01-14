//
//  EmitterView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-12.
//

import UIKit


final class EmitterView: UIView {
    
    typealias EmissionSource = EmitterLayer.EmissionSource
    
    
    // MARK: - Emission
    
    enum Emission {
        /// goes from center
        case center
        /// goes to center...kinda, inclues .bottomLeft, .bottomRight, .topLeft, .topRight
        case sides
    }
    
    
    // MARK: - Public Properties
    
    var isSideEmissionEnabled = true {
        didSet {
            emitters.filter {
                $0.key != .center
            }
            .forEach { _, emitterLayer in
                if isSideEmissionEnabled {
                    layer.addSublayer(emitterLayer)
                } else {
                    emitterLayer.removeFromSuperlayer()
                }
            }
        }
    }
    var isCenterEmissionEnabled = true {
        didSet {
            emitters.filter {
                $0.key == .center
            }
            .forEach { _, emitterLayer in
                if isCenterEmissionEnabled {
                    layer.addSublayer(emitterLayer)
                } else {
                    emitterLayer.removeFromSuperlayer()
                }
            }
        }
    }
    
    
    // MARK: - Private Properties
    
    private var emitters: [EmitterLayer.EmissionSource: EmitterLayer] = [:]
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard emitters.isEmpty == true else { return }
        
        emitters = EmissionSource.allCases.map {
            ($0, EmitterLayer(source: $0, bounds: bounds))
        }.reduce(into: [:]) { result, arg1 in
            let (source, layer) = arg1
            result[source] = layer
        }
        
//        [
//            .bottomLeft: EmitterLayer(source: .bottomLeft, bounds: bounds),
//            .bottomRight: EmitterLayer(source: .bottomRight, bounds: bounds),
//            .center: EmitterLayer(source: .center, bounds: bounds),
//            .topLeft: EmitterLayer(source: .topLeft, bounds: bounds),
//            .topRight: EmitterLayer(source: .topRight, bounds: bounds),
//        ]
        
        emitters.values.forEach { emitterLayer in
            emitterLayer.startEmission()
            layer.addSublayer(emitterLayer)
        }
    }
}
