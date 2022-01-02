//
//  EncyclopediaPayLoad.swift
//  Encyclopedia
//
//  Created by  on 30/12/2021.
//

import Foundation



protocol PayLoadFormat {
    func formatGetPayload(url: CatsHTTPSUrl, module: CatsAPIModule) -> CatsHTTPPayloadProtocol
}

extension PayLoadFormat  {
    
    func formatGetPayload(url: CatsHTTPSUrl, module: CatsAPIModule) -> CatsHTTPPayloadProtocol{
        var payload = EncyclopediaPayLoad(url: url,payload: module)
        payload.headers = Dictionary<String, String>()
        payload.addHeader(name: CatsHTTPHeaderType.contentType.rawValue, value: CatsHTTPMimeType.applicationJSON.rawValue)
        return payload
    }
}

protocol CatsHTTPPayloadProtocol {
    var type: CatsHTTPPayloadType? { get }
    var headers: Dictionary<String, String>? { get set }
    var url: URL? {get}
}

struct EncyclopediaPayLoad: CatsHTTPPayloadProtocol {
    
    var type: CatsHTTPPayloadType?
    var headers: Dictionary<String, String>?
    var url: URL?
    fileprivate init(url: CatsHTTPSUrl, payload: CatsAPIModule) {
        self.type = payload.payloadType
        var components = URLComponents()
        components.scheme = CatsSchemeType.schemeType.rawValue
        components.host = url.rawValue
        components.path = "/v1/breeds/"
        
        self.url = components.url
    }
    fileprivate mutating func addHeader(name: String, value: String) {
        headers?[name] = value
    }
    
}

enum CatsSchemeType: String{
    case schemeType  = "https"
}


enum CatsHTTPMimeType: String {
    case applicationJSON = "application/json; charset=utf-8"
}
enum CatsHTTPHeaderType: String{
    case contentType    = "Content-Type"
}

enum CatsHTTPMethod: String {
    case get
    case put
}

enum CatsHTTPPayloadType {
    case requestMethodGET
    case requestMethodPUT
    func httpMethod() -> String {
        switch self{
        case .requestMethodGET: return CatsHTTPMethod.get.rawValue
        case .requestMethodPUT: return CatsHTTPMethod.put.rawValue
        }
    }
}

struct CatsAPIModule {
    var payloadType: CatsHTTPPayloadType?
    var ApiParameterEventData = ""
}

enum CatsHTTPSUrl: String {
    case catsUrl = "api.thecatapi.com"
}
