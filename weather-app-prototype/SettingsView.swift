//
//  SettingsView.swift
//  weather-app
//
//  Created by Niranjan Bukkapatna on 8/1/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @AppStorage("isForceDarkMode") var isforceDarkMode: Bool = false
    @EnvironmentObject var forecastListVM: ForecastListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:20) {
                    //                    section 1
                    GroupBox(label:
                                SettingsLabelView(labelText: "About Weather +", labelImage: "info.circle") ) {
                        Divider().padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10) {
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(16)
                            Text("Most weather apps are bloated and battery drainers. They track and sell your data. We don't. Weather + offers a clean experience for the same accurate results.")
                                .font(.footnote)
                        }
                    }
                    //                    section 2
                    GroupBox(
                        label: SettingsLabelView(labelText: "Customization", labelImage: "paintbrush")) {
                            Divider().padding(.vertical, 4)
                            Text("If you wish, you can restart the application by toggling the switch in this box. That way it starts the onboarding process and you will see the welcome screen again.")
                                .padding(.vertical, 8)
                                .frame(minHeight: 60)
                                .layoutPriority(1)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                            Toggle(isOn: $isOnboarding) {
                                if isOnboarding {
                                    Text("Restarted".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                } else {
                                    Text("Restart".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(
                                Color(UIColor.tertiarySystemBackground).clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)))
                            .tint(.blue)
                            Divider()
                            Toggle(isOn: $isforceDarkMode) {
                                Text("Force Dark mode")
                            }
                            .padding(.top, 6)
                            .tint(.blue)
                            Divider()
                            HStack {
                                Text("Units")
                                Spacer()
                                Picker(
                                    selection: forecastListVM.$system,
                                    content: {
                                        Text("°F").tag(1)
                                        Text("°C").tag(0)
                                    }, label: {
                                    }).pickerStyle(SegmentedPickerStyle())
                                    .frame(width: 110)
                                    .cornerRadius(8)
                                    .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 6)
                            }.padding(.top, 6)
                        }
                    
                    //                    section 3
                    GroupBox(
                        label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")) {
                            
                            SettingsRowView(name: "Developer", content: "Varun Kota")
                            SettingsRowView(name: "Compatability", content: "iOS 15")
                            SettingsRowView(name: "Website", linkLabel: "LinkedIn", linkDestination: "https://www.linkedin.com/in/varun-k-244825204/")
                            SettingsRowView(name: "Version", content: "1.1.0")
                            SettingsRowView(name: "Build", content: "1.0")
                        }
                    
                }
                .navigationBarTitle(Text("Settings"), displayMode: .large)
            }
        }.preferredColorScheme(isforceDarkMode ? .dark : nil)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
