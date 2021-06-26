//
//  SpeedInfoView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-12.
//

import UIKit


final class SpeedInfoView: UIView, NibInstantiatable {
    
    
    // MARK: - Public Properties
    
    var speedType: SpeedTestType = .download {
        didSet {
            updateInterface()
        }
    }
    
    var speed: Double? {
        didSet {
            updateSpeedLabel()
        }
    }
    
    
    // MARK: - Outlets

    @IBOutlet private var typeImageView: UIImageView!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var speedLabel: UILabel!
    
    
    // MARK: - Helper Methods
    
    private func updateInterface() {
        typeImageView.image = speedType.image
        typeImageView.tintColor = speedType.imageTintColor
        typeLabel.text = speedType.title
        
        updateSpeedLabel()
    }
    
    private func updateSpeedLabel() {
        UIView.transition(with: speedLabel,
                          duration: 0.25,
                          options: .transitionFlipFromTop,
                          animations: { [self] in
                            if let speed = speed {
                                speedLabel.text = "\(speed)"
                            } else {
                                speedLabel.text = "-"
                            }
                          })
    }
    
}

