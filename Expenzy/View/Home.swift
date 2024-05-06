import SwiftUI

struct Home: View {
    @StateObject var expenseViewModel: ExpenseViewModel = .init()
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("welcome!")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("Vatsalya")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    NavigationLink{
                        FilteredDetailView()
                            .environmentObject(expenseViewModel)
                    }label: {
                        Image(systemName: "hexagon.fill")
                            .foregroundColor(.gray)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .padding(7)
                            )
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                .padding()
                ExpenseCard()
                    .environmentObject(expenseViewModel)
                    .padding([.leading, .trailing], 20) // Add padding to the sides
                TransactionView(expenseViewModel: expenseViewModel)
            }
            .background(Color.gray.opacity(0.01))
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented:$expenseViewModel.addNewExpenses){
            expenseViewModel.clearData()
            }content:{
            NewExpense()
                .environmentObject(expenseViewModel)
        }
            .overlay(alignment: .bottomTrailing){
                AddButton()
            }
    }
    //Mark: Add New Expense Button
    func AddButton()->some View{
        Button{
            expenseViewModel.addNewExpenses.toggle()        }  label: {
            Image(systemName: "plus")
                .font(.system(size: 25,weight: .medium))
                .foregroundColor(.white)
                .frame(width:55, height: 55)
                .background{
                    Circle()
                        .fill(LinearGradient(colors: [Color.red, Color.blue
                                                     ], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                .shadow(color: .black.opacity(0.1), radius: 5,x: 5, y: 5)
        }.padding()
    }
    //Mark:Transaction View
    @ViewBuilder
    func TransactionView(expenseViewModel: ExpenseViewModel) -> some View {
        VStack(spacing: 25){
            Text("Transaction")
                .font(.title2.bold())
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            
            ForEach(expenseViewModel.expenses) { expense in
                TransactionCardView(expense: expense)
            }
        }
        .padding(.leading, 20) // Adjust the value as needed
        .padding(.top)
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
