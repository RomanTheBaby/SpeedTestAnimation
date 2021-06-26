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
        case result
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
                chartView.isHidden = true
                chartView.removeCharts()
                emitterView.isHidden = false
                emitterView.currentSpeed = nil
                uploadSpeedView.speed = nil
                downloadSpeedView.speed = nil
                
                UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) { [self] in
                    showPacketsInfoView(false)
                    startTestButton.transform = .identity
                    speedTestStackView.transform = .identity
                    networkInfoStackView.transform = .identity
                }.startAnimation()
                
                startTestButton.stopLoadingAnimation()
                
                emitterView.udpate(sideEmissionsEnabled: true, centerEmissionsEnabled: true)
                
            case .result:
                chartView.isHidden = false
                chartView.drawCharts()
                emitterView.stopTestSimulation()
                emitterView.isHidden = true
                uploadSpeedView.speed = 65.25
                
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4,
                                                               delay: 0,
                                                               options: .transitionFlipFromTop) { [self] in
                    speedTestStackView.transform = speedTestStackView.transform.translatedBy(x: 0, y: -(speedTestStackView.frame.origin.y - logoStackView.frame.maxY - 36))
                }
                
            case .testDownload:
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4,
                                                               delay: 0,
                                                               options: .transitionFlipFromTop) { [self] in
                    showPacketsInfoView(true)
                }

                let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) { [self] in
                    startTestButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
                
                let startTestButtonHeight = view.frame.width * 0.3
                
                animator.addAnimations { [self] in
                    speedTestStackView.transform = CGAffineTransform(translationX: 0, y: startTestButtonHeight / 2)
                    networkInfoStackView.transform = CGAffineTransform(translationX: 0, y: startTestButtonHeight / 2)
                }
                
                animator.startAnimation()

                emitterView.udpate(sideEmissionsEnabled: true, centerEmissionsEnabled: false)
                emitterView.simulateTest(.download)
                
            case .testUpload:
                downloadSpeedView.speed = 205.5
                emitterView.udpate(sideEmissionsEnabled: false, centerEmissionsEnabled: true)
                emitterView.simulateTest(.upload)
                
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet private var startTestButton: StartTestButton!
    
    @IBOutlet private var packetsInfoStackView: UIStackView!
    @IBOutlet private var logoStackView: UIStackView!
    @IBOutlet private var sliderButton: RoundedButton!
    @IBOutlet private var checkmarkButton: RoundedButton!
    @IBOutlet private var octagonButton: RoundedButton!
    @IBOutlet private var chartView: ChartView!
    
    private lazy var downloadSpeedView: SpeedInfoView = {
        let downloadSpeedView = SpeedInfoView.instantiateFromNib()
        downloadSpeedView.speedType = .download
        downloadSpeedView.speed = nil
        
        return downloadSpeedView
    }()
    
    private lazy var uploadSpeedView: SpeedInfoView = {
        let uploadSpeedView = SpeedInfoView.instantiateFromNib()
        uploadSpeedView.speedType = .upload
        uploadSpeedView.speed = nil
        
        return uploadSpeedView
    }()
    
    private lazy var speedTestStackView: UIStackView = {
        let speedTestStackView = UIStackView(arrangedSubviews: [downloadSpeedView, uploadSpeedView])
        speedTestStackView.spacing = 24
        speedTestStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return speedTestStackView
    }()
    
    private lazy var networkInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 6
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var emitterView: SpeedTestEmitterView = {
        let emitterView = SpeedTestEmitterView(frame: .zero)
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
        setupPacketsInfoView()
        
        emitterView.iconImageView.isHidden = true
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
        view.addSubview(networkInfoStackView)
        
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
        
        NSLayoutConstraint.activate([
            networkInfoStackView.bottomAnchor.constraint(equalTo: startTestButton.topAnchor, constant: -36),
            networkInfoStackView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 8),
            networkInfoStackView.centerXAnchor.constraint(equalTo: startTestButton.centerXAnchor),
            networkInfoStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.52),
        ])
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
        view.addSubview(speedTestStackView)
        
        NSLayoutConstraint.activate([
            speedTestStackView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -16),
            speedTestStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setupPacketsInfoView() {
        showPacketsInfoView(false)
    }
}


// MARK: - Helper Methods

private extension SpeedTestViewController {
    func showPacketsInfoView(_ shouldShow: Bool) {
        packetsInfoStackView.transform = shouldShow ? .identity : CGAffineTransform(translationX: 0, y: -20)
        packetsInfoStackView.alpha = shouldShow ? 1 : 0
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

        case .result:
            return .idle
            
        case .testDownload:
            return .testUpload
            
        case .testUpload:
            return .result
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
