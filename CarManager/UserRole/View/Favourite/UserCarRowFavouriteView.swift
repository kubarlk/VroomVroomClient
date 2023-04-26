//
//  CarRowFavouriteView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 23.04.23.
//

import SwiftUI

struct CarRowFavouriteView: View {
    let car: UserCar
    
    var body: some View {
        HStack {
            Image(systemName: "car.fill")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(car.brand)
                    .font(.headline)
                Text(car.model)
                    .font(.subheadline)
                Text("$\(car.price)")
                    .font(.subheadline)
            }
        }
    }
}



