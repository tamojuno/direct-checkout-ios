//
//  CardLabel.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 23/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

private let DEFAULT_CC_MASK = "0000  0000  0000  0000"
private let DEFAULT_CVC_MASK = "000"

struct CardLabelModel {
    let name: String
    let detector: NSRegularExpression
    let cardLength: Int
    let cvcLength: Int
    let maskCC: String
    let maskCVC: String
    let order: Int
    
    func matches(cardNumber: String) -> Bool {
        let range = NSRange(location: 0, length: cardNumber.utf16.count)
        return detector.firstMatch(in: cardNumber, options: [], range: range) != nil
    }
}

enum CardLabel: CaseIterable {
    case visa
    case masterCard
    
    func get() -> CardLabelModel {
        switch self {
        case .visa:
            return CardLabelModel(name: "visa", detector: "^4".regex(), cardLength: 16, cvcLength: 3, maskCC: DEFAULT_CC_MASK, maskCVC: DEFAULT_CVC_MASK, order: 99)
            
        case .masterCard:
            return CardLabelModel(name: "mastercard", detector: "^(5[1-5]|2(2(2[1-9]|[3-9])|[3-6]|7([0-1]|20)))".regex(), cardLength: 16, cvcLength: 3, maskCC: DEFAULT_CC_MASK, maskCVC: DEFAULT_CVC_MASK, order: 99)
        }
    }
    
    static func all() -> [CardLabelModel] {
        return allCases.map({ $0.get() })
    }
}
