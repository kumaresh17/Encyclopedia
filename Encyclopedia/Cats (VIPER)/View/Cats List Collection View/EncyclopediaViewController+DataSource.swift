//
//  EncyclopediaViewController+DataSource.swift
//  Encyclopedia
//
//  Created by on 03/01/2022.
//

import UIKit

extension EncyclopediaViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         let useThisDataForCollectionView = resultFilterData ?? catResponseData
         guard let data = useThisDataForCollectionView else { return 0 }
         return data.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EncyclopediaCollectionCellView.reuseIdentifier, for: indexPath) as? EncyclopediaCollectionCellView else {
            fatalError("no cell formed")
        }
                
        let useThisDataForCollectionView = resultFilterData ?? catResponseData
        
        guard let catData = useThisDataForCollectionView?[indexPath.item] else { return cell }
            cell.configureCellData(catData: catData,asyncFetcher: asyncFetcherP!)
        
        return cell
    }
    
}

