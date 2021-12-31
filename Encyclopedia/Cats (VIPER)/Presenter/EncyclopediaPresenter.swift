//
//  EncyclopediaPresenter.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

struct EncyclopediaPresenter :EncyclopediaPresenterProtocol {
    
    var view: EncyclopediaViewProtocol? 
    var encyclopediaInteractor: EncyclopediaInteractorProtocol? 
    
    func processCatListApi() {
          
        encyclopediaInteractor?.decodeCatApi()

    }
    
}
