import SwiftUI

class ExpenseViewModel: ObservableObject{
    // MARK: Properties
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var currentMonthStartDate: Date = Date()
    //Marl: Expense/Income tab
    @Published var tabName: ExpenseType = .expense
    //Meak: Filter view
    @Published var showFilterView: Bool = false
    //Mark: New Expense Properties
    @Published var addNewExpenses: Bool = false
    @Published var amount: String = ""
    @Published var type: ExpenseType = .all
    @Published var remark: String = ""
    @Published var date: Date = Date()
    
    init(){
        // MARK: Fetching Current Month Starting Date
        let calendar = Calendar.current
        let components = calendar.dateComponents ([.year,.month], from: Date())
        
        startDate = calendar.date(from: components)!
        currentMonthStartDate = calendar.date(from: components)!
    }
    //sample date for our data
        @Published var expenses: [Expense] = sample_expenses
    
        // MARK: Fetching Current Month Date String
    
    func currentMonthDateString()->String{
        return currentMonthStartDate.formatted(date: .abbreviated, time: .omitted)  + "-" +
            Date().formatted (date: .abbreviated, time: .omitted)
    }
    func mainBalance(expenses: [Expense]) -> String {
        let income = convertExpensesToCurrency(expenses: expenses, type: .income)
        let expensesTotal = convertExpensesToCurrency(expenses: expenses, type: .expense)
        
        // Parse currency strings to Double
        let incomeAmount = Double(income.replacingOccurrences(of: "₹", with: "").replacingOccurrences(of: ",", with: "")) ?? 0
        let expensesAmount = Double(expensesTotal.replacingOccurrences(of: "₹", with: "").replacingOccurrences(of: ",", with: "")) ?? 0
        
        // Calculate main balance
        let mainBalance = incomeAmount - expensesAmount
        
        // Format main balance as currency string
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₹" // Set currency symbol
        return formatter.string(from: NSNumber(value: mainBalance)) ?? "₹0.00"
    }

    func convertExpensesToCurrency(expenses: [Expense],type: ExpenseType = .all)->String{
    var value: Double = 0
        value = expenses.reduce(0, { partialResult, expense in
            return partialResult + (type == .all ? (expense.type == .income ? expense.amount : -expense.amount) : (expense.type == type ? expense.amount : 0))
        })
        return ConvertNumberToPrice(value: value)
    }
    
    //Mark: Converting Selected Dates To Staring
    func convertDateToString()->String{
        return startDate.formatted(date: .abbreviated, time: .omitted)  + "-" +
        endDate.formatted (date: .abbreviated, time: .omitted)
    }
    //mark:converting number into price
    func ConvertNumberToPrice(value: Double)->String{
        let formatter = NumberFormatter ()
        formatter.numberStyle = .currency
        return formatter.string(from: .init(value: value)) ?? "$0.00"
    }
    //Clearing All Data
    func clearData(){
        date = Date()
        type = .all
        remark = ""
        amount = ""
    }
    //Mark: Save Data
    func saveData(env: EnvironmentValues){
        //Mark: Do Actions here
        print("Save")
        //Mark: This  is for UI Demo
        // I have replace it with core data actions
        let amountInDouble = (amount as NSString).doubleValue
        let colors = ["yellow","red","Purple","Green"]
        let expense = Expense(remark: remark, amount: amountInDouble, date: date, type: type, color: colors.randomElement() ?? "yellow")
        withAnimation{expenses.append(expense)}
        expenses = expenses.sorted(by: {first, scnd in
            return scnd.date > first.date
        })
    }
}

