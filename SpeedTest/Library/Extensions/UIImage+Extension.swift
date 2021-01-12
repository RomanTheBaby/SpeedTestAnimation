//
//  UIImage+Extension.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit


extension UIImage {
    
    class var checkmark: UIImage {
        UIImage(systemName: "checkmark.circle", withConfiguration: SymbolConfiguration(weight: .light))!
    }
    
    class var globe: UIImage {
        UIImage(systemName: "globe", withConfiguration: SymbolConfiguration(weight: .light))!
    }
    
    class var slider: UIImage {
        UIImage(systemName: "slider.vertical.3", withConfiguration: SymbolConfiguration(weight: .light))!
    }
    
    class var wifi: UIImage {
        UIImage(systemName: "wifi", withConfiguration: SymbolConfiguration(weight: .light))!
    }
    
    class var octagon: UIImage {
        UIImage(systemName: "xmark.octagon", withConfiguration: SymbolConfiguration(weight: .light))!
    }
    
}
