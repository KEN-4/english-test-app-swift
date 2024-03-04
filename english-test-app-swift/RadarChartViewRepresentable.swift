import SwiftUI
import DGCharts
import Charts

struct RadarChartViewRepresentable: UIViewRepresentable {
    var entries: [RadarChartDataEntry]

    func makeUIView(context: Context) -> RadarChartView {
        return RadarChartView()
    }

    func updateUIView(_ uiView: RadarChartView, context: Context) {
        let dataSet = RadarChartDataSet(entries: entries, label: "テストスコア")
        dataSet.colors = [UIColor.systemBlue]
        
        let data = RadarChartData(dataSets: [dataSet])
        uiView.data = data
    }
}
