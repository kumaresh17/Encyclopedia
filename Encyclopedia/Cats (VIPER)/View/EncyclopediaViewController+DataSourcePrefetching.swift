//
//  EncyclopediaViewController+DataSourcePrefetching.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 02/01/2022.
//


import UIKit

extension EncyclopediaViewController: UICollectionViewDataSourcePrefetching {
    
    /// - Tag: Prefetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        for indexPath in indexPaths {            
            let useThisDataForCollectionView = resultFilterData ?? catResponseData
            let model = useThisDataForCollectionView?[indexPath.item]
            
            guard let imageUrlString = model?.imageurl else {return}
            let imageUrl = URL(string:imageUrlString)
            asyncFetcherP!.fetchAsync((model?.identifier)!, ImageURl: imageUrl!, completion: nil)
        }
    }

    /// - Tag: CancelPrefetching
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // Cancel any in-flight requests for data for the specified index paths.
        for indexPath in indexPaths {
            let useThisDataForCollectionView = resultFilterData ?? catResponseData
            let model = useThisDataForCollectionView?[indexPath.item]
            asyncFetcherP!.cancelFetch((model?.identifier)!)
        }
    }
}
