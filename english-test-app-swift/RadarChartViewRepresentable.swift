import SwiftUI
import DGCharts
import Charts

struct RadarChartViewRepresentable: UIViewRepresentable {
    var entries: [RadarChartDataEntry]

    func makeUIView(context: Context) -> RadarChartView {
        return RadarChartView()
    }

    func updateUIView(_ uiView: RadarChartView, context: Context) {
        let dataSet = RadarChartDataSet(entries: entries)
        dataSet.colors = [UIColor.systemBlue]
        dataSet.fillColor = UIColor.systemBlue.withAlphaComponent(0.7) // 塗りつぶしの色を少し透明に
        dataSet.drawFilledEnabled = true
        dataSet.lineWidth = 2.0
        
        let data = RadarChartData(dataSets: [dataSet])
        uiView.data = data
        
        // Y軸（軸の最大値と最小値）の設定
        uiView.yAxis.axisMinimum = 0 // 最小値
        uiView.yAxis.axisMaximum = 10 // 最大値
        
        // レーダーチャートビューのカスタマイズ
        uiView.backgroundColor = UIColor.white
        uiView.yAxis.labelTextColor = UIColor.black
        uiView.yAxis.gridColor = UIColor.lightGray
        uiView.yAxis.drawLabelsEnabled = false // Y軸のラベル非表示
        uiView.yAxis.drawAxisLineEnabled = false // Y軸の線非表示
        uiView.yAxis.drawGridLinesEnabled = false // グリッド線非表示

        // 背景のグリッド線（Web線）を非表示にする
        uiView.webLineWidth = 0.0
        uiView.innerWebLineWidth = 0.0
        uiView.webColor = .clear
        uiView.innerWebColor = .clear

        // X軸のラベルのカスタマイズ
        uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Listening", "Speaking", "Grammar", "Vocabulary"])
        uiView.xAxis.labelFont = .systemFont(ofSize: 14)
        
        // チャート全体のアニメーション
        uiView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }

}
