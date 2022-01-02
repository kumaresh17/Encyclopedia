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

       // let placeholderImage = UIImage(named: "placeholder")!
        catNameLabel.text = catName
        catImageView.image = catsImage

    }
    
    
//    func displayData(cats:CatsResponse?) {
//
//        guard let imageUrlStr = cats?.imageurl else {return}
//        guard let imageUrl = URL(string:imageUrlStr) else {return }
////
////        let placeholderImage = UIImage(named: "placeholder")!
////        catImageView.image = placeholderImage
////
//          catImageView.load(url:imageUrl)
////        catName.text = cats?.name
//
//
//        catNameLabel.text = cats?.name
//
//
//    }
    
}

