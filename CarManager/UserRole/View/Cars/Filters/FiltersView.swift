//
//  FiltersView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 22.04.23.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject var viewModel: UserCarsViewModel
    @Binding var seleсtedCountry: CarCountryFilter
    @Binding var selectedFuel: CarFuelTypeFilter
    @Binding var selectedEngineCapacity: CarEngineCapacityFilter
    
    @State var isPressedPrice: Bool = false
    @State var isPressedYear: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Text(viewModel.priceSort.rawValue)
                        .padding(7)
                        .padding(.horizontal, 5)
                        .background(
                            Capsule().fill(.white)
                                .overlay(
                                    Capsule().stroke(Color.gray)
                                )
                        )
                        .scaleEffect(isPressedPrice ? 0.9 : 1.0) // Добавляем модификатор scaleEffect
                        .animation(.easeInOut(duration: 0.2)) // Добавляем анимацию
                        .onTapGesture {
                            withAnimation { // добавляем анимацию изменения viewModel.priceSort
                                if (viewModel.priceSort == .priceASC){
                                    viewModel.priceSort = .priceDESC
                                } else {
                                    viewModel.priceSort = .priceASC
                                }
                                viewModel.sortList(by: viewModel.priceSort)
                            }
                            isPressedPrice = true // устанавливаем флаг, что кнопка была нажата
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // сбрасываем флаг после завершения анимации
                                isPressedPrice = false
                            }
                        }
                        .foregroundColor(Color.black)
                        
                    Text(viewModel.yearSort.rawValue)
                        .padding(7)
                        .padding(.horizontal, 5)
                        .background(
                            Capsule().fill(.white)
                                .overlay(
                                    Capsule().stroke(Color.gray)
                                )
                        )
                        .scaleEffect(isPressedYear ? 0.9 : 1.0) // Добавляем модификатор scaleEffect
                        .animation(.easeInOut(duration: 0.2)) // Добавляем анимацию
                        .onTapGesture {
                            withAnimation { // добавляем анимацию изменения viewModel.yearSort
                                if (viewModel.yearSort == .yearASC){
                                    viewModel.yearSort = .yearDESC
                                } else {
                                    viewModel.yearSort = .yearASC
                                }
                                viewModel.sortList(by: viewModel.yearSort)
                            }
                            isPressedYear = true // устанавливаем флаг, что кнопка была нажата
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // сбрасываем флаг после завершения анимации
                                isPressedYear = false
                            }
                        }
                        .foregroundColor(Color.black)


                    
                    Picker(seleсtedCountry.rawValue,
                           selection: $seleсtedCountry) {
                        ForEach(CarCountryFilter.allCases, id: \.self) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                           .colorMultiply(.black)
                           .pickerStyle(.menu)
                           .padding(.vertical, -5)
                           .encapulate(borderColor: .gray)
                    
                    Picker(selectedFuel.rawValue,
                           selection: $selectedFuel) {
                        ForEach(CarFuelTypeFilter.allCases, id: \.self) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                           .colorMultiply(.black)
                           .pickerStyle(.menu)
                           .padding(.vertical, -5)
                           .encapulate(borderColor: .gray)
                    
                    Picker(selectedEngineCapacity.rawValue,
                           selection: $selectedEngineCapacity) {
                        ForEach(CarEngineCapacityFilter.allCases, id: \.self) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                           .colorMultiply(.black)
                           .pickerStyle(.menu)
                           .padding(.vertical, -5)
                           .encapulate(borderColor: .gray)
                    
                }
                .padding(.vertical, 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width-30, height: 50)
    }
}

