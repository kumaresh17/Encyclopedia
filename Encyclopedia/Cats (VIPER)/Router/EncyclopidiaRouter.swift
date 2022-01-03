//
//  EncyclopidiaRouter.swift
//  Encyclopedia
//
//  Created by  on 31/12/2021.
//

import Foundation

class EncyclopidiaRouter: EncyclopediaRouterProtocol {
    
    var presenter: EncyclopediaPresenterProtocol?
    
    /// Build  the VIPER modules here
    func assembleModule(view: EncyclopediaViewProtocol) {
        
        let presenter = EncyclopediaPresenter()
        let interactor = EncyclopediaInteractor()
        let router = EncyclopidiaRouter()
        
        presenter.view = view
      
        presenter.encyclopediaInteractor = interactor
        view.presenter = presenter
        interactor.outputProtocol = presenter
        presenter.router = router

    }
    
    func showDetailView(detailView: CatDetailsViewProtocol, catResposne: CatsResponseProtocol){
        CatDetailRouter().assembleModule(response: catResposne, view: detailView)
    }
}
