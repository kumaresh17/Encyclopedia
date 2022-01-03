//
//  EncyclopediaViewController+SearchUpdate.swift
//  Encyclopedia
//
//  Created by  on 02/01/2022.
//

import UIKit

extension EncyclopediaViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        resultFilterData = nil
        if searchController.searchBar.text!.isEmpty {
            resultFilterData = nil
            collectionView.reloadData()
        } else {
            resultFilterData =  searchCats(catText:searchController.searchBar.text!)
            guard resultFilterData != nil else { return }
                collectionView.reloadData()
        }
    }
    
    func searchCats(catText: String) -> [CatsResponseProtocol]? {
        resultFilterData = nil
        let searchResults = catResponseData
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = catText.trimmingCharacters(in: whitespaceCharacterSet).lowercased()
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Filter results down by cat name,
        var filtered:[CatsResponseProtocol]? = searchResults
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
        guard let filterData = filtered else {return nil}
        resultFilterData = filterData
        return resultFilterData
    }
    
}

extension EncyclopediaViewController: UISearchControllerDelegate{
    
    func willDismissSearchController(_ searchController: UISearchController) {
        resultFilterData = nil
        collectionView.reloadData()
    }
}
