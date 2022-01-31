
//
//  SwiftUiChartsBarChart.swift
//  Charts
//
//  Created by Jannik Arndt on 29.08.21.
//
import Charts
import SwiftUI

struct ChartsEx: View {
    @State var data = [12.54, 53.42, 32.11, 44.99, 12.54, 153.42, 132.11, 144.99, 312.54, 353.42, 32.11, 44.99]
    @State var matrix = [[0.1, 0.2, 0.3],
                         [0.2, 0.3, 0.4],
                         [0.3, 0.4, 0.1],
                         [0.3, 0.4, 0.2],
                         [0.3, 0.3, 0.3],
                         [0.3, 0.2, 0.4]]
    @State var growingData = [1.0,2.0,4.0,8.0,16.0,32.0,64.0,128.0,256.0,350.0,400.0,512.0]
    
    var body: some View {
        Form {
            Chart(data: growingData.map { $0 / 500 }).chartStyle(ColumnChartStyle(column: Capsule(), spacing: 2)).frame(height: 100)
            Chart(data: growingData.map { $0 / 500 }).chartStyle(ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)).frame(height: 200)
            Text("Given")
            Chart(data: data.map { $0 / 400 }.reversed()).chartStyle(ColumnChartStyle(column: Capsule(), spacing: 2)).frame(height: 100)
            Chart(data: data.map { $0 / 400 }.reversed()).chartStyle(ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 10)).frame(height: 200)
            Chart(data: matrix.reversed()).chartStyle(StackedColumnChartStyle(spacing: 10)).frame(height: 200)
            Chart(data: matrix.reversed()).chartStyle(StackedAreaChartStyle(LineType.quadCurve, colors: [.green, .red, .yellow])).frame(height: 200)
        }
    }
}

struct ChartsEx_Previews: PreviewProvider {
    static var previews: some View {
        ChartsEx()
    }
}
