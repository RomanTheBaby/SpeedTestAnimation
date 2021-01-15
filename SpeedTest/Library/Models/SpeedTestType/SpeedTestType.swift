//
//  SpeedTestType.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-14.
//

import UIKit


enum SpeedTestType {
    case download
    case upload
}

extension SpeedTestType {
    var image: UIImage {
        switch self {
        case .download:
            return UIImage(systemName: "arrow.down.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!
            
        case .upload:
            return UIImage(systemName: "arrow.up.circle", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!
        }
    }
    
    var imageTintColor: UIColor {
        switch self {
        case .download:
            return #colorLiteral(red: 0.08235294118, green: 0.7176470588, blue: 0.7333333333, alpha: 1)
            
        case .upload:
            return .purple
        }
    }
    
    var title: String {
        switch self {
        case .download:
            return "DOWNLOAD"
            
        case .upload:
            return "UPLOAD"
        }
    }
}
