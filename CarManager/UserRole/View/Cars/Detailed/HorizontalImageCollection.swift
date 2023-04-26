//
//  HorizontalImageCollection.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 20.04.23.
//

import SwiftUI
import Kingfisher

struct HorizontalImageCollection: View {
    let images: [String]

    @State private var currentIndex = 0

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(images, id: \.self) { imageUrl in
                            KFImage(URL(string: imageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        }
                    }
                }
                .content.offset(x: CGFloat(currentIndex) * -geometry.size.width)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .animation(.spring())
            }
            .frame(height: 200)

            HStack {
                if currentIndex > 0 {
                    Button(action: {
                        withAnimation {
                            currentIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .regular))
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 4)
                    }
                    .transition(.scale)
                    .padding(.leading, 10)
                } else {
                    Spacer()
                }

                Spacer()

                HStack(spacing: 8) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Circle()
                            .fill(currentIndex == index ? Color.black : Color.gray)
                            .frame(width: 8, height: 8)
                            .scaleEffect(currentIndex == index ? 1.5 : 1)
                            .animation(.spring())
                            .onTapGesture {
                                currentIndex = index
                            }
                    }
                }
                
                Spacer()

                if currentIndex < images.count - 1 {
                    Button(action: {
                        withAnimation {
                            currentIndex += 1
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .regular))
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 4)
                    }
                    .transition(.scale)
                    .padding(.trailing, 10)
                } else {
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
        .onChange(of: currentIndex) { newValue in
            if newValue == images.count {
                currentIndex = images.count - 1
            } else if newValue < 0 {
                currentIndex = 0
            }
        }
    }
}






struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = UIColor.systemBlue
        pageControl.pageIndicatorTintColor = UIColor.systemGray
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}

struct HorizontalImageCollection_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalImageCollection(images: [
            "https://s8d2.turboimg.net/sp/c43bac49a519bdeba7673d5e4c306309/astra-l-tmb-550x300-removebg-preview.png?69941",
            "https://s8d3.turboimg.net/sp/ea446fffc52dc2268ffa44558f0041c6/3578856.png?24295",
            "https://s8d4.turboimg.net/sp/e6790e98c5da5741b224bb0d524c8661/2559195.png?14263",
            "https://s8d7.turboimg.net/sp/23102fed016f347b29b65cc369031fc5/2831454.png?21179"
        ])
    }
}

