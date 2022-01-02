//
//  EncyclopediaViewProtocol.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 25/12/2021.
//

import Foundation
import UIKit

protocol EncyclopediaViewProtocol :AnyObject {
    
    var presenter: EncyclopediaPresenter? { get set}
    var collectionView : UICollectionView! { get  set }
    func reloadCatsCollectionView()
    
}

protocol EncyclopediaPresenterProtocol {
    
    var view: EncyclopediaViewProtocol? { get set }
    var response: [CatsResponse]? {get}
    var encyclopediaInteractor: EncyclopediaInteractorProtocol? { get set }
    func processCatListApi()
    
    
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
}
