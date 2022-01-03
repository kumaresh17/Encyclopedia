//
//  EncyclopediaTests.swift
//  EncyclopediaTests
//
//  Created by  on 23/12/2021.
//

import XCTest
@testable import Encyclopedia

class EncyclopediaTests: XCTestCase {
    
    var router: TestCatRouter!
    var service: ApiManagerProtocol!
    var view: EncyclopediaViewProtocol!
    var cat: CatsResponseProtocol!
    var detailView: CatDetailsViewProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        router = TestCatRouter()
        service = ApiManager()
        view = EncyclopediaViewController()
        detailView = CatDetailViewController()
        mockData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        router = nil
        service = nil
        view = nil
        detailView = nil
        cat = nil
    }
    
    /**
     Test case to check if the Module has been added and the view has been configured to show
     */
    func testThatItShowsCatsViewScreen() {
        router.assembleModule(view: view)
        XCTAssertTrue(router.showCatViewCalled)
        XCTAssertNil(router.presenter?.view, "View can not be nil")
    }
    
    /**
     Test case to check if the detail view has been configured to show
     */
    func testThatItShowsDetailViewScreen() {
        router.showDetailView(detailView: detailView, catResposne: cat)
        XCTAssertTrue(router.showDetailViewCalled)
        XCTAssertNil(router.presenter?.view, "View can not be nil")
    }
     
    /**
     Test case to check if the url is a valid url or not
     Supply some invalid url string to make it fail
     */
    func testIfCanOpenURL() {
        let validUrl = verifyUrl(urlString: cat.externalLinkToWikipedia)
        if validUrl {
            XCTAssertTrue(validUrl)
        } else {
            XCTFail("Received nil or invalid URL")
        }
    }
    /**
     Api testing if it works well
     */
    func testGetCatAPICall()  {
        
        let payload = getPayload()
        let expect = expectation(description: "API response completion")
        service.getCatListInfo(payload: payload) { result in
            expect.fulfill()
            switch result {
            case .success(let data):
                XCTAssertTrue(data.count>0, "Cat array should not be empty" );
            case .failure(_):
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let payload = getPayload()
            service.getCatListInfo(payload: payload) { result in
            }
        }
    }
    
}


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
