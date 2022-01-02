//
//  CatDetailRouter.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 02/01/2022.
//

import Foundation
import UIKit

final class CatDetailRouter: CatDetailProtocol {
    
    func assembleModule(response: CatsResponseProtocol, view: CatDetailsViewProtocol) {
        
        let router = CatDetailRouter()
        let view = view as? CatDetailViewController
        view!.response = response as? CatsResponse
        view?.router = router
    }
    
    func openWebPage(for UrlString: String) {
        if let url = URL(string: UrlString) {
            UIApplication.shared.open(url)
        }
    }
}
