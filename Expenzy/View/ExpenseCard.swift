import SwiftUI
struct ExpenseCard: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    var isFilter: Bool = false
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.red, Color.blue]), // Example gradient colors
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            VStack(spacing: 15){
                VStack(spacing: 15){
                    //Mark:currently going Month date string
                    Text( isFilter ? expenseViewModel.convertDateToString() : expenseViewModel.currentMonthDateString())
                        .font(.callout)
                        .fontWeight(.semibold)
                    //mark: current month price
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses))
                        .font(.system(size: 35,weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom,5)
                }
                .offset (y: -10)
                HStack(spacing: 15){
                    Image("Agreen") // Replace "CustomArrow" with the name of your PNG asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20) // Set size to 30x30
                        .foregroundColor(Color("Green")) // Set color directly
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Add shadow effect
                        .rotationEffect(Angle(degrees: 180))
                    VStack(alignment: .leading, spacing: 4) {
                        Text ("Income" )
                            .font(.caption)
                            .fontWeight(.bold)
                            .opacity (0.8)
                        Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses,type: .income))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    Image("Ared") // Replace "CustomArrow" with the name of your PNG asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20) // Set size to 30x30
                        .foregroundColor(Color("Green")) // Set color directly
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2) // Add shadow effect
                    VStack(alignment: .leading, spacing: 4) {
                        Text ("Expenses" )
                            .font(.caption)
                            .fontWeight(.bold)
                            .opacity (0.8)
                        Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses,type: .income))
                            .font(.callout)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .fixedSize()
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                .offset(y: 20)
            }
            .foregroundColor(.white)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity,alignment: .center)
            .padding(.top, -20)
        }
        .frame(height: 220)
        .padding(.top)
    }
}


