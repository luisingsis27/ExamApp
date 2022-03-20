//
//  ViewController2.swift
//  ExamApp
//
//  Created by Luis on 17/03/22.
//

import UIKit
import Charts


class ViewController2: UIViewController {

    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var pieChartView2: PieChartView!
    @IBOutlet weak var pieChartView3: PieChartView!
    @IBOutlet weak var pieChartView4: PieChartView!
    @IBOutlet weak var pieChartView5: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlData = URL(string: "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld")
        getDataFromURL(url: urlData!)
        
        
     
    }
    
    func getParse(json: Data)
    {

        let decoder = JSONDecoder()
        do
        {
            let decoded = try decoder.decode(ModelP.self, from: json)
            
            pieChartView.data = customizeChart(colors: decoded.colors, data: decoded.questions[0])
            
            pieChartView2.data = customizeChart(colors: decoded.colors, data: decoded.questions[1])
            pieChartView3.data = customizeChart(colors: decoded.colors, data: decoded.questions[2])
            pieChartView4.data = customizeChart(colors: decoded.colors, data: decoded.questions[3])
            pieChartView5.data = customizeChart(colors: decoded.colors, data: decoded.questions[4])
            
        }
        catch {
            print("Failed to decode JSON")
        }
    }
    
    func getDataFromURL(url: URL) {
        
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)

        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
                    if let _ = error {
                        print("Error")
                    }
                    
                    if let data = data,
                       let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200 {
                        
                       
                        getParse(json: data.self)
                    }
                    
                }.resume()
    }


    func customizeChart(colors: [String], data : Question) -> PieChartData {
      
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<data.chartData.count {
            let dataEntry = PieChartDataEntry(value: Double(data.chartData[i].percetnage), label: data.chartData[i].text, data: data.chartData[i].text as AnyObject)
          dataEntries.append(dataEntry)
        }
        
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: data.text)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: colors.count, colores: colors)
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      return pieChartData
    }

    private func colorsOfCharts(numbersOfColor: Int,colores: [String]) -> [UIColor] {
      var colors: [UIColor] = []
      
        for index in 0...numbersOfColor-1 {
        var c = hexStringToUIColor(hex: colores[index])
        colors.append(c)
      }
      return colors
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

