//
//  StartTestButton.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-13.
//

import UIKit

/// Rename to smth like LoadingButton, with ability to set initial text
@IBDesignable final class StartTestButton: RoundedButton {
    
    @IBInspectable var title: String?
    
    
    // MARK: - Private Properties
    
    private lazy var indicatorsStackView: UIStackView = {
        let loadingIndictorViews = [
            RoundedView(color: .white),
            RoundedView(color: .white),
            RoundedView(color: .white)
        ]
        
        let indicatorsStackView = UIStackView(arrangedSubviews: loadingIndictorViews)
        indicatorsStackView.isUserInteractionEnabled = false
        indicatorsStackView.spacing = 8
        indicatorsStackView.axis = .horizontal
        indicatorsStackView.distribution = .fillEqually
        indicatorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return indicatorsStackView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    

    // MARK: - Public Methods
    
    func showLoadingAnimation() {
        setTitle(nil, for: .normal)

        indicatorsStackView.isHidden = false
        
        let loadingIndicatorViews = indicatorsStackView.arrangedSubviews
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            loadingIndicatorViews.enumerated().forEach { index, subview in
                let nextView = index < loadingIndicatorViews.count - 1 ? loadingIndicatorViews[index + 1] : loadingIndicatorViews[0]
                animate(view: subview, to: nextView.center)
                
            }
        }
    }
    
    func stopLoadingAnimation() {
        setTitle(title, for: .normal)
        
        indicatorsStackView.isHidden = true
        indicatorsStackView.arrangedSubviews.forEach {
            $0.layer.removeAllAnimations()
        }
    }
    
}


// MARK: - UI Setup

private extension StartTestButton {
    
    private func setup() {
        indicatorsStackView.isHidden = true
        addSubview(indicatorsStackView)
        
        NSLayoutConstraint.activate([
            indicatorsStackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: indicatorsStackView.arrangedSubviews[0].heightAnchor),
            indicatorsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorsStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
        ])
    }
    
}


// MARK: - Animation Configuration

private extension StartTestButton {
    /// Animates `view` from center to `endPoint`
    private func animate(view: UIView, to endPoint: CGPoint) {
        let animationPath = UIBezierPath()
        
        let startPoint = view.center
        animationPath.move(to: startPoint)
        
        if startPoint.x < endPoint.x {
            animationPath.addLine(to: endPoint)
        } else {
            animationPath.addQuadCurve(to: endPoint, controlPoint: CGPoint(x: abs(startPoint.x - endPoint.x) / 2,
                                                                           y: startPoint.y + bounds.height / 2.5))
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = animationPath.cgPath;

        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = 1.0
        animation.repeatCount = .infinity
        animation.timingFunction = .init(name: .easeInEaseOut)

        view.layer.add(animation, forKey: "loading_indicator")
    }
}
