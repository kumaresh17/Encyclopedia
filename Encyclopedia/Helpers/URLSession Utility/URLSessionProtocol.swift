//
//  URLSessionProtocol.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol: AnyObject {
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
    
}

extension URLSession: URLSessionProtocol { }
