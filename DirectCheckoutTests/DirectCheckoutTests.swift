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

        DirectCheckout.initialize(publicToken: "AF2261E2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5", environment: .sandbox)

        let card = Card(cardNumber: "", holderName: "", securityCode: "", expirationMonth: "", expirationYear: "")
        DirectCheckout.getCardHash(card) { result in
            print(result)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)

    }
    
    func testValidSecurityCode() {
        XCTAssertTrue(DirectCheckout.isValidSecurityCode("4111111111111111", "666")) //visa
        XCTAssertTrue(DirectCheckout.isValidSecurityCode("5105105105105100", "666")) //master
    }
    
    func testValidExpireDate() {
        XCTAssertFalse(DirectCheckout.isValidExpireDate(month: "05", year: "2018"))
        XCTAssertFalse(DirectCheckout.isValidExpireDate(month: "06", year: "2019"))
        XCTAssertFalse(DirectCheckout.isValidExpireDate(month: "07", year: "2019"))
        XCTAssertTrue(DirectCheckout.isValidExpireDate(month: "08", year: "2019"))
        XCTAssertTrue(DirectCheckout.isValidExpireDate(month: "09", year: "2020"))
    }

}
