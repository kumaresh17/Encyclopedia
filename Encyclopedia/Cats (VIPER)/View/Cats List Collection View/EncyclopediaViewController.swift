//
//  ViewController.swift
//  Encyclopedia
//
//  Created by  on 23/12/2021.
//

import UIKit

class EncyclopediaViewController: UIViewController,EncyclopediaViewProtocol{
   
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    var presenter: EncyclopediaPresenter?
    /// An `AsyncFetcher protocol` that is used to asynchronously fetch `DisplayImage` objects.
    var asyncFetcherP: AsynFetcherProtocol?
    var catResponseData: [CatsResponse]?
    var resultFilterData: [CatsResponse]?
    
   @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        asyncFetcherP = AsyncFetcher()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cell = sender as? EncyclopediaCollectionCellView else { return }
        guard let index = collectionView.indexPath(for: cell)?.item else { return }
        guard let detailView = segue.destination as? CatDetailViewController else { return }
        let useThisDataForCollectionView = resultFilterData ?? catResponseData
        let catData = useThisDataForCollectionView?[index]
        // View asking the presenter for pushing another view
        presenter?.pushToDetailView(detailView: detailView, forResponse: catData)
    }
}
