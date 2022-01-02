//
//  EncyclopediaCollectionCellView.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 25/12/2021.
//

import UIKit

final class EncyclopediaCollectionCellView: UICollectionViewCell {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    
    /// The `UUID` for the data this cell is presenting.
    var representedIdentifier: UUID?
    
    
    func displayData(catsImage: UIImage?, catName:String?) {
        
        if catsImage == nil {
            catImageView.image =  UIImage(named: "placeholder")!
        } else {
            catImageView.image = catsImage
        }
        catNameLabel.text = catName
        
    }
    
}

