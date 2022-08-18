import SwiftUI
import PartialSheet
import MapKit
import SwiftUISnappingScrollView

struct HomeView2: View {
    @State private var isAnimating: Bool = false
    //    @AppStorage("isCurrentLocation") var isCurrentLocation: Bool = false
    @EnvironmentObject var forecastListVM: ForecastListViewModel
    @State private var isBottomSheetCurrent: Bool = false
    @State private var isBottomSheetDaily: Bool = false
    @State private var isBottomSheetHourly: Bool = false
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
    @State private var hour: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: forecastListVM.forecasts?.backgroundColors ?? [.gray, Color("CloudyBackground")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
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
                
                SnappingScrollView(.horizontal, decelerationRate: .normal, showsIndicators: false) {
                    HStack(spacing:25) {
                        Group {
                            ForEach(0...4, id:\.self) { i in
                                WeatherDayView(dayOfWeek: forecastListVM.forecasts?.Hourly[10][i] ?? "--", imageName: forecastListVM.forecasts?.Hourly[7][i] ?? "hourglass.bottomhalf.filled", temperature: forecastListVM.forecasts?.Hourly[0][i] ?? "--°", pop: forecastListVM.forecasts?.Hourly[2][i] ?? "--%", isBottomSheet: $isBottomSheetHourly, dayNum: $hour, pos: i, isDay: false)
                                
                                
                            }
                            Spacer()
                        }
                        ForEach(1...5, id: \.self) { i in
                            WeatherDayView(dayOfWeek: forecastListVM.forecasts?.Daily[12][i] ?? "--",
                                           imageName: forecastListVM.forecasts?.Daily[11][i] ?? "hourglass.bottomhalf.filled",
                                           temperature: forecastListVM.forecasts?.Daily[0][i] ?? "--", pop: forecastListVM.forecasts?.Daily[4][i] ?? "-%", isBottomSheet: $isBottomSheetDaily, dayNum: $day, pos: i, isDay: true)
                        }
                    }
                    .scrollSnappingAnchor(.bounds)
                    .padding(.horizontal, 35)
                }
            }
            .onAppear(perform: {
                isAnimating = true
            })
            .onChange(of: forecastListVM.system, perform: { _ in
                forecastListVM.fetchData()
            })
            .partialSheet(isPresented: $isBottomSheetCurrent) {
                halfASheetView(currentData: forecastListVM.forecasts?.Current ?? ["", "", "", "", "", ""])
            }
            .partialSheet(isPresented: $isBottomSheetDaily) {
                halfASheetView(dailyData: forecastListVM.forecasts ?? nil, dailyDaily: forecastListVM.forecasts?.Daily, dayNum: day)
            }
            .partialSheet(isPresented: $isBottomSheetHourly) {
                halfASheetView(hourlyHourly: forecastListVM.forecasts?.Hourly ?? nil, hourlyNum: hour)
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
            
        }
        .attachPartialSheetToRoot()
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
        let imageName: String
        var temperature: String
        var pop: String
        @Binding var isBottomSheet: Bool
        @Binding var dayNum: Int
        var pos: Int
        let isDay: Bool
        
