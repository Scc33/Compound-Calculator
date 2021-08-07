//
//  TransactionBarChartView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 8/6/21.
//

// https://youtu.be/csd7pyfEXgw

import SwiftUI
import Charts

struct TransactionBarChartView: UIViewRepresentable {
    let entries: [BarChartDataEntry]
    let barChart = BarChartView()
    
    @Binding var selectedYear: Int
    @Binding var selectedItem: String
    func makeUIView(context: Context) -> BarChartView {
        barChart.delegate = context.coordinator
        return barChart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.label = "Transaction"
        uiView.noDataText = "No data"
        uiView.data = BarChartData(dataSet: dataSet)
        uiView.rightAxis.enabled = false
        /*if uiView.scaleX == 1.0 {
            uiView.zoom(scaleX: 1.5, scaleY: 1, x: 0, y: 0)
        }*/
        uiView.setScaleEnabled(false) // user cannot zoom in on chart
        formatDataSet(dataSet: dataSet)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        formatLegend(legend: uiView.legend)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate {
        let parent: TransactionBarChartView
        
        init(parent: TransactionBarChartView) {
            self.parent = parent
        }
        
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let month = Transaction.months[Int(entry.x)]
            let quantity = Int(entry.y)
            parent.selectedItem = "\(quantity) sold in \(month)"
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // Lots of chart properties can be changed
    // Charts-master > Source > Charts > Data > ChartDataSet
    func formatDataSet(dataSet: BarChartDataSet) {
        dataSet.colors = [.red]
        dataSet.valueColors = [.blue]
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        dataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
    }
    
    func formatLeftAxis(leftAxis: YAxis) {
        leftAxis.labelTextColor = .red
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        leftAxis.axisMinimum = 0
    }
    
    func formatXAxis(xAxis: XAxis) {
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Transaction.months)
        xAxis.labelPosition = .bottom
    }
    
    func formatLegend(legend: Legend) {
        legend.textColor = .red
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.drawInside = true
        legend.yOffset = 25.0
    }
}

struct TransactionBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionBarChartView(entries: Transaction.dataEntriiesForYear(2019, transactions: Transaction.allTransactions),
                                selectedYear: .constant(2019),
                                selectedItem: .constant(""))
    }
}
