//
//  CatsReusableIdentifier.swift
//  Encyclopedia
//
//  Created by  on 25/12/2021.
//

import Foundation

/// Protocol to use resuse identifier
protocol CatsReusableIdentifier {
    static var reuseIdentifier: String { get }
}

extension CatsReusableIdentifier {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
