//
//  EncyclopediaTests+PayLoadFormatTests.swift
//  EncyclopediaTests
//
//  Created by kumaresh shrivastava on 03/01/2022.
//

import XCTest
@testable import Encyclopedia

extension EncyclopediaTests: PayLoadFormat {
    
    class TestCatRouter: EncyclopediaRouterProtocol {
        
        var presenter: EncyclopediaPresenterProtocol?
        var showCatViewCalled = false
        var showDetailViewCalled = false
        
        ///Check if assembling module happens
        func assembleModule(view: EncyclopediaViewProtocol) {
            self.showCatViewCalled = true
        }
        
        /// Check if detail view function being called
        func showDetailView(detailView: CatDetailsViewProtocol, catResposne: CatsResponseProtocol) {
            self.showDetailViewCalled = true
        }
    }
    
    
    //Mock the ATMusic struct here
    struct TestCatResponse: CatsResponseProtocol {
        var name: String?
        var imageurl: String?
        var temperament: String?
        var energylevel: Int
        var externalLinkToWikipedia: String?
        var identifier : UUID?
    }
    
    /**
     Test case data for Album
     */
    func mockData()  {
       
        cat = TestCatResponse(name: "Abyssinian", imageurl: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg", temperament: "Active, Energetic, Independent, Intelligent, Gentle", energylevel: 5, externalLinkToWikipedia: "https://en.wikipedia.org/wiki/Abyssinian_(cat)", identifier: UUID())
        
       let cat2 = TestCatResponse(name: "American Bobtail", imageurl: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg", temperament: "Active, Energetic, Independent, Intelligent, Gentle", energylevel: 5, externalLinkToWikipedia: "https://en.wikipedia.org/wiki/Abyssinian_(cat)", identifier: UUID())
        
       let cat3 = TestCatResponse(name: "American Bobtail", imageurl: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg", temperament: "Active, Energetic, Independent, Intelligent, Gentle", energylevel: 5, externalLinkToWikipedia: "https://en.wikipedia.org/wiki/Abyssinian_(cat)", identifier: UUID())
        
        catsDataArray.append(cat)
        catsDataArray.append(cat2)
        catsDataArray.append(cat3)
        
    }

    /**
     Function to check if url string is valid url or not
     */
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    /**
     Function to get the Payload for Get method
     */
    func getPayload() -> CatsHTTPPayloadProtocol {
        var apiModule = CatsAPIModule()
        apiModule.payloadType = CatsHTTPPayloadType.requestMethodGET
        return formatGetPayload(url: .catsUrl, module: apiModule)
    }
}
