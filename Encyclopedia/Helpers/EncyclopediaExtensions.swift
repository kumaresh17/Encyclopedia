//
//  EncyclopediaExtensions.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 25/12/2021.
//

import Foundation
import UIKit

/// A Helper to remove view from the superview
extension UIView {
    func remove() {
        self.removeFromSuperview()
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

/// Make CollectionView Cell to use resuable identifier protocol, avoiding writing hard coded identifiers
extension UICollectionViewCell: CatsReusableIdentifier{}


/// An image view extension to download image
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
