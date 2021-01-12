//
//  RoundedButton.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit


class RoundedButton: UIButton {
    
    
    // MARK: - Public Properties
    
    /// If `true` will cast rounded shadow, with same colors as `backgroundColor` value, with predefined parameters.
    var castsShadow = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    // MARK: - Private Properties
    
    private(set) lazy var shadowLayer: CAShapeLayer = {
        let shadowLayer = CAShapeLayer()
        layer.insertSublayer(shadowLayer, at: 0)
        setNeedsLayout()
        return shadowLayer
    }()
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        
        guard castsShadow else { return }
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = backgroundColor?.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = .zero
        shadowLayer.shadowOpacity = 0.95
        shadowLayer.shadowRadius = 15
    }
    
}
