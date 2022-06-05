import Foundation

struct ValidateOption {
    
    //MARK: - Table view
    struct TableView {
        struct Cell {
            enum Params {
                case isStandartCell
                case isNoStatementCell
                case isAllNoStatementCell
                case isEmptyStateCell
                case isFooterCell(index: IndexPath)
            }
        }
        
        struct Header {
            enum Params {
                case isTodayHeader
                case isStandartHeader
            }
        }
    }
    
    //MARK: - Box
    struct Box {
        enum Params {
            case isBalaceView
            case isErrorView
            case isNegativeView
            case isLimitView
        }
    }
}
