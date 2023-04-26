//
//  DisclosureGroupHelper.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI

class DisclosureGroupHelper {
    static let shared = DisclosureGroupHelper()
    private init() {}
    
    func handleDisclosureGroupExpansion(_ groupExpanded: Binding<Bool>, otherGroups: [Binding<Bool>]) {
        if groupExpanded.wrappedValue {
            for index in otherGroups.indices {
                if otherGroups[index].wrappedValue {
                    withAnimation {
                        otherGroups[index].wrappedValue = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            groupExpanded.wrappedValue = true
                        }
                    }
                    return
                }
            }
            withAnimation {
                groupExpanded.wrappedValue = true
            }
        }
    }
}
