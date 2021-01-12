//
//  NibInstantiatable.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import UIKit


protocol NibInstantiatable {
    static func instantiateFromNib() -> Self
}


extension NibInstantiatable where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static func instantiateFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Could not instantiate view from nib with name \(String(describing: self)).")
        }

        return view
    }
}
