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
            return .green
            
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
