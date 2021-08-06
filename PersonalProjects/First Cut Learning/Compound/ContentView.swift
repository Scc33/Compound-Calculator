//
//  ContentView.swift
//  Compound
//
//  Created by Sean Coughlin on 2/26/21.
//

import SwiftUI
//import SwiftUICharts
import Combine

struct ContentView: View {
    @State private var selectedTab = 1
    @State private var isShareSheetShowing = false

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                InputView()
                .tabItem {
                    Text("Input")
                    Image(systemName:"chart.bar.xaxis")
                }.tag(1)
                ScrollView {
                    VStack(alignment: .center) {
                        HStack {
                            Button(action: shareButton) {
                                Image(systemName:  "square.and.arrow.up").font(.largeTitle)
                            }
                            Spacer()
                            Text("List").font(.largeTitle)
                            Spacer()
                            Image(systemName:  "gearshape").font(.largeTitle)
                        }.padding()
                        HStack {
                            Text("test")
                        }
                        HStack {
                            Text("test1")
                        }
                        HStack {
                            NavigationView {
                                List {
                                    NavigationLink(destination: InputView())
                                    {
                                        Text("134234")
                                    }
                                }
                            }
                        }
                    }
                }
                .tabItem {
                    Text("Graph")
                    Image(systemName:"waveform.path.ecg.rectangle")
                }.tag(2)
            }
        }
    }
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://apple.com")
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}

struct InputView: View {
    @State var values: [Double] = [1,2,3,4,5]
    //Initial, contributions, profit
    @State var finalBreakDown: [Double] = [0,0,0]
    @State private var time: String = "0"
    @State private var rate: String = "0"
    @State private var initial: String = "0"
    @State private var contribution: String = ""
    @State private var chartType: Bool = false
    
    let mixedColorStyle = ChartStyle(backgroundColor: .white, foregroundColor: [
        ColorGradient(ChartColors.orangeBright, ChartColors.orangeDark),
        ColorGradient(.purple, .blue)
    ])
    let blueStyle = ChartStyle(backgroundColor: .white,
                               foregroundColor: [ColorGradient(.purple, .blue)])
    let orangeStyle = ChartStyle(backgroundColor: .white,
                                 foregroundColor: [ColorGradient(ChartColors.orangeBright, ChartColors.orangeDark)])

    let multiStyle = ChartStyle(backgroundColor: Color.green.opacity(0.2),
                                foregroundColor:
                                    [ColorGradient(.purple, .blue),
                                     ColorGradient(.orange, .red),
                                     ColorGradient(.green, .yellow),
                                     ColorGradient(.red, .purple),
                                     ColorGradient(.yellow, .orange),
                                    ])
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CardView {
                    Text("Compound").font(.largeTitle).padding(.top)
                    HStack {
                        Spacer()
                        Text("Time")
                        TextField("Time", text: $time)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                        .onReceive(Just(time)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.time = filtered
                                        }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                    }.padding(.top)
                    HStack {
                        Spacer()
                        Text("Rate")
                        TextField("Rate", text: $rate)
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                            .onReceive(Just(time)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.time = filtered
                                            }
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Initial")
                        TextField("Initial", text: $initial)
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                            .onReceive(Just(time)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.time = filtered
                                            }
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Contribution")
                        TextField("Contribution", text: $contribution)
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                            .onReceive(Just(time)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.time = filtered
                                            }
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                    }
                    /*HStack {
                        Spacer()
                        GroupBox {
                            DisclosureGroup("Menu 1") {
                                Text("Item 1")
                                Text("Item 2")
                                Text("Item 3")
                            }
                        }
                        Spacer()
                    }*/
                    HStack {
                        Spacer()
                        Button(action: {
                            values = []
                            finalBreakDown = [0,0,0]
                            let int_time = Int(time) ?? 0
                            for i in 0...int_time {
                                if i == 0 {
                                    let int_initial = Double(initial) ?? 0
                                    values.append(int_initial)
                                    finalBreakDown[0] = int_initial
                                } else {
                                    let int_rate = (Double(rate) ?? 0)/100
                                    let int_contrib = Double(contribution) ?? 0
                                    let new_value = values[i-1]*(1+int_rate) + int_contrib
                                    values.append(new_value)
                                    finalBreakDown[1] += int_contrib
                                    finalBreakDown[2] += values[i-1]*(1+int_rate)
                                }
                            }
                        }) {
                            Text("Update").padding(.bottom)
                        }
                        Spacer()
                    }
                }.padding(.horizontal)
                if chartType {
                    CardView {
                        ChartLabel("Total", type: .title)
                        LineChart()
                        HStack {
                            Spacer()
                            Toggle("Chart Type", isOn: $chartType)
                            Spacer()
                        }.padding(.bottom)
                    }
                    .data(values)
                    .chartStyle(orangeStyle)
                    .frame(minHeight:200)
                    .padding(.horizontal)
                } else {
                    CardView {
                        ChartLabel("Total", type: .subTitle)
                        BarChart()
                        HStack {
                            Spacer()
                            Toggle("Chart Type", isOn: $chartType)
                            Spacer()
                        }.padding(.bottom)
                    }
                    .data(values)
                    .chartStyle(mixedColorStyle)
                    .frame(minHeight:200)
                    .padding(.horizontal)
                }
                CardView {
                    ChartLabel("Breakdown", type: .subTitle)
                    //ChartLabel("legend", type: .legend)
                    HStack {
                        VStack {
                            Text("Legend")
                            Text("red")
                            Text("blue")
                            Text("other")
                        }.padding()
                        PieChart()
                    }
                }
                .data(finalBreakDown)
                .chartStyle(mixedColorStyle)
                .frame(height:200)
                .padding(.horizontal)
                CardView() {
                    Text("Yearly data")
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewDevice("iPhone SE (2nd generation)")
            ContentView()
                .previewDevice("iPad (8th generation)")
        }
    }
}

