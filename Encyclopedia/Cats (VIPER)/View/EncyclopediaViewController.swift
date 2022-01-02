//
//  ViewController.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 23/12/2021.
//

import UIKit

class EncyclopediaViewController: UIViewController,EncyclopediaViewProtocol{
   
    

    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    var presenter: EncyclopediaPresenter?
    /// An `AsyncFetcher` that is used to asynchronously fetch `DisplayData` objects.
    private let asyncFetcher = AsyncFetcher()
    
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
        
        collectionView.prefetchDataSource = self
        definesPresentationContext = true
        presenter?.processCatListApi()
        
    }
    
}

// MARK: - Extension for UICollectionView DataSource
extension EncyclopediaViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         guard let data = presenter?.response else { return 0 }
         return data.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EncyclopediaCollectionCellView.reuseIdentifier, for: indexPath) as? EncyclopediaCollectionCellView else {
            fatalError("no cell formed")
        }
        
        if let catData = presenter?.response?[indexPath.item] {
            
            //cell.displayData(cats: catData)
            
            cell.representedIdentifier = catData.identifier
            guard let imageUrlString = catData.imageurl else {return cell}
            let imageUrl = URL(string:imageUrlString)

            // Check if the `asyncFetcher` has already fetched data for the specified identifier.
            if let fetchedData = asyncFetcher.fetchedData(for: catData.identifier!) {
                // The data has already been fetched and cached; use it to configure the cell.
                cell.displayData(catsImage: fetchedData.imageCat, catName: catData.name)
            } else {
                // There is no data available; clear the cell until we've fetched data.
                cell.displayData(catsImage: nil, catName: nil)

                // Ask the `asyncFetcher` to fetch data for the specified identifier.
                asyncFetcher.fetchAsync(catData.identifier!,ImageURl: imageUrl!) { fetchedData in
                    DispatchQueue.main.async {
                        /*
                         The `asyncFetcher` has fetched data for the identifier. Before
                         updating the cell, check if it has been recycled by the
                         collection view to represent other data.
                         */
                        guard cell.representedIdentifier == catData.identifier else { return }

                        // Configure the cell with the fetched image.
                        cell.displayData(catsImage: fetchedData!.imageCat, catName: catData.name)
                    }
                }
            }
        }
        
        return cell
    }    
}

extension EncyclopediaViewController: UICollectionViewDataSourcePrefetching {
    
    // MARK: UICollectionViewDataSourcePrefetching

    /// - Tag: Prefetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        for indexPath in indexPaths {
            let model = presenter?.response?[indexPath.item]
            let imageUrl = URL(string:(model?.imageurl!)!)
            asyncFetcher.fetchAsync((model?.identifier)!, ImageURl: imageUrl!)
        }
    }

    /// - Tag: CancelPrefetching
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        // Cancel any in-flight requests for data for the specified index paths.
        for indexPath in indexPaths {
            let model = presenter?.response?[indexPath.item]
            asyncFetcher.cancelFetch((model?.identifier)!)
        }
    }
}



