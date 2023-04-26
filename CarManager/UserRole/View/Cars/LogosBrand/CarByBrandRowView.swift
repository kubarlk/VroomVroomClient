//
//  CarByBrandRowView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 20.04.23.
//

import SwiftUI
import Kingfisher

struct CarByBrandRowView: View {
    
    let car: UserCar
    @State private var isDetailViewPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: "\(car.imageUrl)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(car.model)
                    .font(.headline)
                    .foregroundColor(.black)
                
                HStack {
                    Text(car.type)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("\(car.year)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("\(car.typeOfFuel), \(car.engineCapacity)L")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text("\(car.price) ₽")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 0)
        .onTapGesture {
                isDetailViewPresented.toggle()
               
        }
        .sheet(isPresented: $isDetailViewPresented) {
            CarDetailView(car: car)
        }
    }
}
