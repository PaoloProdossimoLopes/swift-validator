//
//  Helpers.swift
//  swift-validator-demo
//
//  Created by Paolo Prodossimo Lopes on 05/06/22.
//

import Foundation

struct StatementModel {
    var listOfDays: [String] = ["today"]
}

struct BalanceModel {
    var limitInfo: Int
    var balanceInfo: Int
    
    var isNegative: Bool {
        balanceInfo < 0
    }
}

enum ServiceErros {
    case statementError
    case balanceError
}
