import SwiftUI
struct NewExpense: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    //Mark: Environment Values
    @Environment(\.self) var env
    var body: some View {
        VStack{
            VStack(spacing: 15){
                Text("Add Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .opacity(0.5)
                
                //Mark: Custome TextField
                //Mark: For  Currency Symbol
                if let symbol = expenseViewModel.ConvertNumberToPrice(value: 0).first{
                    TextField("0",text: $expenseViewModel.amount)
                        .font(.system(size: 35))
                        .foregroundColor(Color(.red))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .background{
                            Text(expenseViewModel.amount == "" ? "0" :
                                    expenseViewModel.amount)
                            .font(.system(size: 35))
                            .opacity(0)
                            .overlay(alignment: .leading){
                                Text(String(symbol))
                                    .opacity(0.8)
                                    .fontWeight(.bold)
                                    .offset(x:-15, y: 5)
                            }
                        }
                        .padding(.vertical,10)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background{
                            Capsule()
                                .fill(.white)
                        }
                        .padding(.horizontal,20)
                        .padding(.top)
                }
                //Mark: Custom Labels
                Label{
                    TextField("Remark",text: $expenseViewModel.remark)
                        .padding(.leading,10)
                }icon: {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.title3)
                        .foregroundColor(Color(.gray))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.gray.opacity(0.3))
                }
                .padding(.top,25)
                
                Label{
                    //Mark: CheckBoxes
                    CustomeCheckboxes()
                }icon: {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title3)
                        .foregroundColor(Color(.gray))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.gray.opacity(0.3))
                }
                .padding(.top,25)
                
                Label{
                    DatePicker.init("",selection:
                                        $expenseViewModel.date,in:Date.distantPast...Date(),displayedComponents:[.date])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading,10)
                }icon: {
                    Image(systemName: "calendar")
                        .font(.title3)
                        .foregroundColor(Color(.gray))
                }
                .padding(.vertical,20)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.gray.opacity(0.3))
                }
                .padding(.top,25)
            }
            .frame(maxHeight: .infinity,alignment: .center)
            //Mark: Save Button
            Button(action: {expenseViewModel.saveData(env: env)}){
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical,15)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(LinearGradient(colors: [Color.red, Color.blue
                                                         ], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .foregroundColor(.white)
                    .padding(.bottom,10)
            }
            .disabled(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "")
            .opacity(expenseViewModel.remark == "" || expenseViewModel.type == .all || expenseViewModel.amount == "" ? 0.6 : 1 )
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .overlay(alignment: .topTrailing){
            Button {
                env.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
                    .opacity(0.7)
            }
            .padding()
        }
    }
    //Mark: checlboxes
    @ViewBuilder
    func CustomeCheckboxes() -> some View {
        HStack(spacing: 10) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.self) { type in
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.black, lineWidth: 2)
                        .opacity(0.5)
                        .frame(width: 20, height: 20)
                        .background(Color.white)
                    if expenseViewModel.type == type {
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .foregroundColor(Color("Green"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    expenseViewModel.type = type
                }
                Text(type.rawValue.capitalized)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.trailing,10)
                    .opacity(0.7)
                                  }
                              }.frame(maxWidth: .infinity,alignment: .leading)
                                  .padding(.leading)
                    }
}
struct NewExpense_Previews: PreviewProvider{
    static var previews: some View{
        NewExpense()
            .environmentObject(ExpenseViewModel())
    }
}
