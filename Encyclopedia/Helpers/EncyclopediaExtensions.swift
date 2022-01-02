//
//  EncyclopediaExtensions.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 25/12/2021.
//

import Foundation
import UIKit
/// An image view extension to download image
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

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
