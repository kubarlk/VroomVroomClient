//
//  RecommendationsViewModel.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 25.04.23.
//

import SwiftUI
import Combine

class RecommendationsViewModel: ObservableObject {
    
    @Published var logos: [CarLogo] = []
    @Published var isLoadingLogo = false
    private var carService = UserCarService()
    private var cancellableLogos: AnyCancellable?
    
    func fetchLogos() {
        isLoadingLogo = true
        cancellableLogos = carService.getLogos()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoadingLogo = false
                switch completion {
                case .failure(let error):
                    print("Error fetching cars: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] logos in
                self?.logos = logos
            })
    }
}

