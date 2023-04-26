//
//  RentCarView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 23.04.23.
//

import SwiftUI

struct RentCarView: View {
    @EnvironmentObject var viewModel: UserCarsViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var rentalDuration: Int = 1 // выбранное количество дней аренды
    @State private var insuranceEnabled: Bool = false // включена ли страховка
    @State private var additionalEquipment: Set<String> = [] // выбранное дополнительное оборудование
    @State private var pickupLocation = "airport"
    @State private var additionalDriverEnabled = false
    @State private var showConfirmationAlert = false
    
    let car: UserCar // переданный объект машины
    
    var body: some View {
        VStack {
            Text("Аренда авто: \(car.brand) - \(car.model)")
                .font(.title)
                .padding()
            
            Stepper(value: $rentalDuration, in: 1...30) {
                Text("Количество дней аренды: \(rentalDuration)")
            }
            .padding()
            
            Toggle(isOn: $insuranceEnabled) {
                Text("Страховка")
            }
            .padding()
            
            Toggle(isOn: $additionalDriverEnabled) {
                Text("Дополнительный водитель")
            }
            .padding()
            
            Group {
                HStack {
                    CheckBoxView(title: "Детское кресло", isSelected: additionalEquipment.contains("Детское кресло")) { isSelected in
                        if isSelected {
                            additionalEquipment.insert("Детское кресло")
                        } else {
                            additionalEquipment.remove("Детское кресло")
                        }
                    }
                    CheckBoxView(title: "GPS", isSelected: additionalEquipment.contains("GPS")) { isSelected in
                        if isSelected {
                            additionalEquipment.insert("GPS")
                        } else {
                            additionalEquipment.remove("GPS")
                        }
                    }
                    CheckBoxView(title: "Доп. багажник", isSelected: additionalEquipment.contains("Доп. багаж")) { isSelected in
                        if isSelected {
                            additionalEquipment.insert("Доп. багажник")
                        } else {
                            additionalEquipment.remove("Доп. багажник")
                        }
                    }
                }
                .padding()
            }
            
            Button(action: {
                
                self.showConfirmationAlert = true
            }) {
                Text("Арендовать за \(calculatePrice(for: car.carClass))")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .alert(isPresented: $showConfirmationAlert) {
                Alert(title: Text("Успешно арендовано!"), message: nil, dismissButton: .default(Text("OK"), action: {
                    // Закрываем окно
                    Task {
                        let updatedCar = UserCar(price: car.price, model: car.model, imageUrl: car.imageUrl, engineCapacity: car.engineCapacity, brand: car.brand, year: car.year, typeOfFuel: car.typeOfFuel, type: car.type, detailedImages: car.detailedImages, videoUrl: car.videoUrl, country: car.country, isBooking: true, carClass: car.carClass)
                        do {
                            try await viewModel.updateUserCar(carID: car.id, updatedCar: updatedCar)
                          
                        } catch {
                            // Display an alert if the password is incorrect
                            print("Ошибки")
                        }
                    }
                    self.showConfirmationAlert = false
                    presentationMode.wrappedValue.dismiss()
                }))
            }
        }
    }
    
    private func calculatePrice(for carClass: String) -> String {
        var price: Double = 0.0
        
        switch carClass {
        case "Эконом":
            price = 10.0 * Double(rentalDuration)
        case "Комфорт":
            price = 15.0 * Double(rentalDuration)
        case "Премиум":
            price = 20.0 * Double(rentalDuration)
        default: price = 10.0 * Double(rentalDuration)
        }
        
        if insuranceEnabled {
            price += 20
        }
        
        if additionalDriverEnabled {
            price += Double(rentalDuration * 30)
        }
        price += Double(additionalEquipment.count) * 5
        
        return String(format: "%.2f $", price)
    }
}

struct CheckBoxView: View {
    let title: String
    let isSelected: Bool
    let onSelect: (Bool) -> Void
    
    var body: some View {
        Button(action: {
            onSelect(!isSelected)
        }) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(isSelected ? .blue : .gray)
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .padding(10)
        }
    }
}
