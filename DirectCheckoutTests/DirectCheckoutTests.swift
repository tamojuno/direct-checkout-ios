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

    func testExample() {

        let expectation = XCTestExpectation(description: "teste")

        DirectCheckout.initialize(publicToken: "AF2261E2ECC7FD90D205502092571F5C1C0831935E35073AA95AEBEB68D7E5C5", environment: .sandbox)

        let card = Card(cardNumber: "5448280000000007", holderName: "Diego", securityCode: "123", expirationMonth: "01", expirationYear: "2020")
        DirectCheckout.getCardHash(card) { result in
            print(result)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)

    }
    
    func test_card_type_name() {
        XCTAssertEqual(CardType.visa.name, "Visa")
        XCTAssertEqual(CardType.masterCard.name, "Mastercard")
        XCTAssertEqual(CardType.elo.name, "Elo")
    }
    
    func test_get_type() {
        XCTAssertEqual(DirectCheckout.getCardType("4111111111111111"), .visa)
        XCTAssertEqual(DirectCheckout.getCardType("5105-1051-0510-5100"), .masterCard)
        XCTAssertEqual(DirectCheckout.getCardType("3400 0000 0000 009"), .amex)
        XCTAssertEqual(DirectCheckout.getCardType("6362.9700.0045.7013"), .elo)
    }
    
    func test_card_get_type() {
        let card1 = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertEqual(card1.getType(), .visa)
        
        let card2 = Card(cardNumber: "5105105105105100", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertEqual(card2.getType(), .masterCard)
        
        let card3 = Card(cardNumber: "3400 0000 0000 009", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertEqual(card3.getType(), .amex)
    }
    
    func test_valid_number() {
        XCTAssertTrue(DirectCheckout.isValidCardNumber("4111111111111111"))
        XCTAssertTrue(DirectCheckout.isValidCardNumber("5105105105105100"))
        XCTAssertFalse(DirectCheckout.isValidCardNumber("1234123412341234"))
        XCTAssertFalse(DirectCheckout.isValidCardNumber("0000000000000000"))
    }
    
    func test_card_valid_number() {
        let card1 = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertTrue(card1.validateNumber())
        
        let card2 = Card(cardNumber: "0000000000000000", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertFalse(card2.validateNumber())
    }
    
    func test_valid_security_code() {
        XCTAssertTrue(DirectCheckout.isValidSecurityCode("4111111111111111", "123")) //visa
        XCTAssertTrue(DirectCheckout.isValidSecurityCode("5105105105105100", "987")) //master
        
        XCTAssertFalse(DirectCheckout.isValidSecurityCode("4111111111111111", "1234")) //visa
        XCTAssertFalse(DirectCheckout.isValidSecurityCode("5105105105105100", "98")) //master
    }
    
    func test_card_valid_security_code() {
        let card1 = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertTrue(card1.validateCVC())
        
        let card2 = Card(cardNumber: "5105105105105100", holderName: "Holder", securityCode: "1234", expirationMonth: "03", expirationYear: "2020")
        XCTAssertFalse(card2.validateCVC())
    }
    
    func test_valid_expire_date() {
        for i in 1...100 {
            let testDate = Calendar.current.date(byAdding: .month, value: i, to: Date())
            let month = Calendar.current.component(.month, from: testDate!)
            let year = Calendar.current.component(.year, from: testDate!)

            XCTAssertTrue(DirectCheckout.isValidExpireDate(month: "\(month)", year: "\(year)"))
        }
        
        for i in -100...0 {
            let testDate = Calendar.current.date(byAdding: .month, value: i, to: Date())
            let month = Calendar.current.component(.month, from: testDate!)
            let year = Calendar.current.component(.year, from: testDate!)
            
            XCTAssertFalse(DirectCheckout.isValidExpireDate(month: "\(month)", year: "\(year)"))
        }
        
        XCTAssertFalse(DirectCheckout.isValidExpireDate(month: "03", year: "0"))
        XCTAssertFalse(DirectCheckout.isValidExpireDate(month: "0", year: "2020"))
    }
    
    func test_card_valid_expire_date() {
        for i in 1...100 {
            let testDate = Calendar.current.date(byAdding: .month, value: i, to: Date())
            let month = Calendar.current.component(.month, from: testDate!)
            let year = Calendar.current.component(.year, from: testDate!)
            let card = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "123", expirationMonth: "\(month)", expirationYear: "\(year)")
            
            XCTAssertTrue(card.validateExpireDate())
        }
        
        for i in -100...0 {
            let testDate = Calendar.current.date(byAdding: .month, value: i, to: Date())
            let month = Calendar.current.component(.month, from: testDate!)
            let year = Calendar.current.component(.year, from: testDate!)
            let card = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "123", expirationMonth: "\(month)", expirationYear: "\(year)")
            
            XCTAssertFalse(card.validateExpireDate())
        }
    }
    
    func test_card_validade() {
        var card: Card
        
        card = Card(cardNumber: "4111111111111111", holderName: "", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertThrowsError(try card.validate())
        
        card = Card(cardNumber: "0000000000000000", holderName: "Holder", securityCode: "123", expirationMonth: "03", expirationYear: "2020")
        XCTAssertThrowsError(try card.validate())
        
        card = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "1", expirationMonth: "03", expirationYear: "2020")
        XCTAssertThrowsError(try card.validate())
        
        card = Card(cardNumber: "4111111111111111", holderName: "Holder", securityCode: "123", expirationMonth: "01", expirationYear: "1990")
        XCTAssertThrowsError(try card.validate())
    }

}
