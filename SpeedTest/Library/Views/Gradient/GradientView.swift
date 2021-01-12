//
//  GradientView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit


class GradientView: UIView {
    
    
    // MARK: - Private Properties
    
    private var gradientLayer: CAGradientLayer?
    
    
    // MARK: - Init

    init() {
        super.init(frame: .zero)
        
        applyColors()
    }
    
    init(topColor: UIColor, bottomColor: UIColor) {
        super.init(frame: .zero)

        applyColors([topColor, bottomColor])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        applyColors()
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let gradientLayer = gradientLayer else { return }
        gradientLayer.frame = bounds
    }
    
    
    // MARK: - Private Methods
    
    private func applyColors(_ gradientColors: [UIColor] = [.gradientTop, .gradientBottom]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors.map(\.cgColor)
        gradientLayer.locations = [0.0, 0.7]
        layer.masksToBounds = true
        layer.addSublayer(gradientLayer)
        
        self.gradientLayer = gradientLayer
        
        layer.setNeedsLayout()
    }
}


//20, 34, 44
// 16, 29, 37
//48 68 81
private extension UIColor {
    class var gradientTop: UIColor {
        #colorLiteral(red: 0.1882352941, green: 0.2666666667, blue: 0.3176470588, alpha: 1)
    }
    
    class var gradientBottom: UIColor {
//        #colorLiteral(red: 0.07843137255, green: 0.1333333333, blue: 0.1725490196, alpha: 1)
        #colorLiteral(red: 0.06274509804, green: 0.1137254902, blue: 0.1450980392, alpha: 1)
    }
}
