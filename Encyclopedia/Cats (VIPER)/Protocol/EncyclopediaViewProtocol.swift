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
    
}

protocol EncyclopediaPresenterProtocol {
    
    var view: EncyclopediaViewProtocol? { get set }
    var encyclopediaInteractor: EncyclopediaInteractorProtocol? { get set }
    func processCatListApi()
    
    
}

protocol EncyclopediaInteractorProtocol {
    
    func decodeCatApi()
    
}

protocol EncyclopediaRouterProtocol {
    
    var presenter: EncyclopediaPresenterProtocol? {get set}
    func assembleModule(view: EncyclopediaViewProtocol)
}
