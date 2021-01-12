//
//  NetworkInfoView.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit


final class NetworkInfoView: UIView, NibInstantiatable {
    
    
    // MARK: - Outlets
    
    @IBOutlet private var networkTypeButton: RoundedButton!
    @IBOutlet private var accessoryImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    
    // MARK: - Public Methods
    
    func render(_ networkInfo: NetworkInfo) {
        networkTypeButton.setImage(networkInfo.networkType.image, for: .normal)
        networkTypeButton.layer.borderWidth = 1
        networkTypeButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        accessoryImageView.isHidden = networkInfo.networkType == .wifi
        titleLabel.text = networkInfo.name
        subtitleLabel.text = networkInfo.provider
        subtitleLabel.isHidden = (networkInfo.provider ?? "").isEmpty
    }
}

private extension NetworkInfo.NetworkType {
    var image: UIImage {
        switch self {
        case .lan:
            return .globe
            
        case .wifi:
            return .wifi
        }
    }
}
