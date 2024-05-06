import SwiftUI
struct FilteredDetailView: View{
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    //mark:Environment values
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View{
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    //mark: backbutton
                    Button{
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                        
                    }
                    Text("Transactions")
                        .font(.title2.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        expenseViewModel.showFilterView =  true
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                }
                //mRK: Expense card view for currently selected date
                ExpenseCard(isFilter: true)
                    .environmentObject(expenseViewModel)
                CustomeSegmentedContorl()
                    .padding(.top)
                //Mark: Currently filtered Date With Amount
                VStack(spacing: 15){
                    Text(expenseViewModel.convertDateToString())
                        .opacity(0.7)
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: expenseViewModel.tabName))
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseViewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical,20)
                ForEach(expenseViewModel.expenses.filter{
                    return $0.type == expenseViewModel.tabName
                }){expense in
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseViewModel)
                        .padding(.vertical,1.5)
                        .offset(x: 10)
                    
                }
            }.padding()
            
        }.navigationBarHidden(true)
            .background{
                Color("white")
                    .ignoresSafeArea()
            }
            .overlay{
                FilterView()
            }
        }
        //Mark: Filter view
    @ViewBuilder
    func FilterView()->some View{
        ZStack{
            Color.black
                .opacity(expenseViewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
                //mark: base on the date Filter Expenses Array
            if expenseViewModel.showFilterView{
                    VStack(alignment: .leading, spacing: 10){
                        Text("Start Date")
                            .font(.caption)
                            .opacity(0.7)
                        DatePicker("", selection:$expenseViewModel.startDate,in:Date.distantPast...Date(), displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                        
                        Text("End Date")
                            .font(.caption)
                            .opacity(0.7)
                            .padding(.top,10)
                        DatePicker("", selection:$expenseViewModel.endDate,in:Date.distantPast...Date(), displayedComponents: [.date])
                            .labelsHidden()
                            .datePickerStyle(.compact)
                    }
                    .padding(20)
                    .background{
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .fill(.white)
                    }
                    //Mark: close button
                    .overlay(alignment: .topTrailing, content : {
                        Button{
                                    expenseViewModel.showFilterView = false
                                }label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title3)
                                    .foregroundColor(.black)
                                    .padding(5)
                            }
                    }).padding()
                    .offset(x:-3)
            
            }
        }
        .animation(.easeInOut)
    }
        //maRK: CUSTOME segmented control
        @ViewBuilder
        func CustomeSegmentedContorl()->some View{
            HStack(spacing: 0){
                ForEach([ExpenseType.income,ExpenseType.expense],id:\.rawValue){tab in
                    Text(tab.rawValue.capitalized)
                        .fontWeight(.semibold)
                        .foregroundColor(expenseViewModel.tabName == tab ? .white : .black)
                        .opacity(expenseViewModel.tabName == tab ? 1: 0.7)
                        .padding(.vertical,12)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background{
                            //mark: With Matched geometry Effect
                            if expenseViewModel.tabName ==  tab{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(LinearGradient(colors: [Color.red, Color.blue
                                                                 ], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation{expenseViewModel.tabName = tab}
                        }
                }
            }
            .padding(5)
            .background{
                RoundedRectangle(cornerRadius:10,style: .continuous)
                    .fill(.white)
            }
        }
    }
struct FilteredDetailView_Preview: PreviewProvider{
    static var previews: some View{
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
