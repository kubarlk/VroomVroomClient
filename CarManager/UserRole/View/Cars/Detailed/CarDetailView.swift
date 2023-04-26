//
//  CarDetailView.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 19.04.23.
//

import SwiftUI
import Kingfisher
import UserNotifications

struct CarDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let car: UserCar
    @State private var showDetailedImages = false
    @State private var isRentCarViewPresented = false
    @State private var currentPage = 0
    @State private var isFavorite = false

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    if showDetailedImages {
                        HorizontalImageCollection(images: car.detailedImages)
                            .padding()
                            .opacity(showDetailedImages ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5))
                    }
                    KFImage(URL(string: car.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 16)
                        .shadow(radius: 10)
                        .padding(.horizontal, 32)
                        .opacity(showDetailedImages ? 0 : 1)
                        .animation(.easeInOut(duration: 0.5))
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        showDetailedImages.toggle()
                    }) {
                        Text("Дополнительные изображения")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                                    .scaleEffect(showDetailedImages ? 1 : 0)
                                    .opacity(showDetailedImages ? 1 : 0)
                                    .animation(.easeInOut(duration: 0.3))
                            )
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("\(car.brand) \(car.model)")
                            .font(.title)
                            .bold()
                            .padding(.leading, 32)
                        Spacer()
                        Button(action: {
                            isFavorite.toggle()
                            if isFavorite {
                                // Add the user car entity to Core Data
                                CoreDataManager.shared.saveUserCar(car)
                            } else {
                                // Remove the user car entity from Core Data
                                CoreDataManager.shared.deleteUserCar(withId: car.id ?? UUID())
                            }
                            // Save the state of the button to UserDefaults
                            guard let carID = car.id else { return }
                            UserDefaults.standard.set(isFavorite, forKey: "isFavoriteButtonState\(carID)")
                        }) {
                            if isFavorite {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "heart")
                                    .foregroundColor(.red)
                            }
                        }
                        .onAppear {
                            // Set the initial state of the button based on the value in UserDefaults
                            guard let carID = car.id else { return }
                            if let isFavoriteButtonState = UserDefaults.standard.object(forKey: "isFavoriteButtonState\(carID)") as? Bool {
                                isFavorite = isFavoriteButtonState
                            }
                        }

                        .padding(.trailing, 32)
                    }
                    
                    HStack {
                        Text("Цена")
                            .font(.headline)
                        Spacer()
                        Text("\(car.price) $")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 32)
                    Divider()
                    HStack {
                        Text("Тип")
                            .font(.headline)
                        Spacer()
                        Text("\(car.type)")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 32)
                    Divider()
                    HStack {
                        Text("Тип топлива")
                            .font(.headline)
                        Spacer()
                        Text("\(car.typeOfFuel)")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 32)
                    Divider()
                    HStack {
                        Text("Объем двигателя")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "%.1f л", car.engineCapacity))
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 32)
                    Divider()
                }



            }
            VideoPlayerEmbed(videoID: car.videoUrl)
                .padding(.top, 20)
        } .scrollIndicators(.hidden)
        
        if !car.isBooking {
            Button(action: {
                isRentCarViewPresented.toggle()
            }) {
                Text("Заказать авто")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
            }
            .padding(.bottom, 10)
            .sheet(isPresented: $isRentCarViewPresented, onDismiss: {
                presentationMode.wrappedValue.dismiss()
            }) {
                RentCarView(car: car)
            }
        } else {
            VStack(spacing: 20) {
                Text("Автомобиль забронирован")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                Button(action: {
                    // Add code to send a notification when the car becomes available
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                   
                    }
                }) {
                    Text("Уведомить меня")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 10)
            }
        }
    }
}



























//                VStack(alignment: .leading, spacing: 16) {
//                    HStack {
//                        Text("\(car.brand) \(car.model)")
//                            .font(.title)
//                            .bold()
//                        Spacer()
//                        Text("\(car.price) $")
//                            .font(.subheadline)
//                    }.padding(.leading, 32)
//                    Divider()
//                    HStack {
//                        Text("Тип")
//                            .font(.headline)
//                        Spacer()
//                        Text("\(car.type)")
//                            .font(.subheadline)
//                    }.padding(.horizontal, 32)
//                    Divider()
//                    HStack {
//                        Text("Тип топлива")
//                            .font(.headline)
//                        Spacer()
//                        Text("\(car.typeOfFuel)")
//                            .font(.subheadline)
//                    }.padding(.horizontal, 32)
//                    Divider()
//                    HStack {
//                        Text("Объем двигателя")
//                            .font(.headline)
//                        Spacer()
//                        Text(String(format: "%.1f л", car.engineCapacity))
//                            .font(.subheadline)
//                    }.padding(.horizontal, 32)
//                }

