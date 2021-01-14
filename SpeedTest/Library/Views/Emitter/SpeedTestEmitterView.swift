//
//  DownloadTestEmitterView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-14.
//

import UIKit


class SpeedTestEmitterView: EmitterView {

    
    
    // MARK: - Public Properties
    
    
    var currentSpeed: Double = 0 {
        didSet {
            UIView.transition(with: resultLabel,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { [self] in
                                resultLabel.text = String(format: "%.2f", currentSpeed)
                              })
        }
    }
    
    
    // MARK: - Private Properties
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.text = "-"
        resultLabel.textColor = .white
        resultLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.layer.zPosition = 1
        
        return resultLabel
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private var timer: Timer?
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    
    // MARK: - UI Setup
    
    private func setup() {
        setupResultLabel()
        setupIconImageView()
    }
    
    private func setupResultLabel() {
        addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    
    // MARK: - Private Methods
    
    func simulateTest(_ testType: SpeedTestType) {
        stopTestSimulation()
        
        iconImageView.image = testType.image
        iconImageView.tintColor = testType.imageTintColor
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.currentSpeed += Double.random(in: 0..<4)
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [self] in
            resultLabel.transform = CGAffineTransform(translationX: 0, y: frame.height / 2.2)
        }
    }
    
    func stopTestSimulation(resetPosition: Bool = true) {
        timer?.invalidate()
        
        iconImageView.image = nil
        
        guard resetPosition else { return }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveEaseIn) { [self] in
            resultLabel.transform = .identity
        }
    }
    
    override func udpate(sideEmissionsEnabled: Bool, centerEmissionsEnabled: Bool) {
        emitters.forEach { source, emitterLayer in
            switch source {
            case .center:
                if centerEmissionsEnabled {
                    emitterLayer.velocity = sideEmissionsEnabled ? 1 : 5
                    emitterLayer.lifetime = sideEmissionsEnabled ? 1 : 0.2
                    emitterLayer.birthRate = sideEmissionsEnabled ? 1 : 10
                    layer.addSublayer(emitterLayer)
                } else {
                    emitterLayer.removeFromSuperlayer()
                }
                
            default:
                if sideEmissionsEnabled {
                    /// Move to SpeedResrEmiiterView
                    emitterLayer.velocity = centerEmissionsEnabled ? 1 : 5
                    emitterLayer.lifetime = centerEmissionsEnabled ? 1 : 0.2
                    emitterLayer.birthRate = centerEmissionsEnabled ? 1 : 8
                    layer.addSublayer(emitterLayer)
                } else {
                    emitterLayer.removeFromSuperlayer()
                }
            }
        }
    }
}
