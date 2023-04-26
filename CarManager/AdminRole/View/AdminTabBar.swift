//
//  AdminTabBar.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 15.04.23.
//

import SwiftUI

struct AdminTabBar: View {
    var body: some View {
        TabView {
            NavigationView {
                AdminCarsView()
            }
            .tabItem {
                Image(systemName: "car")
                Text("Cars")
            }
            NavigationView {
                AdminSettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}


struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabBar()
    }
}
