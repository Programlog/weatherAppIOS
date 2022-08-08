import SwiftUI

struct HomeView2: View {
    @State private var isAnimating: Bool = false
    @AppStorage("isCurrentLocation") var isCurrentLocation: Bool = false
    @StateObject private var forecastListVM = ForecastListViewModel()

    
    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: getColors(description: forecastListVM.forecasts?.forecast.current.weather[0].icon ?? "x")), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            
            
                ScrollView(.vertical, showsIndicators: false) {
//                    HStack {
////                                                 button
//                    }
                    
                    VStack {
                        cityTextView(cityName: forecastListVM.forecasts?.cityName ?? "Princeton")
                            .opacity(isAnimating ? 1: 0.1)
                            .offset(y:isAnimating ? 0 : 15)
                            .animation(.easeInOut(duration: 0.7), value: isAnimating)
                        MainWeatherStatusView(systemIcon: forecastListVM.forecasts?.currentSystemImage ?? "sun.max.fill", temperature: forecastListVM.forecasts?.currentTemp ?? "--")
                            .opacity(isAnimating ? 1: 0.3)
                            .animation(.easeOut(duration: 1), value: isAnimating)
                        VStack {
                            Text(forecastListVM.forecasts?.currentTemp ?? "nil temp")
                                .fontWeight(.bold)
                                .padding()
                            
                            Text("\(forecastListVM.forecasts?.forecast.lat ?? -1)")
                            Text("\(forecastListVM.forecasts?.forecast.lon ?? -1)")

                        }
                    }
                }.onAppear(perform: {
                    isAnimating = true
            })
        }
    }
    func getColors(description: String) -> [Color] {
            if description == "03d" || description == "04d" || description == "50d" || description == "50n" || description == "03n" || description == "04n" || description == "13d" || description == "13n"{
                    return [Color("CloudyBackground"), Color("CloudyBackground2")]
            } else if description == "01d" {
                    return [Color("darkBlue"), Color("lightBlue")]
            } else if description == "01n" {
                return [Color("NightBackground2"), Color("NightBackground")]
            } else if description == "02d" {
                return [Color("darkBlue"), Color("CloudyBackground")]
            } else if description == "02n" {
                return [Color("NightBackground"), Color("CloudyBackground2")]
            } else if description == "09d" || description == "11d" {
                return [Color("CloudyBackground2"), Color.gray]
            } else if description == "09n" || description == "11n" {
                return [Color("CloudyBackground"), Color("NightBackground")]
            } else  {
                return [Color.gray, Color.gray]
            }
    }

}
    
//    func convertTime(epoch:Int, shift:Int = 0) -> String {
//        print(epoch)
//        print(shift)
//        let date = NSDate(timeIntervalSince1970: TimeInterval(epoch+shift))
//        let dayTimePeriodFormatter = DateFormatter()
//        dayTimePeriodFormatter.dateFormat = "h:mm a"
//
//        let dateString = dayTimePeriodFormatter.string(from: date as Date)
//
//        return dateString
//    }



struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2(isCurrentLocation: true)
    }
}
//
//struct BackgroundView: View {
//    var icon: String
//    var body: some View {
//        return getColors(description: icon)
//        LinearGradient(gradient: Gradient(colors: [colors[0], colors[1]]), startPoint: .topLeading, endPoint:.bottomTrailing).edgesIgnoringSafeArea(.all)
//
//    }

//    func getColors(description: String) -> [Color] {
//        if description == "03d" || description == "04d" || description == "50d" || description == "50n" || description == "03n" || description == "04n" || description == "13d" || description == "13n"{
//                return [Color("CloudyBackground"), Color("CloudyBackground2")]
//        } else if description == "01d" {
//                return [Color("darkBlue"), Color("lightBlue")]
//        } else if description == "01n" {
//            return [Color("NightBackground2"), Color("NightBackground")]
//        } else if description == "02d" {
//            return [Color("darkBlue"), Color("CloudyBackground")]
//        } else if description == "02n" {
//            return [Color("NightBackground"), Color("CloudyBackground2")]
//        } else if description == "09d" || description == "11d" {
//            return [Color("CloudyBackground2"), Color.gray]
//        } else if description == "09n" || description == "11n" {
//            return [Color("CloudyBackground"), Color("NightBackground")]
//        } else  {
//            return [Color("NightBackground"), Color("darkBlue")]
//        }
//    }
//}
//
struct cityTextView: View {
    var cityName: String

    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
//            .padding(.top, -18)
            .shadow(color: Color("ColorBlackTransparentDark"), radius: 8, x: 0, y: 3)
    }
}

struct MainWeatherStatusView: View {
    var systemIcon: String
    var temperature: String

    var body: some View {
        VStack (spacing:10) {
            Image(systemName: systemIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 140)

            Text(temperature)
                .font(.system(size: 70, weight: .semibold))
                .foregroundColor(.white)
                .padding(.top, 15)
        }
        .padding(.bottom, 80)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 10, x: 0, y: 5)
    }
}
//
//struct WeatherDayView: View {
//    var dayOfWeek: String
//    var imageName: String
//    var temperature: Int
//
//    var body: some View {
//        VStack {
//            Text(dayOfWeek)
//                .font(.system(size: 17, weight: .medium))
//                .foregroundColor(.white)
//
//            Image(systemName: imageName)
//                .renderingMode(.original)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 45, height: 45)
//
//            Text("\(temperature)")
//                .font(.system(size: 28, weight: .medium))
//                .foregroundColor(.white)
//        }
//        .shadow(color: Color("ColorBlackTransparentLight"), radius: 5, x: 0, y: 2)
//    }
//}
//

