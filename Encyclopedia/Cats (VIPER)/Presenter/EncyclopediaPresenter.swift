//
//  EncyclopediaPresenter.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

struct EncyclopediaPresenter :EncyclopediaPresenterProtocol {
    
    var  encyclopediaInteractor: EncyclopediaInteractor?
    
    func processCatListApi() {
          
        encyclopediaInteractor?.decodeCatApi()

    }
    
}
