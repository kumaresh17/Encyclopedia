//
//  EncyclopediaViewProtocol.swift
//  Encyclopedia
//
//  Created by  on 25/12/2021.
//

import Foundation
import UIKit

protocol EncyclopediaViewProtocol :AnyObject {
    
    var presenter: EncyclopediaPresenter? { get set}
    var collectionView : UICollectionView! { get  set }
    var asyncFetcherP: AsynFetcherProtocol? { get }
    var catResponseData: [CatsResponseProtocol]? { get set }
    func searchCats(catText: String) -> [CatsResponseProtocol]?
    func reloadCatsCollectionView()
    
}

protocol EncyclopediaPresenterProtocol {
    
    var view: EncyclopediaViewProtocol? { get set }
    var response: [CatsResponse]? {get}
    var router: EncyclopediaRouterProtocol? { get }
    var encyclopediaInteractor: EncyclopediaInteractorProtocol? { get set }
    func processCatListApi()
   // func pushToDetailView(detailView: CatDetailsViewProtocol, forIndex: Int)
    func pushToDetailView(detailView: CatDetailsViewProtocol, forResponse: CatsResponseProtocol?)
    
    
}

/// Interactor to Presenter Output Protocol
protocol EncyclopediaOutputProtocol {
    
    func catsInfoDidFetch(cats: catInfo)
    func errorOccured(message: String)
}

protocol EncyclopediaInteractorProtocol {
    
    var outputProtocol:EncyclopediaOutputProtocol? { get }
    func decodeCatApi()
    
}

protocol EncyclopediaRouterProtocol {
    
    var presenter: EncyclopediaPresenterProtocol? {get set}
    func assembleModule(view: EncyclopediaViewProtocol)
    func showDetailView(detailView: CatDetailsViewProtocol, catResposne: CatsResponseProtocol)
}
