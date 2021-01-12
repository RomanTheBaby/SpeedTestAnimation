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
    
    @IBOutlet private var networkInfoStackView: UIStackView!
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
}


// MARK: - UI Setup

private extension SpeedTestViewController {
    
    func setupAppearance() {
        setupGradientView()
        setupStartButton()
        setupToolBarButtons()
        setupNetworkInfoStack()
        setupSpeedTestViews()
    }
    
    func setupGradientView() {
        let gradientView = GradientView()
        view.insertSubview(gradientView, at: 0)
        view.embed(gradientView)
    }
    
    func setupStartButton() {
        startTestButton.backgroundColor = .buttonBackground
        startTestButton.castsShadow = true
    }
    
    func setupToolBarButtons() {
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
    
    func setupNetworkInfoStack() {
        networkInfoStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        let chinaTelecomNetworkInfo = NetworkInfo(name: "China Telecom", networkType: .wifi)
        let chinaTelecomInfoView = NetworkInfoView.instantiateFromNib()
        chinaTelecomInfoView.backgroundColor = .clear
        chinaTelecomInfoView.translatesAutoresizingMaskIntoConstraints = false
        chinaTelecomInfoView.render(chinaTelecomNetworkInfo)
        networkInfoStackView.addArrangedSubview(chinaTelecomInfoView)
        
        let jinNetworkInfo = NetworkInfo(name: "YunJinTianFu", provider: "Chengdu", networkType: .lan)
        let jinTelecomInfoView = NetworkInfoView.instantiateFromNib()
        jinTelecomInfoView.backgroundColor = .clear
        jinTelecomInfoView.translatesAutoresizingMaskIntoConstraints = false
        jinTelecomInfoView.render(jinNetworkInfo)
        networkInfoStackView.addArrangedSubview(jinTelecomInfoView)
    }
    
    func setupSpeedTestViews() {
        let downloadSpeedView = SpeedInfoView.instantiateFromNib()
        downloadSpeedView.speedType = .download
        downloadSpeedView.speed = nil
        
        let uploadSpeedView = SpeedInfoView.instantiateFromNib()
        uploadSpeedView.speedType = .upload
        uploadSpeedView.speed = nil
        
        let speedTestStackView = UIStackView(arrangedSubviews: [downloadSpeedView, uploadSpeedView])
        speedTestStackView.spacing = 24
        speedTestStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(speedTestStackView)
        
        NSLayoutConstraint.activate([
            speedTestStackView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -16),
            speedTestStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print(">>>speedTestStackView: ", speedTestStackView.frame.height)
        }
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
