//
//  CarTypeDisclosureGroup.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI

struct CarTypeDisclosureGroup: View {
    @Binding var selectedCarType: CarType?
    @Binding var isCarTypeExpanded: Bool
    @Binding var isBrandExpanded: Bool
    @Binding var isFuelTypeExpanded: Bool
    @Binding var isModelExpanded: Bool
    
    var body: some View {
        DisclosureGroup(
            selectedCarType != nil ? "Тип кузова: \(selectedCarType!.rawValue)" : "Выберите тип кузова",
            isExpanded: $isCarTypeExpanded,
            content: {
                ScrollView {
                    VStack {
                        ForEach(CarType.allCases, id: \.rawValue) { carType in
                            Button(action: {
                                if let currentCarType = selectedCarType, currentCarType == carType {
                                    // Если пользователь выбрал тот же тип кузова, который уже был выбран, не делайте ничего
                                    return
                                } else {
                                    // Иначе, выберите новый тип кузова
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        selectedCarType = carType
                                        isCarTypeExpanded = false
                                    }
                                }
                            }, label: {
                                Text(carType.rawValue)
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
            isCarTypeExpanded.toggle()
        }
        .onChange(of: isCarTypeExpanded) { value in
            DisclosureGroupHelper.shared.handleDisclosureGroupExpansion($isCarTypeExpanded, otherGroups: [$isBrandExpanded, $isModelExpanded, $isFuelTypeExpanded])
        }
    }
}
