//
//  StartTestButton.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-13.
//

import UIKit

/// Rename to smth like LoadingButton, with ability to set initial text
final class StartTestButton: RoundedButton {
    
    private lazy var loadingIndictorViews: [UIView] = [
        RoundedView(color: .white),
        RoundedView(color: .white),
        RoundedView(color: .white),
    ]
    

    // MARK: - Public Methods
    
    func showLoadingAnimation() {
        setTitle(nil, for: .normal)

        
        let indicatorsStackView = UIStackView(arrangedSubviews: loadingIndictorViews)
        indicatorsStackView.spacing = 8
        indicatorsStackView.axis = .horizontal
        indicatorsStackView.distribution = .fillEqually
        indicatorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicatorsStackView)
        
        NSLayoutConstraint.activate([
            indicatorsStackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: indicatorsStackView.arrangedSubviews[0].heightAnchor),
            indicatorsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorsStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
        ])
        
        relocateLoadingIndicatorViews(indicatorsStackView.arrangedSubviews)
    }
    
    
    // MARK: - Private Methods
    
    /// Animates `view` from center to `endPoint`
    private func animate(view: UIView, to endPoint: CGPoint) {
        let animationPath = UIBezierPath()
        
        let startPoint = view.center
        animationPath.move(to: startPoint)
        
        if startPoint.x < endPoint.x {
            animationPath.addLine(to: endPoint)
        } else {
            animationPath.addQuadCurve(to: endPoint, controlPoint: CGPoint(x: abs(startPoint.x - endPoint.x) / 2,
                                                                           y: startPoint.y + bounds.height / 3))
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
    
    private func relocateLoadingIndicatorViews(_ views: [UIView]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            animate(view: views[0], to: views[1].center)
            animate(view: views[1], to: views[2].center)
            animate(view: views[2], to: views[0].center)
        }
    }
}
