//
//  EncyclopediaPresenter.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

class EncyclopediaPresenter :EncyclopediaPresenterProtocol {
    
    var view: EncyclopediaViewProtocol?
    var response: [CatsResponse]?
    var encyclopediaInteractor: EncyclopediaInteractorProtocol? 
    
    func processCatListApi() {
          
        encyclopediaInteractor?.decodeCatApi()

    }
    
}

/**
 var name: String?
 var imageurl: String?
 var temperament: String?
 var energylevel: String?
 var externalLinkToWikipedia: String?
 */
// MARK: - Presenter to view communcation
extension EncyclopediaPresenter: EncyclopediaOutputProtocol {
    
    func catsInfoDidFetch(cats: catInfo) {
        //print(cats[0].image?.url?.description)
        self.response = [CatsResponse]()
        _ = cats.map {
            let response = CatsResponse(name: $0.name, imageurl: $0.image?.url?.description, temperament: $0.temperament, energylevel: $0.energyLevel, externalLinkToWikipedia: $0.wikipediaURL?.description,identifier: UUID())
            self.response?.append(response)
        }
        view?.collectionView.reloadData()
    }
    func errorOccured(message: String) {
       print("fail")
    }
}
