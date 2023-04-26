//
//  CarListView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI
import Kingfisher

struct CarListView: View {
    
    let sortedCars: [AdminCar]
    let searchText: String
    
    var filteredCars: [AdminCar] {
        sortedCars.filter({ searchText.isEmpty ? true : $0.brand.contains(searchText) || $0.model.contains(searchText) })
    }
    
    var body: some View {
        List(filteredCars) { car in
            HStack {
                KFImage(URL(string: car.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                VStack(alignment: .leading) {
                    Text("\(car.brand) \(car.model)")
                        .font(.headline)
                    Text("Год: \(car.year)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(String(format: "Объем двигателя: %.1f л", car.engineCapacity))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Тип кузова: \(car.type)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Топливо: \(car.typeOfFuel)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Цена: \(car.price) $")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
