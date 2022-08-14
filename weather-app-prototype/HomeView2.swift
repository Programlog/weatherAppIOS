import SwiftUI
import PartialSheet
import CoreLocation
import MapKit

struct HomeView2: View {
    @State private var isAnimating: Bool = false
//    @AppStorage("isCurrentLocation") var isCurrentLocation: Bool = false
//    @StateObject var forecastListVM = ForecastListViewModel()
    @EnvironmentObject var forecastListVM: ForecastListViewModel
    @State private var isBottomSheetCurrent: Bool = false
    @State private var isBottomSheetDaily: Bool = false
    @State private var showingSheet: Bool = false
    @State private var region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 40.83834587046632,
                        longitude: 14.254053016537693),
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.03,
                        longitudeDelta: 0.03)
                    )
//    private let staticData: ForecastViewModel = ForecastViewModel(forecast: Forecast(daily: [Forecast.Daily(temp: Forecast.Daily.Temp(min: 40, max: 80, day: 60), weather: [Forecast.Daily.Weather(id: 400, main: "Clear", icon: "01d")], pop: 0.33, uvi: 0, dt: Date(timeIntervalSince1970: 1660065467), humidity: 40, wind_deg: 40, wind_gust: 10, sunrise: 1660065467, sunset: 1660065467, feels_like: Forecast.Daily.FeelsLike(day: 77))], lat: 40, lon: -74, timezone_offset: -1200, current: Forecast.Current(sunrise: 1660065467, sunset: 1660065467, temp: 40, feels_like: 50, humidity: 33, uvi: 0, wind_speed: 0, wind_deg: 0, weather: [Forecast.Current.Weather(id: 400, main: "Clear", icon: "01d", description: "Clear skies")])), system: 0)
    
    @State private var day: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: forecastListVM.forecasts?.backgroundColors ?? [.gray, Color("CloudyBackground")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Button {
                        print(String(describing: region))
                        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: forecastListVM.forecasts?.forecast.lat ?? 40.741895, longitude: forecastListVM.forecasts?.forecast.lon ?? -73.989308), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                        showingSheet.toggle()
                    } label: {
                        cityTextView(cityName: forecastListVM.location )
                            .opacity(isAnimating ? 1: 0.3)
                            .offset(y:isAnimating ? 0 : -15)
                            .animation(.easeInOut(duration: 0.7), value: isAnimating)
                    }
                    .sheet(isPresented: $showingSheet) {
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    showingSheet.toggle()
                                } label: {
                                    Text("Done")
                                        .padding(15)
                                }
                                
                            }
                            Map(coordinateRegion: self.$region)
                                .edgesIgnoringSafeArea(.top)
                            Text("\(forecastListVM.forecasts?.forecast.lat ?? -1)")
                            Text("\(forecastListVM.forecasts?.forecast.lon ?? -1)")
                        }
                    }

                    

                    MainWeatherStatusView(Current: forecastListVM.forecasts?.Current ?? ["--", "-- %", "--", " -- mph", "-:-- AM", "-:-- PM", "", "hourglass.bottomhalf.filled"],high: forecastListVM.forecasts?.dailyHigh[0] ?? "--", low: forecastListVM.forecasts?.dailyLow[0] ?? "--" ,isBottomSheet: $isBottomSheetCurrent)
                        .opacity(isAnimating ? 1: 0.3)
                    
                    HStack(spacing:25) {
                        ForEach(1...5, id: \.self) { i in
                            WeatherDayView(dayOfWeek: forecastListVM.forecasts?.Daily[12][i] ?? "--",
                                            imageName: forecastListVM.forecasts?.Daily[11][i] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.Daily[0][i] ?? "--", pop: forecastListVM.forecasts?.Daily[4][i] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: i)
                        }
//
//                        WeatherDayView(dayOfWeek: forecastListVM.forecasts?.Daily[12][1] ?? "--",
//                                        imageName: forecastListVM.forecasts?.Daily[11][1] ?? "hourglass.bottomhalf.filled",
//                                       temperature: forecastListVM.forecasts?.Daily[0][1] ?? "--", pop: forecastListVM.forecasts?.Daily[4][1] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: 1)
//
//
//                        WeatherDayView(dayOfWeek: forecastListVM.forecasts?.Daily[12][2] ?? "--",
//                                        imageName: forecastListVM.forecasts?.Daily[11][2] ?? "hourglass.bottomhalf.filled",
//                                       temperature: forecastListVM.forecasts?.Daily[0][2] ?? "--", pop: forecastListVM.forecasts?.Daily[4][2] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: 2)
//
//                        WeatherDayView(dayOfWeek:  forecastListVM.forecasts?.Daily[12][3] ?? "--",
//                                        imageName: forecastListVM.forecasts?.Daily[11][3] ?? "hourglass.bottomhalf.filled",
//                                       temperature: forecastListVM.forecasts?.Daily[0][3] ?? "--", pop: forecastListVM.forecasts?.Daily[4][3] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: 3)
//
//                        WeatherDayView(dayOfWeek:  forecastListVM.forecasts?.Daily[12][4] ?? "--",
//                                        imageName: forecastListVM.forecasts?.Daily[11][4] ?? "hourglass.bottomhalf.filled",
//                                       temperature: forecastListVM.forecasts?.Daily[0][4] ?? "--", pop: forecastListVM.forecasts?.Daily[4][4] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: 4)
//
//
//                        WeatherDayView(dayOfWeek:  forecastListVM.forecasts?.Daily[12][5] ?? "--",
//                                        imageName: forecastListVM.forecasts?.Daily[11][5] ?? "hourglass.bottomhalf.filled",
//                                       temperature: forecastListVM.forecasts?.Daily[0][5] ?? "--", pop: forecastListVM.forecasts?.Daily[4][5] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: 5)
                    }
                }
            }.onAppear(perform: {
                isAnimating = true
            })
            .onChange(of: forecastListVM.system, perform: { _ in
                forecastListVM.fetchData()
            })
            .partialSheet(isPresented: $isBottomSheetCurrent) {
                halfASheetView(title: "Current", currentData: forecastListVM.forecasts?.Current ?? ["", "", "", "", "", ""])
                }
            .partialSheet(isPresented: $isBottomSheetDaily) {
                halfASheetView(title: "Daily", dailyData: forecastListVM.forecasts ?? nil, dailyDaily: forecastListVM.forecasts?.Daily, dayNum: day)
            }
            
            if forecastListVM.isLoading {
                ZStack {
                    Color.white
                        .opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView("Loading Weather")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
                }
            }
            
        }.attachPartialSheetToRoot()
            .alert(item: $forecastListVM.appError) { appAlert in
                Alert(title: Text("Error"),
                      message: Text("""
                                    \(appAlert.errorString)
                                    Please try again later.
                                    """))
            }
    }
    
    struct WeatherDayView: View {
        var dayOfWeek: String
        var imageName: String
        var temperature: String
        var pop: String
        @Binding var isBottomSheet: Bool
        @Binding var dayNum: Int
        var pos: Int
        var body: some View {
            VStack {
                Button {
                    isBottomSheet.toggle()
                    dayNum = pos
                } label: {
                    VStack {
                        Text(dayOfWeek)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.white)
                        Image(systemName: imageName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45, alignment: .center)
                        Text(temperature)
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(.white)
                            .shadow(color: Color("ColorBlackTransparentLight"), radius: 5, x: 0, y: 2)
                        if let pop = (self.pop as NSString).integerValue {
                            if pop > 20 {
                                popView(pop: self.pop)
                            } else {
                                Spacer()
                            }
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
        struct popView: View {
            var pop: String
            var body: some View {
                Text(pop)
                .font(.body)
                .foregroundColor(.blue)
            }
        }
    }
}


struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView2()
    }
}

struct cityTextView: View {
    var cityName: String

    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .shadow(color: Color("ColorBlackTransparentDark"), radius: 8, x: 0, y: 3)
    }
}

