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
    
    func makeUIView(context: Context) -> BarChartView {
        return BarChartView()
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries)
        uiView.data = BarChartData(dataSet: dataSet)
    }
}

struct TransactionBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionBarChartView(entries: Transaction.dataEntriiesForYear(2019, transactions: Transaction.allTransactions))
    }
}
