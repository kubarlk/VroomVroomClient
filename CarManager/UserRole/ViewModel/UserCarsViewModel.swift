//
//  UserCarsViewModel.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI
import Combine
import OrderedCollections

class UserCarsViewModel: ObservableObject {
    
    @Published var cars: OrderedDictionary<CarCategory, [UserCar]> = [:]
    @Published var isLoading = false
    private var carService = UserCarService()
    private var cancellable: AnyCancellable?
    
    func fetchCars() {
        isLoading = true
        cancellable = carService.getCars()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error fetching cars: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] cars in
                var updatedCars = self?.cars ?? [:] // create a mutable copy of the current dictionary
                
                // loop through the array of AdminCar objects and add them to the appropriate category in the dictionary
                for car in cars {
                    guard let category = CarCategory(rawValue: car.type) else {
                        // if the car's type doesn't match any category, skip it
                        continue
                    }
                    updatedCars[category, default: []].append(car)
                }
                self?.cars = updatedCars // assign the updated dictionary back to the published property
            })
    }
    
    func sortCars(by criteria: String) -> OrderedDictionary<CarCategory, [UserCar]> {
        var sortedCars = OrderedDictionary<CarCategory, [UserCar]>()
        
        // Перебираем все категории машин
        for (category, cars) in cars {
            // Сортируем массив машин в каждой категории по выбранному критерию
            var sortedCarsInCategory: [UserCar]
            if criteria == "price" {
                sortedCarsInCategory = cars.sorted { $0.price < $1.price }
            } else if criteria == "year" {
                sortedCarsInCategory = cars.sorted { $0.year < $1.year }
            } else {
                // Если критерий неизвестен, просто копируем массив машин без сортировки
                sortedCarsInCategory = cars
            }
            
            // Добавляем отсортированный массив машин в отсортированный словарь
            sortedCars[category] = sortedCarsInCategory
        }
        
        return sortedCars
    }

    deinit {
        cancellable?.cancel()
    }
}

enum CarCategory: String, CaseIterable {
    case sedans = "Седаны"
    case wagons = "Универсалы"
    case liftbacks = "Лифтбэки"
    case hatchbacks3doors = "Хэтчбэки, 3 дв."
    case hatchbacks5doors = "Хэтчбэки, 5 дв."
    case coupe = "Купе"
    case minivans = "Минивэны"
    case suv3doors = "Внедорожники, 3 дв."
    case suv5doors = "Внедорожники, 5 дв."
    case convertibles = "Кабриолеты"
    case passengerVans = "Легковые фургоны"
    case limousines = "Лимузины"
    case cargoAndPassengerMinibus = "Микроавтобусы грузопассажирские"
    case passengerMinibus = "Микроавтобусы пассажирские"
    case pickups = "Пикапы"
    case roadsters = "Роадстеры"
}
