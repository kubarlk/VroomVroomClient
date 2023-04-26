//
//  UserCarsView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 16.04.23.
//
import OrderedCollections
import SwiftUI
import Kingfisher

struct UserCarsView: View {
    
    @ObservedObject var viewModel = UserCarsViewModel()
    @State private var showFilters = false
    @State private var isShowingCarsByBrandView = false
    @State private var selectedLogo: CarLogo? = nil
    @State private var filtersViewOpacity = 0.0
    var body: some View {
        VStack {
            Text("Наш автопарк")
                .font(.title)
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(viewModel.logos, id: \.imageUrl) { logo in
                        VStack {
                            KFImage(URL(string: "\(logo.imageUrl)"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 48, height: 48)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(16)
                                .shadow(radius: 8)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedLogo = logo
                                        isShowingCarsByBrandView.toggle()
                                    }
                                }
                                .scaleEffect(selectedLogo == logo ? 0.8 : 1.0)
                            
                        }
                        .padding(.vertical, 16)
                    }
                }
                .padding(.leading)
            }
            .sheet(item: $selectedLogo) { logo in
                let carsByBrand = viewModel.simpleCars.filter { $0.brand == logo.brand }
                CarsByBrandView(cars: carsByBrand, logo: logo, logos: viewModel.logos)
            }
            Divider()
            VStack {
                HStack {
                    TextField("Поиск", text: $viewModel.searchText)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    Button(action: {
                        withAnimation {
                            showFilters.toggle()
                        }
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
                
                if showFilters {
                    FiltersView(seleсtedCountry: $viewModel.selectedCountry, selectedFuel: $viewModel.selectedFuel, selectedEngineCapacity: $viewModel.selectedEngineVolume)
                        .environmentObject(viewModel)
                        .opacity(filtersViewOpacity)
                        .transition(.opacity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                self.filtersViewOpacity = 1.0
                            }
                        }
                }
            }
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(CarCategory.allCases, id: \.self) { category in
                        if let categoryCars = viewModel.filteredCars[category], !categoryCars.isEmpty {
                            HorizontalCarListView(title: category.rawValue, cars: categoryCars)
                        }
                    }
                }.padding()
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.fetchCars()
            viewModel.fetchLogos()
        }
    }
    
   
}

struct UserCarsView_Previews: PreviewProvider {
    static var previews: some View {
        UserCarsView()
    }
}
