//
//  EncyclopediaViewProtocol.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 25/12/2021.
//

import Foundation
import UIKit

protocol EncyclopediaViewProtocol :AnyObject {
    var collectionView : UICollectionView! { get  set }
    
}

protocol EncyclopediaPresenterProtocol {
    
    var  encyclopediaInteractor: EncyclopediaInteractor? { get set }
    func processCatListApi()
    
    
}

protocol  EncyclopediaInteractorProtocol {
    
    func decodeCatApi()
    
}
