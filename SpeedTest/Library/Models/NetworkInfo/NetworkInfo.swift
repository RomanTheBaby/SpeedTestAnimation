//
//  NetworkInfo.swift
//  SpeedTest
//
//  Created by BabyReebeeDude on 2021-01-11.
//

import Foundation


struct NetworkInfo {
    var name: String
    var provider: String? = nil
    var networkType: NetworkType

    enum NetworkType {
        case wifi
        case lan
    }
}
