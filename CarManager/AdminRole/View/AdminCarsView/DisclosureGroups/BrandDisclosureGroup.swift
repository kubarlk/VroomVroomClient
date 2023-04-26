//
//  BrandDisclosureGroup.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI

struct BrandDisclosureGroup: View {
    @Binding var selectedBrand: CarBrand?
    @Binding var isBrandExpanded: Bool
    @Binding var isCarTypeExpanded: Bool
    @Binding var isModelExpanded: Bool
    @Binding var isFuelTypeExpanded: Bool
    @Binding var selectedModel: String?
    @Binding var selectedCarType: CarType?
    @Binding var selectedFuelType: FuelType?
    @Binding var price: Int?
    @Binding var year: String
    @Binding var imageUrl: String
    
    let availableBrands = CarBrand.allCases
    
    var body: some View {
        DisclosureGroup(
            selectedBrand != nil ? "Бренд: \(selectedBrand!.rawValue)" : "Выберите бренд",
            isExpanded: $isBrandExpanded,
            content: {
                ScrollView {
                    VStack {
                        ForEach(availableBrands.prefix(5), id: \.rawValue) { brand in
                            Button(action: {
                                if let currentBrand = selectedBrand, currentBrand == brand {
                                    // Если пользователь выбрал тот же бренд, который уже был выбран, не делайте ничего
                                    return
                                } else {
                                    // Иначе, сбросьте выбранную модель и выберите новый бренд
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        selectedBrand = brand
                                        selectedModel = nil
                                        selectedCarType = nil
                                        selectedFuelType = nil
                                        price = nil
                                        imageUrl = ""
                                        year = ""
                                        isBrandExpanded = false
                                    }
                                }
                            }, label: {
                                Text(brand.rawValue)
                            })
                            .foregroundColor(.primary)
                            .padding(.vertical, 8)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(height: 200)
                .padding(.top, 10)
            }
        )
        .padding(.horizontal, 20)
        .padding(.top, 30)
        .onTapGesture {
            isBrandExpanded.toggle()
        }
        .onChange(of: isBrandExpanded) { value in
            DisclosureGroupHelper.shared.handleDisclosureGroupExpansion($isBrandExpanded, otherGroups: [$isCarTypeExpanded, $isModelExpanded, $isFuelTypeExpanded])
        }
    }
}
