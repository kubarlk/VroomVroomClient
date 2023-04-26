//
//  ModelDisclosureGroup.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI

struct ModelDisclosureGroup: View {
    @Binding var selectedModel: String?
    @Binding var isModelExpanded: Bool
    @Binding var isBrandExpanded: Bool
    @Binding var isCarTypeExpanded: Bool
    @Binding var isFuelTypeExpanded: Bool
    
    let availableModels: [String]
    
    var body: some View {
        DisclosureGroup(
            selectedModel != nil ? "Модель: \(selectedModel!)" : "Выберите модель:",
            isExpanded: $isModelExpanded,
            content: {
                ScrollView {
                    VStack {
                        ForEach(availableModels.prefix(5), id: \.self) { model in
                            Button(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    selectedModel = model
                                    isModelExpanded = false
                                }
                            }, label: {
                                Text(model)
                            })
                            .foregroundColor(.primary)
                            .padding(.vertical, 4)
                        }
                    }
                }
                .frame(height: 120)
            }
        )
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .onTapGesture {
            isModelExpanded.toggle()
        }
        .onChange(of: isModelExpanded) { value in
            DisclosureGroupHelper.shared.handleDisclosureGroupExpansion($isModelExpanded, otherGroups: [$isBrandExpanded, $isCarTypeExpanded, $isFuelTypeExpanded])
        }
    }
}
