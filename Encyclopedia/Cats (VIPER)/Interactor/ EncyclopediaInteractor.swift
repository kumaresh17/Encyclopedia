//
//   EncyclopediaInteractor.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

class  EncyclopediaInteractor: EncyclopediaInteractorProtocol,PayLoadFormat {
    
    var outputProtocol:EncyclopediaOutputProtocol?
    
    func decodeCatApi() {
        
        var apiModule = CatsAPIModule()
        apiModule.payloadType = .requestMethodGET
        let payload = formatGetPayload(url: .catsUrl, module: apiModule)
        let api = ApiManager()
        api.getCatListInfo(payload: payload ){ result in
            switch result {
            case .success(let data):
              
                guard data.count > 0 else {
                    self.outputProtocol?.errorOccured(message: "no cats")
                    return
                }
                self.outputProtocol?.catsInfoDidFetch(cats: data)
                
            case .failure(let error):
                self.outputProtocol?.errorOccured(message: error.localizedDescription)
            }
        }
            
    }
    
}
