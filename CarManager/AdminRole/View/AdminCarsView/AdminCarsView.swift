//
//  AdminCarsView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 15.04.23.
//

import SwiftUI
import Combine
import Kingfisher

struct AdminCarsView: View {
    
    @ObservedObject var viewModel = AdminCarsViewModel()
    @State private var searchText = ""
    @State private var sortSelection = 0
    @State private var showAddCarView = false
    @State private var isRefreshing = false
    
    var sortedCars: [AdminCar] {
        viewModel.sortCars(by: sortSelection)
    }
    
    var body: some View {
        VStack {
            Text("Ваши автомобили")
                .font(.largeTitle)
            TextField("Поиск", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker(selection: $sortSelection, label: Text("Сортировать")) {
                Text("По цене ↓").tag(0)
                Text("По году ↓").tag(1)
                Text("По объёму ↓").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            HStack {
                Spacer()
                Button {
                    print("")
                    isRefreshing = true
                    viewModel.fetchCars()
                    isRefreshing = false
                }
                label: {
                    Image(systemName: "circle.dashed")
                        .foregroundStyle(.black)
                }
            }
            .padding(.trailing)
            .padding(.top, 0)
            if viewModel.isLoading {
                ProgressView()
            } else {
                CarListView(sortedCars: sortedCars, searchText: searchText)
                    .padding()
            }
            Button(action: {
                self.showAddCarView = true
            }) {
                Image(systemName: "plus")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
            }
        }
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.fetchCars()
        }
        .fullScreenCover(isPresented: $showAddCarView) {
            AdminAddCarView()
        }
    }
}

struct AdminCarsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminCarsView()
    }
}



