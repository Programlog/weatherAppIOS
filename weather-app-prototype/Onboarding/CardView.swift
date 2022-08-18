//
//  CardView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 8/1/22.
//

import SwiftUI

struct CardView: View {
    var onBoardingData: WeatherOnboarding
    
    @State private var isAnimating: Bool = false
//    MARK: Body

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
    //            Fruit: Image
//                Image("noAds")
                onBoardingData.image
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .foregroundColor(.white)
                    .scaleEffect(isAnimating ? 1.0: 0.6)
                    .frame(width: 155, height: 155, alignment: .center)
                    .padding(.bottom, 45)
    //            Fruit: Title
                Text(onBoardingData.title)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
    //            Fruit Headline
                Text(onBoardingData.headline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: 480)
    //            Button: Start
                StartButtonView()
            }//: VStack
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: onBoardingData.gradientColors), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal, 20)

        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(onBoardingData: OnboardingData[3])
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
