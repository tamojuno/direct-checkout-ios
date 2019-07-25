//
//  CardUtils.swift
//  DirectCheckout
//
//  Created by Diego Trevisan Lara on 24/07/19.
//  Copyright © 2019 Juno Pagamentos. All rights reserved.
//

class CardUtils {
    
    static func getCardType(_ cardNumber: String) -> CardLabelModel? {
        return CardLabel.all().first(where: { $0.matches(cardNumber: cardNumber) })
    }
    
    static func validateNumber(_ cardNumber: String) -> Bool {
//        let cardNo = cardNumber.replacingOccurrences(of: " ", with: "")
//        guard let type = getCardType(cardNumber) else { return false }
//        return type.cardLength == cardNo.count && validateNum(cardNo)
        return false
    }
    
    static func validateCVC(_ cardNumber: String, _ securityCode: String) -> Bool {
        let cardLabel = getCardType(cardNumber)
        return cardLabel?.cvcLength == securityCode.count
    }
    
    static func validateExpireDate(_ month: String, _ year: String) -> Bool {
        guard let expirationMonth = Int(month), let expirationYear = Int(year), expirationMonth > 0, expirationYear > 0 else {
            return false
        }
        
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        
        return expirationYear >= currentYear ? (expirationYear == currentYear ? expirationMonth > currentMonth : true) : false
    }
    
}

//internal object CardUtils {
//
//    fun getCardType(cardNumber: String) = CardLabel.getOrderedLabels().find {
//        it.detector.containsMatchIn(cardNumber.replace(" ", ""))
//    }
//
//    fun validateCVC(cardNumber: String, securityCode: String) =
//        securityCode.length == getCardType(cardNumber)?.cvcLength
//
//    fun validateNumber(cardNumber: String): Boolean {
//        val cardNo = cardNumber.replace(" ", "")
//        val type = getCardType(cardNumber)
//        return type != null && type.cardLength == cardNo.length && validateNum(cardNo)
//    }
//
//    fun validateExpireDate(expirationMonth: String, expirationYear: String): Boolean {
//        val today = Calendar.getInstance()
//        val month = today.get(Calendar.MONTH)
//        val year = today.get(Calendar.YEAR)
//        if (expirationMonth.toInt() > 0 && expirationYear.toInt() > 0 && expirationYear.toInt() >= year) {
//            if (expirationYear.toInt() == year) {
//                return (expirationMonth.toInt() > month)
//            }
//            return true
//        }
//        return false
//    }
//
//    private fun validateNum(cardNo: String): Boolean {
//        var checkSumTotal = 0
//
//        for (digitCounter in cardNo.length - 1 downTo 0 step 2) {
//            checkSumTotal += cardNo[digitCounter].toString().toInt()
//            runCatching {
//                (cardNo[digitCounter - 1].toString().toInt() * 2).toString().forEach {
//                    checkSumTotal += it.toString().toInt()
//                }
//            }
//        }
//        return (checkSumTotal % 10 == 0)
//    }
//
//}
