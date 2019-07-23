//
//  DirectCheckoutTests.swift
//  DirectCheckoutTests
//
//  Created by Diego Trevisan Lara on 21/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

import XCTest
@testable import DirectCheckout

class DirectCheckoutTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let expectation = XCTestExpectation(description: "teste")
        
        DirectCheckout.initialize(token: "73DDC22A9BC22B6B7AE325635D40BD3D3C065CAEAD4C7242CE2E61681C8402C5", environment: .sandbox)
        
        let strategy = APIHtmlStrategy()
        let apiClient = APIClient(strategy: strategy)
        let gateway = APIDirectCheckoutGateway(apiClient: apiClient)
        let useCase = GetEncryptionKeyUseCase(gateway: gateway)
        useCase.get(publicToken: "73DDC22A9BC22B6B7AE325635D40BD3D3C065CAEAD4C7242CE2E61681C8402C5", version: "0.0.2") { result in
            print(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
