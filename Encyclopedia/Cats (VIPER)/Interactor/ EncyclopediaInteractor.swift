//
//   EncyclopediaInteractor.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

struct  EncyclopediaInteractor: EncyclopediaInteractorProtocol,PayLoadFormat {
    
    func decodeCatApi() {
        
        var apiModule = CatsAPIModule()
        apiModule.payloadType = .requestMethodGET
        let payload = formatGetPayload(url: .catsUrl, module: apiModule)
        let api = ApiManager()
        api.getCatListInfo(payload: payload ){ result in
            switch result {
            case .success(let data):
               print("sucess")
            case .failure(let error):
                print("fail")
            }
        }
            
    }
    
}
