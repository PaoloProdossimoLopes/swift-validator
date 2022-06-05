//
//  ViewController.swift
//  swift-validator-demo
//
//  Created by Paolo Prodossimo Lopes on 05/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var validator: ValidateDataHandler {
        return .init(balanceModel: nil, statementModel: nil, errors: [])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(validator.validate(rule: .isBalaceView))
        print(validator.validate(rule: .isErrorView))
        print(validator.validate(rule: .isEmptyStateCell))
        print(validator.validate(rule: .isStandartCell))
    }
}