        var body: some View {
            VStack {
                Button {
                    isBottomSheet.toggle()
                    dayNum = pos
                } label: {
                    VStack {
                        if isDay {
                            Text(dayOfWeek == "--" ? dayOfWeek: String(dayOfWeek[dayOfWeek.startIndex..<dayOfWeek.index(dayOfWeek.startIndex, offsetBy: 3)]))
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                        } else {
                            Text(dayOfWeek)
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                        }
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
    
    struct cityTextView: View {
        var cityName: String
        
        var body: some View {
            Text(cityName)
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
                .shadow(color: Color("ColorBlackTransparentDark"), radius: 8, x: 0, y: 3)
        }
    }
}


struct MainWeatherStatusView: View {
    var Current: [String]
    var high: String
    var low: String
    @Binding var isBottomSheet: Bool
    
    var body: some View {
        VStack (spacing:7) {
            Button {
                isBottomSheet.toggle()
            } label: {
                VStack {
                    Image(systemName: Current[7])
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 230, height: 160)
                    Text(Current[0])
                        .font(.system(size: 70, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                }
            }
            HStack(alignment: .center, spacing: 30) {
                Text("H: \(high)")
                    .foregroundColor(.white)
                Text("L: \(low)")
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 80)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 10, x: 0, y: 5)
    }
}

struct halfASheetView: View {
    var currentData: [String]?
    var dailyData: ForecastViewModel?
    var dailyDaily: [[String]]?
    var dayNum: Int?
    var hourlyHourly: [[String]]?
    var hourlyNum: Int?
    private let icons: [String] = ["thermometer", "humidity.fill", "wind", "sunrise.fill", "sunset.fill", "sun.min.fill"]
    private let dataPoints: [String] = ["Feels Like",  "Humidity", "Wind", "Sunrise", "Sunset", "UV Index"]
    
    private let iconsDaily: [String] = ["thermometer", "thermometer.sun.fill", "thermometer.snowflake", "cloud.drizzle.fill", "humidity.fill", "wind", "sunrise.fill", "sunset.fill", "sun.min.fill"]
    private let dataPointsDaily = ["Feels Like", "High", "Low", "Chance of rain", "Humidity", "Wind", "Sunrise", "Sunset", "UV Index"]
    
    private let iconsHourly: [String] = ["thermometer", "cloud.drizzle.fill", "humidity.fill", "wind", "sun.min.fill"]
    private let dataPointsHourly = ["Feels Like", "Chance of rain", "Humidity", "Wind", "UV Index"]
    
    
    var body: some View {
        if let currentData = currentData {
            VStack {
                halfSheetTitleCard(title: "Current", systemImage: currentData[7], description: currentData[8])
                VStack(spacing: 20) {
                    ForEach(0..<dataPoints.count, id: \.self) { i in
                        WeatherInfoRows(systemImage: icons[i], property: dataPoints[i], value: currentData[i+1])
                        Divider()
                    }
                }
            }
        } else if let dailyData = dailyData, let dayNum = dayNum, let dailyDaily = dailyDaily {
            VStack {
                halfSheetTitleCard(title: dailyData.date[dayNum], systemImage: dailyData.dailySystemImages[dayNum], description: dailyData.dailyDescription[dayNum])
                
                VStack(spacing: 20) {
                    ForEach(0..<dataPointsDaily.count-1, id: \.self) { i in
                        WeatherInfoRows(systemImage: iconsDaily[i], property: dataPointsDaily[i], value: dailyDaily[i+1][dayNum])
                        Divider()
                    }
                }
            }
        } else if let hourlyHourly = hourlyHourly, let hourlyNum = hourlyNum {
            VStack {
                halfSheetTitleCard(title: hourlyHourly[10][hourlyNum], systemImage: hourlyHourly[7][hourlyNum], description: hourlyHourly[8][hourlyNum])
                
                VStack(spacing: 20) {
                    ForEach(0..<dataPointsHourly.count, id: \.self) { i in
                        WeatherInfoRows(systemImage: iconsHourly[i], property: dataPointsHourly[i], value: hourlyHourly[i+1][hourlyNum])
                        Divider()
                    }
                }
            }
        } else {
            Image(systemName: "sunset.fill")
        }
    }
    
    struct halfSheetTitleCard: View {
        let title: String
        let systemImage: String
        let description: String
        var body: some View {
            HStack {
                VStack(alignment: .center, spacing: 3) {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.title)
                        .scaledToFill()
                        .padding(.horizontal, 25)
                    Text(description)
                        .fontWeight(.semibold)
                        .font(.headline)
                }
                
                Spacer()
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80, alignment: .center)
                    .tint(.primary)
                    .padding(.horizontal, 40)
            }
            .padding(.horizontal, 6)
        }
    }
}
