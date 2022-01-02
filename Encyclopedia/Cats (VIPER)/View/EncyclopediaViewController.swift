//
//  ViewController.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 23/12/2021.
//

import UIKit

class EncyclopediaViewController: UIViewController,EncyclopediaViewProtocol{
   
    /// Search controller to help us with filtering.
   private var searchController: UISearchController!
    var presenter: EncyclopediaPresenter?
    /// An `AsyncFetcher` that is used to asynchronously fetch `DisplayData` objects.
     let asyncFetcher = AsyncFetcher()
     var catResponseData: [CatsResponse]?
     var resultFilterData: [CatsResponse]?
    
   @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSearchController()
        presenter?.processCatListApi()
        
    }
    
   private func setUpSearchController() {
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = NSLocalizedString("Enter a cat name", comment: "")
        searchController.searchBar.returnKeyType = .done
        
        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Monitor when the search controller is presented and dismissed.
        searchController.delegate = self
        collectionView.prefetchDataSource = self
        definesPresentationContext = true
    }
    
    func reloadCatsCollectionView() {
        catResponseData = (presenter?.response)
        collectionView.reloadData()
    }
    
}

// MARK: - Extension for UICollectionView DataSource
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
     
        if let catData = useThisDataForCollectionView?[indexPath.item] {
                        
            cell.representedIdentifier = catData.identifier
            guard let imageUrlString = catData.imageurl else {
                cell.displayData(catsImage: nil, catName: catData.name)
                return cell}
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






