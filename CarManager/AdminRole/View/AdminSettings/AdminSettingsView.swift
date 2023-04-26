//
//  AdminSettingsView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 15.04.23.
//

import SwiftUI

struct AdminSettingsView: View {
    // добавляем состояние (state) для алерта
    @State private var showingLogoutAlert = false
    
    // добавляем presentationMode для доступа к текущему режиму отображения (presentation mode)
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // добавляем кнопку, которая открывает диалоговое окно
            Button(action: {
                self.showingLogoutAlert = true
            }) {
                Text("Выйти из аккаунта")
            }
            .alert(isPresented: $showingLogoutAlert) {
                Alert(title: Text("Вы уверены, что хотите выйти?"), message: nil, primaryButton: .destructive(Text("Выйти")) {
                    // при нажатии на "Выйти" вызываем AuthView
                    self.presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .cancel())
            }
        }
    }
}


struct AdminSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminSettingsView()
    }
}