struct MainWeatherStatusView: View {
    var Current: [String]
    var high: String
    var low: String
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
                        .padding(.bottom, 10)
                    HStack(alignment: .center, spacing: 30) {
                        Text("H: \(high)")
                            .foregroundColor(.white)
                        Text("L: \(low)")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.bottom, 80)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 10, x: 0, y: 5)
    }
}

struct halfASheetView: View {
    var title: String
    var currentData: [String]?
    var dailyData: ForecastViewModel?
    var dailyDaily: [[String]]?
    var dayNum: Int?
    private let icons: [String] = ["thermometer", "humidity.fill", "wind", "sunrise.fill", "sunset.fill", "sun.min.fill"]
    private let dataPoints: [String] = ["Feels Like",  "Humidity", "Wind", "Sunrise", "Sunset", "UV Index"]
    
    private let iconsDaily: [String] = ["thermometer", "thermometer.sun.fill", "thermometer.snowflake", "cloud.drizzle.fill", "humidity.fill", "wind", "sunrise.fill", "sunset.fill", "sun.min.fill"]
    private let dataPointsDaily = ["Feels Like", "High", "Low", "Chance of rain", "Humidity", "Wind", "Sunrise", "Sunset", "UV Index"]

    var body: some View {
        if let currentData = currentData {
            VStack {
                halfSheetTitleCard(title: "Current", systemImage: currentData[7])
                VStack(spacing: 20) {
                    ForEach(0..<dataPoints.count, id: \.self) { i in
                        WeatherInfoRows(systemImage: icons[i], property: dataPoints[i], value: currentData[i+1])
                        Divider()
                    }
                }
            }
        } else if let dailyData = dailyData, let dayNum = dayNum, let dailyDaily = dailyDaily {
            VStack {
                let dayName = getFullDay(day: dailyData.date[dayNum])
                halfSheetTitleCard(title: dayName, systemImage: dailyData.dailySystemImages[dayNum])
                
                VStack(spacing: 20) {
                    ForEach(0..<dataPointsDaily.count, id: \.self) { i in
                        WeatherInfoRows(systemImage: iconsDaily[i], property: dataPointsDaily[i], value: dailyDaily[i+1][dayNum])
                        Divider()
                    }
                }
            }
        } else {
            Image(systemName: "sunset.fill")
        }
    }
            
    func getFullDay(day: String) -> String {
        switch day {
        case "MON": return "MONDAY"
        case "TUE": return "TUESDAY"
        case "WED": return "WEDNESDAY"
        case "THU": return "THURSDAY"
        case "FRI": return "FRIDAY"
        case "SAT": return "SATURDAY"
        case "SUN": return "SUNDAY"
        default: return "SUNDAY"
        }
    }
    struct halfSheetTitleCard: View {
        var title: String
        var systemImage: String
        var body: some View {
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .scaledToFill()
                    .padding(.horizontal, 25)
                Spacer()
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80, alignment: .center)
                    .tint(.primary)
                    .padding(.horizontal, 40)
            }
        }
    }
}
