//
//  SpeedInfoView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-12.
//

import UIKit


final class SpeedInfoView: UIView, NibInstantiatable {
    
    
    // MARK: - SpeedType
    
    enum SpeedType {
        case download
        case upload
    }
    
    
    // MARK: - Public Properties
    
    var speedType: SpeedType = .download {
        didSet {
            updateInterface()
        }
    }
    
    var speed: Double?
    
    
    // MARK: - Outlets

    @IBOutlet private var typeImageView: UIImageView!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var speedLabel: UILabel!
    
    
    // MARK: - Helper Methods
    
    private func updateInterface() {
        typeImageView.image = speedType.image
        typeImageView.tintColor = speedType.imageTintColor
        typeLabel.text = speedType.title
        
        if let speed = speed {
            speedLabel.text = "\(speed)"
        } else {
            speedLabel.text = "-"
        }
        
    }
    
}

private extension SpeedInfoView.SpeedType {
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
