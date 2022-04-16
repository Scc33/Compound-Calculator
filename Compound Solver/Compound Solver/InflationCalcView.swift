//
//  InflationCalcView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 4/15/22.
//

import SwiftUI

let fileName = "Inflation.json"

struct Response: Decodable {
    var status: String
    var responseTime: Int
    var Results: [Result]
}

struct Result: Decodable {
    var series: [Series]
}

struct Series: Decodable {
    var seriesID: String
    var data: [InflationData]
}

struct InflationData : Decodable {
    var period: String
    var periodName: String
    var value: String
    var year: String
}

func loadJson() -> [InflationData]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Response.self, from: data)
            print(jsonData.status)
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

func apiCall(startYear: String, endYear: String) {
    let params = ["seriesid":["CUUR0000SA0"],"startyear":"2020","endyear":"2020"] as Dictionary<String, Any>
    
    var request = URLRequest(url: URL(string: "https://api.bls.gov/publicAPI/v1/timeseries/data/")!)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        print(response!)
        if let data = data {
            
            let decoder = JSONDecoder()
            do {
                let json: Response = try! decoder.decode(Response.self, from: data)
            }catch let error {
                print(error.localizedDescription)
            }
        }
        /*do {
            //let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, String>
            //let results: ResponseData = json["Results"] as! ResponseData
            //print(json["Results"])
            //let jsonData = data!.data(using: .utf8)!
            let json = try JSONSerialization.jsonObject(with: data!)
            let blogPost: ResponseData = try! JSONDecoder().decode(ResponseData.self, from: json as! Data)
        } catch {
            print("error")
        }*/
        /*do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
            let json = try JSONSerialization.data(withJSONObject: data!)
            try json.write(to: fileURL, options: [])

            //print(json)
        } catch {
            print("error")
        }*/
    })
    task.resume()
}

struct InflationCalc: Identifiable, Codable {
    var id = UUID()
    var startYear: Int
    var endYear: Int

    func calcInflation() {
        apiCall(startYear: String(startYear), endYear: String(endYear))
        //let data = loadJson()
        //print(data ?? "")
    }
}

struct InflationCalcView: View {
    @State private var showingSettings = false
    @State private var start = Date()
    @State private var end = Date()

    @State private var showCalc = false
    @State private var invalid = false
    @State private var percent = 0.0
    
    func createCalc() {
        if showCalc == false {
            invalid = false
            showCalc = true
        }
    }
    
    func makeInvalid() {
        if invalid == false {
            invalid = true
            showCalc = false
        }
    }

    var body: some View {
        Form {
            DatePicker("Starting year", selection: $start, displayedComponents: .date)
                .datePickerStyle(.compact)

            DatePicker("Ending year", selection: $end, displayedComponents: .date)
                .datePickerStyle(.wheel)
            
            /*Picker(selection: $leftIndex, label: Text("Picker")) {
                ForEach(0..<leftSource.count) {
                    Text(self.leftSource[$0]).tag($0)
                }
                }.frame(width: UIScreen.main.bounds.width/2)*/
            
            Button("Calculate") {
                InflationCalc(startYear: 10, endYear: 20).calcInflation()
            }
            .alert(isPresented: $invalid) {
                Alert(
                    title: Text("Invalid"),
                    message: Text("The start and final value must be set"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            
            if showCalc {
                Section {
                    Text("Percent Growth: \(String(format:"%.2f", percent))%")
                        .contextMenu {
                            Button(action: {
                                UIPasteboard.general.string = String(percent)
                            }) {
                                Text("Copy final value")
                            }
                        }
                }
            }
        }
        .navigationTitle(Text("Percent Growth"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InflationCalcView_Previews: PreviewProvider {
    static var previews: some View {
        InflationCalcView()
    }
}
