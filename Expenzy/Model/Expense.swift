import SwiftUI

struct Expense: Identifiable,Hashable{
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type:ExpenseType
    var color: String
 
}
    enum ExpenseType: String{
        case income = "Income"
        case expense = "expenses"
        case all = "ALL"
    }
var sample_expenses: [Expense] = [
    Expense(remark: "Magic Keyboard", amount: 99, date:
                Date(timeIntervalSince1970: 1652987245),
            type: .expense, color: "Yellow"),
    Expense(remark: "Food", amount: 19, date: Date(timeIntervalSince1970: 1652814445), type: .expense, color: "red"),
    Expense(remark: "Trackpad", amount: 99, date: Date(timeIntervalSince1970: 1652382445), type: .expense, color: "purple"),
    Expense(remark: "Uber Cab", amount: 20, date: Date(timeIntervalSince1970: 1652296045), type: .expense, color: "green"),
    Expense (remark: "Amazon Purchase", amount: 299, date: Date(timeIntervalSince1970: 1652209645), type: .expense, color: "yellow"),
    Expense(remark: "Stocks", amount: 399, date:Date(timeIntervalSince1970: 1652036845), type: .expense, color: "purple"),
    Expense(remark: "In App Purchase", amount: 5.99, date: Date(timeIntervalSince1970: 1651864045), type: .expense, color: "red"),
    Expense(remark: "Cinema", amount: 99, date: Date(timeIntervalSince1970: 1651691245),type: .expense, color: "yellow"),
    Expense(remark: "phone", amount: 25, date: Date(timeIntervalSince1970: 1651518445),type: .expense, color: "green"),
    Expense(remark: "Resto", amount: 49, date: Date(timeIntervalSince1970: 1651432045), type: .expense, color: "purple"),
    ]
