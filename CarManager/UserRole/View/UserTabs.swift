//
//  UserTabBar.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 23.04.23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case cars = "car.2"
    case heart = "heart"
    case person = "person"
}

struct UserTabBar: View {
    
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color {
        switch selectedTab {
        case .cars:
            return .red
        case .heart:
            return .blue
        case .person:
            return .green
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColor : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }.frame(width: nil, height: 60)
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.top, 0)
                .padding(.leading)
                .padding(.trailing)
        }
    }
   
}


struct UserTabView_Previews: PreviewProvider {
    static var previews: some View {
        UserTabBar(selectedTab: .constant(.cars))
    }
}
