import SwiftUI

struct TransactionCardView: View {
    @StateObject var expenseViewModel: ExpenseViewModel = .init()
    var expense: Expense
    
    var body: some View {
        HStack(spacing: 15) {
            // MARK: First letter Avatar
            if let first = expense.remark.first {
                Text(String(first))
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(circleColor(for: first))
                    )
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.08), radius: 5,x:5,y:5)
            }
            Text(expense.remark)
                .fontWeight(.semibold)
                .lineLimit(1)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
            VStack(alignment: .trailing, spacing: 7) {
                    //mark: display Price
                let price =
                expenseViewModel.ConvertNumberToPrice(value: expense.type == .expense ? -expense.amount : expense.amount)
                Text(price)
                    .font(.callout)
                    .opacity(0.7)
                    .offset(x: -10)
                Text(expense.date.formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .opacity(0.5)
                    .offset(x: -10)
                    
            }
        }
        .padding(5) 
        .background{
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
                
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .offset(x: -10)
                .padding(.vertical, -8)
        }// Add padding as needed
    }
    
    // Function to calculate index for selecting color from predefinedColors
    private func circleColor(for first: Character) -> Color {
        switch first.lowercased() {
        case "m":
            return .yellow
        case "t":
            return .purple
        case "f":
            return .red
        case "u":
            return .green
        case "a":
            return .yellow
        case "s":
            return .red
        case "i":
            return .purple
        case "p":
            return .green
        case "r":
            return .yellow
        case "s":
            return .red
        default:
            return .blue
        }
    }
}
struct TransactionCardView_previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

