import SwiftUI
import HalfASheet
import PartialSheet
import PartialSheet

struct HomeView2: View {
    @State private var isAnimating: Bool = false
    @AppStorage("isCurrentLocation") var isCurrentLocation: Bool = false
    @StateObject var forecastListVM = ForecastListViewModel()
    @State var isBottomSheet: Bool = false

    @State private var amount = 0.0

    
    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: getColors(description: forecastListVM.forecasts?.forecast.current.weather[0].icon ?? "x")), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
                ScrollView(.vertical, showsIndicators: false) {
//                    HStack {
//                    }
                    
                    VStack {
                        cityTextView(cityName: forecastListVM.forecasts?.cityName ?? "Princeton")
                            .opacity(isAnimating ? 1: 0.1)
                            .offset(y:isAnimating ? 0 : 15)
                            .animation(.easeInOut(duration: 0.7), value: isAnimating)
                        MainWeatherStatusView(Current: forecastListVM.forecasts?.Current ?? ["--", "-- %", "--", " -- mph", "-:-- AM", "-:-- PM", "", "hourglass.bottomhalf.filled"], isBottomSheet: $isBottomSheet)
                            .opacity(isAnimating ? 1: 0.3)
                            .animation(.easeOut(duration: 1), value: isAnimating)
                        
                        HStack(spacing:25) {
                            WeatherDayView(dayOfWeek: "TUE",
                                           imageName: forecastListVM.forecasts?.dailySystemImages[0] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.dailyTemp[0] ?? "--", isBottomSheet: $isBottomSheet)
                            
                            
                            WeatherDayView(dayOfWeek: "WED",
                                           imageName: forecastListVM.forecasts?.dailySystemImages[1] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.dailyTemp[1] ?? "--", isBottomSheet: $isBottomSheet)
                            
                            WeatherDayView(dayOfWeek: "THU",
                                           imageName: forecastListVM.forecasts?.dailySystemImages[2] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.dailyTemp[2] ?? "--", isBottomSheet: $isBottomSheet)
                            
                            WeatherDayView(dayOfWeek: "FRI",
                                           imageName: forecastListVM.forecasts?.dailySystemImages[3] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.dailyTemp[3] ?? "--", isBottomSheet: $isBottomSheet)
                            
                            WeatherDayView(dayOfWeek: "SUN",
                                           imageName: forecastListVM.forecasts?.dailySystemImages[4] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.dailyTemp[4] ?? "--", isBottomSheet: $isBottomSheet)
                            
                        }
                        
//                        currentHalfASheetView(title: "Current", dataSet: forecastListVM.forecasts?.Current ?? ["", "", "", "", "", ""], isBottomSheet: $isBottomSheet)
                    }
                }.onAppear(perform: {
                    isAnimating = true
                    forecastListVM.fetchData()
                })
                .partialSheet(isPresented: $isBottomSheet) {
                    currentHalfASheetView(title: "Current", dataSet: forecastListVM.forecasts?.Current ?? ["", "", "", "", "", ""], isBottomSheet: $isBottomSheet)
                    
                 }

        }.attachPartialSheetToRoot()
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
    struct WeatherDayView: View {
        var dayOfWeek: String
        var imageName: String
        var temperature: String
        @Binding var isBottomSheet: Bool
        
        var body: some View {
            VStack {
                Text(dayOfWeek)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                Button {
                    isBottomSheet.toggle()
                } label: {
                    Image(systemName: imageName)
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                }

                
                Text(temperature)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
                    .shadow(color: Color("ColorBlackTransparentLight"), radius: 5, x: 0, y: 2)
                
                
    //            VStack {
    //                LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
    //                    .edgesIgnoringSafeArea(.all)
    //                Image(systemName: imageName)
    //                    .renderingMode(.original)
    //                    .resizable()
    //                    .aspectRatio(contentMode: .fit)
    //                    .frame(width: 80, height: 80)
    //                HStack {
    //                    Text("H: \(forecast.forecasts?.dailyHigh ?? "--")")
    //                    Text("L: \(forecast.forecasts?.dailyLow ?? "--")")
    //                }
    //            }
            }
            
        }
    }


}


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
    var Current: [String]
    @Binding var isBottomSheet: Bool

    var body: some View {
        VStack (spacing:10) {
            Button {
                isBottomSheet.toggle()
            } label: {
                VStack {
                    Image(systemName: Current[7])
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 140)
                    Text(Current[0])
                        .font(.system(size: 70, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                }
            }
            
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

//struct WeatherDayView: View {
//    var dayOfWeek: String
//    var imageName: String
//    var temperature: String
//    var forecast: ForecastListViewModel
//    @Binding var isBottomSheet: Bool
//
//    var body: some View {
//        VStack {
//            Text(dayOfWeek)
//                .font(.system(size: 17, weight: .medium))
//                .foregroundColor(.white)
//            Button {
//                isBottomSheet.toggle()
//            } label: {
//                Image(systemName: imageName)
//                    .renderingMode(.original)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 45, height: 45)
//            }
//
//
//            Text(temperature)
//                .font(.system(size: 28, weight: .medium))
//                .foregroundColor(.white)
//                .shadow(color: Color("ColorBlackTransparentLight"), radius: 5, x: 0, y: 2)
//
//
////            VStack {
////                LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
////                    .edgesIgnoringSafeArea(.all)
////                Image(systemName: imageName)
////                    .renderingMode(.original)
////                    .resizable()
////                    .aspectRatio(contentMode: .fit)
////                    .frame(width: 80, height: 80)
////                HStack {
////                    Text("H: \(forecast.forecasts?.dailyHigh ?? "--")")
////                    Text("L: \(forecast.forecasts?.dailyLow ?? "--")")
////                }
////            }
//        }
//
//    }
//}

struct currentHalfASheetView: View {
    var title: String
    var dataSet: [String]
    @Binding var isBottomSheet: Bool
    private let icons: [String] = ["thermometer", "humidity.fill", "wind", "sunrise.fill", "sunset.fill", "sun.min.fill"]
    private let dataPoints: [String] = ["Feels Like",  "Humidity", "Wind", "Sunrise", "Sunset", "UV Index"]

    var body: some View {
            VStack {
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.horizontal, 30)
                    Spacer()
                    Image(systemName: dataSet[7])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80, alignment: .center)
                        .tint(.primary)
                        .padding(.horizontal, 40)
                }
                VStack(spacing: 20) {
                    ForEach(0..<dataPoints.count, id: \.self) { i in
                        WeatherInfoRows(systemImage: icons[i], property: dataPoints[i], value: dataSet[i+1])
                        Divider()
                    }
                }
//                Spacer(minLength: 210)
            }
            
    }
}
