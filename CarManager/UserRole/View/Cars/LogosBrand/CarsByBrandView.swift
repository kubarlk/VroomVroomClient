//
//  CarsByBrandView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 20.04.23.
//

import SwiftUI

struct CarsByBrandView: View {
    let cars: [UserCar]
    let logo: CarLogo
    let logos: [CarLogo]
    
    var body: some View {
        VStack {
            Text(logo.brand)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 16)
            if cars.isEmpty {
                NotFoundView()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(cars) { car in
                            CarByBrandRowView(car: car)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}
