//
//  LogoCarousel.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 24.04.23.
//

import SwiftUI
import Kingfisher

struct LogoCarousel: View {
    
    @State private var isShowingCarsByBrandView = false
    @State private var selectedLogo: CarLogo? = nil
    let logos: [CarLogo]
    let simpleCars: [UserCar]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(logos, id: \.imageUrl) { logo in
                    GeometryReader { proxy in
                        let scale = getScale(proxy: proxy)
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 56, height: 56)
                            KFImage(URL(string: "\(logo.imageUrl)"))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .clipped()
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedLogo = logo
                                        isShowingCarsByBrandView.toggle()
                                    }
                                }
                                .scaleEffect(selectedLogo == logo ? 0.8 : 1.0)
                        }
                        .scaleEffect(.init(width: scale, height: scale))
                        .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0))
                        .padding(.vertical, 2)
                        .padding(.leading)
                        .offset(y: 0)
                    }
                    .frame(width: UIScreen.main.bounds.width/5 - 4, height: 60)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                }
                Spacer().frame(width: 8)
            }
        }


        .sheet(item: $selectedLogo) { logo in
            let carsByBrand = simpleCars.filter { $0.brand == logo.brand }
            CarsByBrandView(cars: carsByBrand, logo: logo, logos: logos)
               
        }
    }
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 65
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXnimationThreshold: CGFloat = 65
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXnimationThreshold/2)
        if diffFromCenter < deltaXnimationThreshold {
            scale = 1 + (deltaXnimationThreshold - diffFromCenter) / 180
        }
        
        return scale
    }
}
