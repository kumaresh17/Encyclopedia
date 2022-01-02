//
//  EncyclopediaCollectionCellView.swift
//  Encyclopedia
//
//  Created by  on 25/12/2021.
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

    func configureCellData(catData: CatsResponse,asyncFetcher: AsynFetcherProtocol) {
       
        representedIdentifier = catData.identifier
        guard let imageUrlString = catData.imageurl else {
            displayData(catsImage: nil, catName: catData.name)
            return }
        let imageUrl = URL(string:imageUrlString)

        // Check if the `asyncFetcher` has already fetched data for the specified identifier.
        if let fetchedData = asyncFetcher.fetchedData(for: catData.identifier!) {
            // The data has already been fetched and cached; use it to configure the cell.
            displayData(catsImage: fetchedData.imageCat, catName: catData.name)
        } else {
            // There is no data available; clear the cell until we've fetched data.
            displayData(catsImage: nil, catName: nil)

            // Ask the `asyncFetcher` to fetch data for the specified identifier.
            asyncFetcher.fetchAsync(catData.identifier!,ImageURl: imageUrl!) { [weak self] fetchedData in
                DispatchQueue.main.async {
                    /*
                     The `asyncFetcher` has fetched data for the identifier. Before
                     updating the cell, check if it has been recycled by the
                     collection view to represent other data.
                     */
                    guard self?.representedIdentifier == catData.identifier else { return }

                    // Configure the cell with the fetched image.
                    self?.displayData(catsImage: fetchedData!.imageCat, catName: catData.name)
                }
            }
        }
    }
}


