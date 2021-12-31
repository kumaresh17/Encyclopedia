//
//  EncyclopidiaRouter.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 31/12/2021.
//

import Foundation

struct EncyclopidiaRouter: EncyclopediaRouterProtocol {
    
    var presenter: EncyclopediaPresenterProtocol?
    
    /// Build  the VIPER modules here
    func assembleModule(view: EncyclopediaViewProtocol) {
        
        var presenter = EncyclopediaPresenter()
        let interactor = EncyclopediaInteractor()
        //let router = EncyclopidiaRouter()
        
        presenter.view = view
        presenter.encyclopediaInteractor = interactor
        view.presenter = presenter
        
        
        
        
    }
}
