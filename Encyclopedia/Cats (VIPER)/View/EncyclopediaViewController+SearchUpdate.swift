//
//  EncyclopediaViewController+SearchUpdate.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 02/01/2022.
//

import UIKit

extension EncyclopediaViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        resultFilterData = nil
        if searchController.searchBar.text!.isEmpty {
            resultFilterData = nil
            collectionView.reloadData()
        } else {
            let searchResults = catResponseData

            // Strip out all the leading and trailing spaces.
            let whitespaceCharacterSet = CharacterSet.whitespaces
            let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet).lowercased()
            let searchItems = strippedString.components(separatedBy: " ") as [String]
            
            // Filter results down by cat name,
            var filtered = searchResults
            var curTerm = searchItems[0]
            var idx = 0
            while curTerm != "" {
                filtered = filtered?.filter {
                    $0.name!.lowercased().contains(curTerm)
                }
                idx += 1
                curTerm = (idx < searchItems.count) ? searchItems[idx] : ""
            }
            // Apply the filtered results to the collection view.
                resultFilterData = filtered!
                collectionView.reloadData()
        }
    }
    
}

extension EncyclopediaViewController: UISearchControllerDelegate{
    
    func willDismissSearchController(_ searchController: UISearchController) {
        resultFilterData = nil
        collectionView.reloadData()
    }
}
