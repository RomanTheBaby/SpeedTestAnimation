//
//  SpeedTestViewController.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit

final class SpeedTestViewController: UIViewController {
    
    
    // MARK: - State
    
    fileprivate enum State: String {
        case defferingTest
        case idle
        case testDownload
        case testUpload
    }
    
    
    // MARK: - Private Properties
    
    private var state: State = .idle {
        didSet {
            switch state {
            case .defferingTest:
                startTestButton.showLoadingAnimation()
                
            case .idle:
                startTestButton.stopLoadingAnimation()
                emitterView.isCenterEmissionEnabled = true
                emitterView.isSideEmissionEnabled = true
                
            case .testDownload:
                emitterView.isCenterEmissionEnabled = false
                emitterView.isSideEmissionEnabled = true
                
            case .testUpload:
                emitterView.isCenterEmissionEnabled = true
                emitterView.isSideEmissionEnabled = false
                
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet private var startTestButton: StartTestButton!
    
    @IBOutlet private var logoStackView: UIStackView!
    @IBOutlet private var sliderButton: RoundedButton!
    @IBOutlet private var checkmarkButton: RoundedButton!
    @IBOutlet private var octagonButton: RoundedButton!
    
    @IBOutlet private var networkInfoStackView: UIStackView!
    
    private lazy var emitterView: EmitterView = {
        let emitterView = EmitterView(frame: .zero)
        emitterView.translatesAutoresizingMaskIntoConstraints = false
        
        return emitterView
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        startTestButton.addTarget(self, action: #selector(handleStartButtomTap(_:)), for: .touchUpInside)
    }
    
}


// MARK: - UI Setup

private extension SpeedTestViewController {
    
    func setupAppearance() {
        setupGradientView()
        setupStartButton()
        setupToolBarButtons()
        setupNetworkInfoStack()
        setupEmitterView()
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
    
    func setupEmitterView() {
        view.addSubview(emitterView)

        /// For simplicity emitter view was made a square.
        NSLayoutConstraint.activate([
            emitterView.topAnchor.constraint(equalTo: logoStackView.bottomAnchor, constant: 8),
            emitterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emitterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            emitterView.widthAnchor.constraint(equalTo: emitterView.heightAnchor),
        ])
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
    }
}


// MARK: - Action Handling

private extension SpeedTestViewController {
    @objc func handleStartButtomTap(_ sender: UIButton) {
        state = state.next
    }
}


// MARK: - State Helper Extension

extension SpeedTestViewController.State {
    var next: Self {
        switch self {
        case .defferingTest:
            return .testDownload
            
        case .idle:
            return .defferingTest

        case .testDownload:
            return .testUpload
            
        case .testUpload:
            return .idle
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
