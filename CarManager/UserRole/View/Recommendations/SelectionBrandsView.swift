//
//  SelectionBrandsView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 25.04.23.
//

import SwiftUI

struct SelectionBrandsView: View {
    let data = (1...100).map { "Item \($0)" }
    
    let columns = [        GridItem(.fixed(80)),        GridItem(.fixed(80)),        GridItem(.fixed(80)),        GridItem(.fixed(80)),    ]
    
    @State var selectedItems: [String] = []
    
    var body: some View {
        VStack {
            Text("Выберите предпочитаемые бренды")
                .font(.title)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 0)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        let isSelected = selectedItems.contains(item)
                        Image("bmw")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .background(isSelected ? Color.blue : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                if isSelected {
                                    selectedItems.removeAll(where: { $0 == item })
                                } else {
                                    selectedItems.append(item)
                                }
                            }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
          
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer(minLength: 0)
            
            Button(action: {
                continueWithSelectedItems()
            }) {
                Text("Продолжить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding()

        }
    }

    func continueWithSelectedItems() {
        print(selectedItems)
    }
}






struct SelectionBrandsView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionBrandsView()
    }
}
