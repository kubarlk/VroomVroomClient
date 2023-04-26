//
//  HorizontalCarListView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI

struct HorizontalCarListView: View {
    let title: String
    let cars: [UserCar]
    
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            Text(title)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(cars) { car in
                        CarRowView(car: car)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .fixedSize()
                            .padding()
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

