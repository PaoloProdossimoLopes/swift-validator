//
//  FileName
//  Module name
//
//  Created by Paolo Prodossimo Lopes on 03/06/22.
//  Doc: https:// ...
//

import Foundation

protocol ValidateDataHandlerProtocol {
    func validate(rule: ValidateOption.TableView.Cell.Params) -> Bool
    func validate(rule: ValidateOption.TableView.Header.Params) -> Bool
    func validate(rule: ValidateOption.Box.Params) -> Bool
}

struct ValidateDataHandler: ValidateDataHandlerProtocol {
    
    //MARK: - Properties
    let balanceModel: BalanceModel?
    let statementModel: StatementModel?
    let errors: [ServiceErros]
    
    //MARK: - ValidateViewModelProtocol
    func validate(rule: ValidateOption.TableView.Cell.Params) -> Bool {
        switch rule {
        case .isStandartCell: return validateStandartCell
        case .isNoStatementCell: return validateNoStatementCell
        case .isEmptyStateCell: return validateEmptyStateCell
        case .isFooterCell(let index): return validateFooterCell(current: index)
        case .isAllNoStatementCell: return validateAllNoStatementCell
        }
    }
    
    func validate(rule: ValidateOption.TableView.Header.Params) -> Bool {
        switch rule {
        case .isTodayHeader: return validateTodayHeader
        case .isStandartHeader: return validateStandartHeader
        }
    }
    
    func validate(rule: ValidateOption.Box.Params) -> Bool {
        switch rule {
        case .isBalaceView: return validateBalanceView
        case .isErrorView: return validateErrorView
        case .isNegativeView: return validateNegativeView
        case .isLimitView: return validateLimiteView
        }
    }
}

//MARK: - Helpers

//MARK: Box
private extension ValidateDataHandler {
    var balanceInfoIsNil: Bool {
        return balanceModel?.balanceInfo == nil
    }
    
    var limitInfoIsNil: Bool {
        return balanceModel?.limitInfo == nil
    }
    
    var validateBalanceView: Bool {
        return !balanceInfoIsNil
    }
    
    var validateErrorView: Bool { //#1
        //(model == nil) and (model.balanceInfo != nil) and (model.balanceInfo != nil)
        //or
        //errorList CONTAIN .balanceError
        
        let modelIsEmpty = (balanceModel == nil)
        let modelInfoCondition = (modelIsEmpty || balanceInfoIsNil || limitInfoIsNil)
        let containsError = errors.contains(.balanceError)
        
        return modelInfoCondition || containsError
    }
    
    var validateNegativeView: Bool { //#3
        //balance value is negative (balance < 0.0)
        
        return balanceModel?.isNegative ?? false
    }
    
    var validateLimiteView: Bool { //#4
        //limitInfo != 0
        return !limitInfoIsNil
    }
}

//MARK: Cell
private extension ValidateDataHandler {
    var validateStandartCell: Bool { //#4
        //list of itens per section != 0
        
        let noSections = statementModel?.listOfDays.count == 0
        let noModel = statementModel == nil
        let condition = noSections || noModel
        return !condition
    }
    
    var validateNoStatementCell: Bool { //#3
        //statementModel == nil
        //or
        //number of statementModel.listOfDays == 0
        
        let modelIsNil = (statementModel == nil)
        let notContainsSection = (statementModel?.listOfDays.count == 0)
        return modelIsNil || notContainsSection
    }
    
    var validateEmptyStateCell: Bool { //#1
        //errorList Contain .statementError
        //or
        //let notContainsSection = (statementModel?.listOfDays.count == 0)
        //or
        //statementModel == nil
        
        let noModel = (statementModel == nil)
        let notContainsSection = (statementModel?.listOfDays.count == 0)
        let containsError = errors.contains(.statementError)
        return containsError || notContainsSection || noModel
    }
    
    func validateFooterCell(current index: IndexPath) -> Bool { //#2
        //Is last cell (currentRow == (numberOfCells - 1))
        //and
        //Is last section (currentSection == (numberOfSection - 1))
        
        let currentSection = index.section
        let currentRow = index.row
        let numberOfRows = 3 //TODO: Trocar
        let numberOfSections = statementModel?.listOfDays.count ?? 0
        
        let isLastSection = (currentSection == (numberOfSections - 1))
        let isLastCell = (currentRow == (numberOfRows - 1))
        
        return isLastSection && isLastCell
    }
    
    var validateAllNoStatementCell: Bool {
        //
        //
        //
        //
        return false
    }
}

//MARK: Header
private extension ValidateDataHandler {
    var validateTodayHeader: Bool { //#1
        //statementModel.listOfDays CONTAINS today date
        
        if let listOfDays = statementModel?.listOfDays {
            //let today = Date.today.extract.todayDateInverted
            let today = "today"
            return listOfDays.contains(today)
        }
        return false
    }
    
    var validateStandartHeader: Bool { //#2
        //List of days != 0
        
        return statementModel?.listOfDays.count != 0
    }
}
