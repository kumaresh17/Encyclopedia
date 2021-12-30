//
//  ViewController.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 23/12/2021.
//

import UIKit

class EncyclopediaViewController: UIViewController,EncyclopediaViewProtocol,UICollectionViewDelegate {

    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    
   @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //resultsTableController = ResultsTableController()
        //resultsTableController.suggestedSearchDelegate = self // So we can be notified when a suggested search token is selected.
        
        searchController = UISearchController()
        //searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = NSLocalizedString("Enter a cat name", comment: "")
        searchController.searchBar.returnKeyType = .done

        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
            
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
     
        // Monitor when the search controller is presented and dismissed.
        //searchController.delegate = self

        // Monitor when the search button is tapped, and start/end editing.
        //searchController.searchBar.delegate = self
        
        /** Specify that this view controller determines how the search controller is presented.
            The search controller should be presented modally and match the physical size of this view controller.
        */
       definesPresentationContext = true

    }
    
}

// MARK: - Extension for UICollectionView DataSource
extension EncyclopediaViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 55
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: EncyclopediaCollectionCellView.reuseIdentifier,for: indexPath) as! EncyclopediaCollectionCellView
        cell.backgroundColor = UIColor.white
        cell.configureCatCell()
        return cell
    }
    
}


