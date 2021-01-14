//
//  RoundedView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-13.
//

import UIKit


final class RoundedView: UIView {
    
    
    // MARK: - Init
    
    init(color: UIColor, translatesAutoresizingMaskIntoConstraints: Bool = false) {
        super.init(frame: .zero)
        
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2
    }
    
}
