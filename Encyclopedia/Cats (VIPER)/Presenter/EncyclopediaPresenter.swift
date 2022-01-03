//
//  EncyclopediaPresenter.swift
//  Encyclopedia
//
//  Created by  on 30/12/2021.
//

import Foundation

class EncyclopediaPresenter :EncyclopediaPresenterProtocol {
    
    var view: EncyclopediaViewProtocol?
    var response: [CatsResponse]?
    var router: EncyclopediaRouterProtocol?
    var encyclopediaInteractor: EncyclopediaInteractorProtocol? 
    
    func processCatListApi() {
        encyclopediaInteractor?.decodeCatApi()
    }
    
    func pushToDetailView(detailView: CatDetailsViewProtocol, forResponse: CatsResponse?) {
        guard let result = forResponse else { return }
        router?.showDetailView(detailView: detailView, catResposne:result)
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
        view?.reloadCatsCollectionView()
    }
    func errorOccured(message: String) {
        AlertViewController.showAlert(withTitle: alertTitle, message: message)
    }
}
