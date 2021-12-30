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
    
    func getCatListInfo(payload: CatsHTTPPayloadProtocol, completion: @escaping (Result<catInfoListModel,Error>) -> Void)
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

    }
    
    public convenience init() {
        self.init(urlSession: URLSession.shared)
    }
    
    private func sendRequest() {
        
    }
    
}

extension ApiManager: ApiManagerProtocol {
    
    func getCatListInfo(payload: CatsHTTPPayloadProtocol, completion: @escaping (Result<catInfoListModel,Error>) -> Void) {
        self.sendRequest()
    }
}

