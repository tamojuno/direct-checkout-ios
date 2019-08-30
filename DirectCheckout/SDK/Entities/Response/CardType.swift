//
//  CardType.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 23/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

private let DEFAULT_CC_MASK = "0000  0000  0000  0000"
private let DEFAULT_CVC_MASK = "000"

struct CardTypeAssets {
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

public enum CardType: String, CaseIterable {
    case visa
    case masterCard
    case amex
    case discover
    case hipercard
    case diners
    case jcb15
    case jcb16
    case elo
    case aura
    
    var name: String {
        return rawValue.capitalized
    }
    
    func assets() -> CardTypeAssets {
        switch self {
        case .visa:
            return CardTypeAssets(name: "visa",
                                  detector: "^4".regex(),
                                  cardLength: 16,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 99)
            
        case .masterCard:
            return CardTypeAssets(name: "mastercard",
                                  detector: "^(5[1-5]|2(2(2[1-9]|[3-9])|[3-6]|7([0-1]|20)))".regex(),
                                  cardLength: 16,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 99)
            
        case .amex:
            return CardTypeAssets(name: "amex",
                                  detector: "^3[47]".regex(),
                                  cardLength: 15,
                                  cvcLength: 4,
                                  maskCC: "0000  000000  00000",
                                  maskCVC: "0000",
                                  order: 99)
            
        case .discover:
            return CardTypeAssets(name: "discover",
                                  detector: "^6(?:011\\d{12}|5\\d{14}|4[4-9]\\d{13}|22(?:1(?:2[6-9]|[3-9]\\d)|[2-8]\\d{2}|9(?:[01]\\d|2[0-5]))\\d{10})".regex(),
                                  cardLength: 16,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 2)
            
        case .hipercard:
            return CardTypeAssets(name: "hipercard",
                                  detector: "^606282|384100|384140|384160".regex(),
                                  cardLength: 16,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 4)
            
        case .diners:
            return CardTypeAssets(name: "diners",
                                  detector: "^(300|301|302|303|304|305|36|38)".regex(),
                                  cardLength: 14,
                                  cvcLength: 3,
                                  maskCC: "0000  000000  0000",
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 5)
            
        case .jcb15:
            return CardTypeAssets(name: "jcb_15",
                                  detector: "^2131|1800".regex(),
                                  cardLength: 15,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 6)
            
        case .jcb16:
            return CardTypeAssets(name: "jcb_16",
                                  detector: "^35(?:2[89]|[3-8]\\d)".regex(),
                                  cardLength: 16,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 7)
            
        case .elo:
            return CardTypeAssets(name: "elo",
                                  detector:  "^(4011(78|79)|43(1274|8935)|45(1416|7393|763(1|2))|50(4175|6699|67([0-6][0-9]|7[0-8])|9\\d{3})|627780|63(6297|6368)|650(03([^4])|04([0-9])|05(0|1)|4(0[5-9]|(1|2|3)[0-9]|8[5-9]|9[0-9])|5((3|9)[0-8]|4[1-9]|([0-2]|[5-8])\\d)|7(0\\d|1[0-8]|2[0-7])|9(0[1-9]|[1-6][0-9]|7[0-8]))|6516(5[2-9]|[6-7]\\d)|6550(2[1-9]|5[0-8]|(0|1|3|4)\\d))\\d*".regex(),
                                  cardLength: 16,
                                  cvcLength: 3,
                                  maskCC: DEFAULT_CC_MASK,
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 1)
            
        case .aura:
            return CardTypeAssets(name: "aura",
                                  detector: "^((?!5066|5067|50900|504175|506699)50)".regex(),
                                  cardLength: 19,
                                  cvcLength: 3,
                                  maskCC: "0000000000000000000",
                                  maskCVC: DEFAULT_CVC_MASK,
                                  order: 3)
        }
    }
    
}


