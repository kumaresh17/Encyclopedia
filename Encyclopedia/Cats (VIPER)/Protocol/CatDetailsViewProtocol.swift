//
//  CatDetailsProtocol.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 02/01/2022.
//

import Foundation

/// View Protocol
protocol CatDetailsViewProtocol: AnyObject
{
    var presenter: EncyclopediaPresenterProtocol? { get set}
    var response: CatsResponse? { get set}
    var router: CatDetailProtocol? {get set}
}

/// Router Protocols and assembling Module
protocol CatDetailProtocol: AnyObject
{
    func assembleModule(response: CatsResponseProtocol, view: CatDetailsViewProtocol)
    func openWebPage(for UrlString: String)
}

