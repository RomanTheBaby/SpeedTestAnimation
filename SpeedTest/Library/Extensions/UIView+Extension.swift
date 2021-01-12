//
//  UIView+Extension.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit


extension UIView {
    func embed(_ childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: topAnchor),
            childView.leftAnchor.constraint(equalTo: leftAnchor),
            childView.rightAnchor.constraint(equalTo: rightAnchor),
            childView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
