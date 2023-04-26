//
//  CarRowView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI
import Kingfisher

struct CarRowView: View {
    let car: UserCar
    @State private var isDetailViewPresented = false
    @State private var isTapped = false
    
    var body: some View {
        VStack() {
            Text(car.brand)
                .font(.headline)
                .padding(.bottom, 5)
                .frame(alignment: .center)
            Text(car.model)
                .font(.subheadline)
                .frame(alignment: .center)
            
            KFImage(URL(string: car.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Цена: \(car.price) $")
                        .font(.subheadline)
                    Text("Год: \(car.year)")
                        .font(.subheadline)
                    Text("Тип топлива: \(car.typeOfFuel)")
                        .font(.subheadline)
                    Text(String(format: "Объем двигателя: %.1f л", car.engineCapacity))
                        .font(.subheadline)
                    Text("Страна: \(car.country)")
                        .font(.subheadline)
                }
                
                Spacer()
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .scaleEffect(isTapped ? 0.9 : 1.0) // применяем анимацию шкалы на изменение размера
        .onTapGesture {
            withAnimation(.spring()) { // применяем анимацию пружинного типа при нажатии на ячейку
                isTapped.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isDetailViewPresented.toggle()
                isTapped = false
            }
        }
        .sheet(isPresented: $isDetailViewPresented) {
            CarDetailView(car: car)
        }
    }
}


