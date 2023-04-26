//
//  AdminAddCarView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 16.04.23.
//

import SwiftUI
import Combine

struct AdminAddCarView: View {
    
    @State private var error: Error?
    @Environment(\.presentationMode) var presentationMode
    @State var price: Int? = nil
    @State var model: String = ""
    @State var imageUrl: String = ""
    @State var engineCapacity: Double? = nil
    @State var brand: CarBrand?
    @State var year: String = ""
    @State var typeOfFuel: FuelType?
    @State var type: CarType?
    
    @State private var selectedBrand: CarBrand?
    @State private var selectedModel: String?
    @State private var selectedFuelType: FuelType?
    @State private var selectedCarType: CarType?
    @State private var isBrandExpanded: Bool = false
    @State private var isModelExpanded: Bool = false
    @State private var isFuelTypeExpanded: Bool = false
    @State private var isCarTypeExpanded: Bool = false
    @State private var previousSelectedBrand: CarBrand?
    
    private var availableModels: [String] {
        guard let brand = selectedBrand else {
            return []
        }
        switch brand {
        case .bmw:
            return BMWModel.allCases.map { $0.rawValue }
        case .mercedes:
            return MercedesModel.allCases.map { $0.rawValue }
        default:
            return []
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Добавить автомобиль")
                .font(.largeTitle)
                .padding(.top, 10)
            ScrollView {
                BrandDisclosureGroup(
                    selectedBrand: $selectedBrand,
                    isBrandExpanded: $isBrandExpanded,
                    isCarTypeExpanded: $isCarTypeExpanded,
                    isModelExpanded: $isModelExpanded,
                    isFuelTypeExpanded: $isFuelTypeExpanded,
                    selectedModel: $selectedModel,
                    selectedCarType: $selectedCarType,
                    selectedFuelType: $selectedFuelType,
                    price: $price,
                    year: $year,
                    imageUrl: $imageUrl )
                
                // Добавляем условие для показа списка моделей только в случае, если выбран бренд
                if let _ = selectedBrand, !availableModels.isEmpty {
                    ModelDisclosureGroup(
                        selectedModel: $selectedModel,
                        isModelExpanded: $isModelExpanded,
                        isBrandExpanded: $isBrandExpanded,
                        isCarTypeExpanded: $isCarTypeExpanded,
                        isFuelTypeExpanded: $isFuelTypeExpanded,
                        availableModels: availableModels )
                    
                    TextField("Цена, $", text: Binding<String>(
                        get: { self.price != nil ? String(self.price!) : "" },
                        set: { self.price = Int($0) }
                    ))
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .foregroundColor(Color.black)
                    .cornerRadius(20)
                    .padding()
                    TextField("Объем двигателя, л", text: Binding<String>(
                        get: { self.engineCapacity != nil ? String(self.engineCapacity!) : "" },
                        set: { self.engineCapacity = Double($0) }
                    ))
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .foregroundColor(Color.black)
                    .cornerRadius(20)
                    .padding()
                    TextField("Год", text: $year)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .foregroundColor(Color.black)
                        .cornerRadius(20)
                        .padding()
                    FuelTypeDisclosureGroup(
                        selectedFuelType: $selectedFuelType,
                        isFuelTypeExpanded: $isFuelTypeExpanded,
                        isBrandExpanded: $isBrandExpanded,
                        isCarTypeExpanded: $isCarTypeExpanded,
                        isModelExpanded: $isModelExpanded )
                    
                    CarTypeDisclosureGroup(
                        selectedCarType: $selectedCarType,
                        isCarTypeExpanded: $isCarTypeExpanded,
                        isBrandExpanded: $isBrandExpanded,
                        isFuelTypeExpanded: $isFuelTypeExpanded,
                        isModelExpanded: $isModelExpanded )
                    TextField("Вставьте ссылку на картинку", text: $imageUrl)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .foregroundColor(Color.black)
                        .cornerRadius(20)
                        .padding()
                }
            }.scrollIndicators(.hidden)
            Button(action: {
                let carService = AdminCarService()
                let car = AdminCar(price: price ?? 0, model: selectedModel ?? "", imageUrl: imageUrl, engineCapacity: engineCapacity ?? 0.0, brand: selectedBrand?.rawValue ?? "", year: year, typeOfFuel: selectedFuelType?.rawValue ?? "", type: selectedCarType?.rawValue ?? "")
                Task {
                    do {
                       let data = try await carService.createCar(carModel: car)
                        print(data)
                    } catch {
                        // Display an alert if the password is incorrect
                        print("Ошибки")
                    }
                }
                print("Добавить")
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Добавить автомобиль")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
            }).padding(.bottom, 10)
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct AdminAddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAddCarView()
    }
}

enum FuelType: String, CaseIterable {
    case gasoline = "gasoline"
    case diesel = "diesel"
    case gas = "gas"
    case electric = "electric"
}

enum CarType: String, CaseIterable {
    case sedan = "Седан"
    case wagon = "wagon"
    case hatchback = "Хэтчбэк"
}

enum CarBrand: String, CaseIterable {
    case bmw = "BMW"
    case mercedes = "Mercedes Benz"
    case audi = "Audi"
    case skoda = "Skoda"
    case porshe1 = "Porshe"
    case porshe2 = "Poqrsshe"
    case porshe3 = "Porasshe"
    case porshe4 = "Poqwrshe"
    case porshe5 = "Porsfshe"
    case porshe6 = "Porsshe"
    case porshe7 = "Porashe"
}

enum BMWModel: String, CaseIterable {
    case fiveSeries = "5 серия"
    case fivseSeries = "5 ыфвсерия"
    case fiveasdSeries = "5 fыфвсерия"
    case fivesdSeries = "5ыф серия"
    case fivefsaSeries = "5 сasерия"
}

enum MercedesModel: String, CaseIterable {
    case eClass = "eClass"
}

