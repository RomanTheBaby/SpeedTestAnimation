//
//  SpeedTestViewController.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit

final class SpeedTestViewController: UIViewController {
    
    
    // MARK: - Private Outlets
    
    @IBOutlet private var startTestButton: RoundedButton!
    
    @IBOutlet private var sliderButton: RoundedButton!
    @IBOutlet private var checkmarkButton: RoundedButton!
    @IBOutlet private var octagonButton: RoundedButton!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
    
    // MARK: - Private Methods
    
    private func setupAppearance() {
        setupGradientView()
        setupStartButton()
        setupToolBarButtons()
    }
    
    private func setupGradientView() {
        let gradientView = GradientView()
        view.insertSubview(gradientView, at: 0)
        view.embed(gradientView)
    }
    
    private func setupStartButton() {
        startTestButton.backgroundColor = .buttonBackground
        startTestButton.castsShadow = true
    }
    
    private func setupToolBarButtons() {
        sliderButton.backgroundColor = .buttonBackground
        checkmarkButton.backgroundColor = .clear
        octagonButton.backgroundColor = .clear
        
        sliderButton.setImage(.slider, for: .normal)
        checkmarkButton.setImage(.checkmark, for: .normal)
        octagonButton.setImage(.octagon, for: .normal)
        
        sliderButton.setTitle(nil, for: .normal)
        checkmarkButton.setTitle(nil, for: .normal)
        octagonButton.setTitle(nil, for: .normal)
        
        sliderButton.tintColor = .white
        checkmarkButton.tintColor = .buttonTint
        octagonButton.tintColor = .buttonTint
        
    }
}


// MARK: - Color Helper Extension

private extension UIColor {
    class var buttonBackground: UIColor {
        #colorLiteral(red: 0.1278082728, green: 0.2081052959, blue: 0.2657575011, alpha: 1)
    }
    
    class var buttonTint: UIColor {
        #colorLiteral(red: 0.487386167, green: 0.5360325575, blue: 0.5706625581, alpha: 1)
    }
}
