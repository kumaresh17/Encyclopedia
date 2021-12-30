//
//  EncyclopediaCollectionCellView.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 25/12/2021.
//

import UIKit

final class EncyclopediaCollectionCellView: UICollectionViewCell {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catName: UILabel!
    
    
    func configureCatCell()  {
        
        let imageUrl = URL(string: "https://cdn2.thecatapi.com/images/ZfqxG7ZHH.jpg")
        catImageView.load(url:imageUrl! )
        catName.text = "cat1"
        
    }
    
}
