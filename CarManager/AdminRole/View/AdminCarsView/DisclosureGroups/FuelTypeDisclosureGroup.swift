//
//  FuelTypeDisclosureGroup.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI

struct FuelTypeDisclosureGroup: View {
    @Binding var selectedFuelType: FuelType?
    @Binding var isFuelTypeExpanded: Bool
    @Binding var isBrandExpanded: Bool
    @Binding var isCarTypeExpanded: Bool
    @Binding var isModelExpanded: Bool
    
    var body: some View {
        DisclosureGroup(
            selectedFuelType != nil ? "Тип топлива: \(selectedFuelType!.rawValue)" : "Выберите тип топлива",
            isExpanded: $isFuelTypeExpanded,
            content: {
                ScrollView {
                    VStack {
                        ForEach(FuelType.allCases, id: \.rawValue) { fuelType in
                            Button(action: {
                                if let currentFuelType = selectedFuelType, currentFuelType == fuelType {
                                    // Если пользователь выбрал тот же тип топлива, который уже был выбран, не делайте ничего
                                    return
                                } else {
                                    // Иначе, выберите новый тип топлива
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        selectedFuelType = fuelType
                                        isFuelTypeExpanded = false
                                    }
                                }
                            }, label: {
                                Text(fuelType.rawValue)
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
            isFuelTypeExpanded.toggle()
        }
        .onChange(of: isFuelTypeExpanded) { value in
            DisclosureGroupHelper.shared.handleDisclosureGroupExpansion($isFuelTypeExpanded, otherGroups: [$isBrandExpanded, $isCarTypeExpanded, $isModelExpanded])
        }
    }
}

