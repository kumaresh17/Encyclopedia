//
//  ApiManager.swift
//  Encyclopedia
//
//  Created by kumaresh shrivastava on 30/12/2021.
//

import Foundation
import UIKit


protocol ApiServiceProtocol :AnyObject {
    var urlSession: URLSessionProtocol { get }
}

/// APIManager Protocol
protocol ApiManagerProtocol: AnyObject {
    
    func getCatListInfo(payload: CatsHTTPPayloadProtocol, completion: @escaping (Result<catInfo,Error>) -> Void)
}


/// Network status
enum ReachabilityStatus {
    case unknown
    case disconnected
    case connected
}

class ApiManager: ApiServiceProtocol {
    
    /// URLSession used for query
    var urlSession: URLSessionProtocol
    
    var task: URLSessionDataTask?
    
    private let networkReachability: NetworkReachabilityManager?
    private(set) var reachabilityStatus: ReachabilityStatus

    
    init (urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
        self.networkReachability = NetworkReachabilityManager()
        self.reachabilityStatus = .unknown
        beginListeningNetworkReachability()
    }
    
    deinit {
        self.networkReachability?.stopListening()
    }
    
    
    /*
     Reachability
     
     - Start the reachability
     - To checek network status
     */
    private func beginListeningNetworkReachability() {
        networkReachability?.listener = { status in
            switch status {
            case .unknown: self.reachabilityStatus = .unknown
            case .notReachable:
                self.reachabilityStatus = .disconnected
                self.showErrorForNoNetwork()
            case .reachable(.ethernetOrWiFi), .reachable(.wwan): self.reachabilityStatus = .connected
            }
        }
        networkReachability?.startListening()
    }
    /*
     Show Alert message on no network connection
     */
    private func showErrorForNoNetwork()  {
        task?.suspend()
        DispatchQueue.main.async {
            AlertViewController.showAlert(withTitle: alertTitle, message: networkError)
        }
    }
    
    public convenience init() {
        self.init(urlSession: URLSession.shared)
    }
    
    private func sendRequest<T:Codable>(payLoad:CatsHTTPPayloadProtocol, completion: @escaping (Result<T,Error>) -> Void) {
        
        if let requestUrl =  payLoad.url {
            var urlRequest = URLRequest(url: requestUrl)
            guard let headers = payLoad.headers else {
                fatalError("There must be headers")
            }
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            urlRequest.httpMethod = payLoad.type?.httpMethod()
            
            task = urlSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    return
                }
                var result: Result<T, Error>
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    result = .success(response)
                } catch let error {
                    result = .failure(error)
                }
                DispatchQueue.main.async {
                    completion(result)
                }
            })
            
            task?.resume()
            
        }
    }
    
}

extension ApiManager: ApiManagerProtocol {
    
    /**
     Retrieve the cat list
     - Parameter id:  Payload protocol, containing payload data
     - Parameter completion: Result of api call
     */
    
    func getCatListInfo(payload: CatsHTTPPayloadProtocol, completion: @escaping (Result<catInfo,Error>) -> Void) {
        self.sendRequest(payLoad:payload, completion:completion)
    }
}

