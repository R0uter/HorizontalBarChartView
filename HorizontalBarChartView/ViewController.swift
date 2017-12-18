//
//  ViewController.swift
//  HorizontalBarChartView
//
//  Created by R0uter on 12/18/17.
//  Copyright © 2017 logcg. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let values = [22.3,44.5,32,33,11]
    let names = ["apple","pie","pen","coffie","cat"]
    let barChartView = HBarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.dataSource = self
        view.addSubview(barChartView)
        barChartView.frame = view.bounds
        barChartView.labelWidth = 50
        barChartView.barSpace = 20
        barChartView.barCornerRadius = 5
        barChartView.reloadData()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController:HBarChartViewDataSource {
    func numberOfBars(_ hBarChartView:HBarChartView) -> Int {
        return values.count
    }
    
    func hBarChartView(_ hBarChartView:HBarChartView, valueForBarAt index:Int) -> Double {
        return values[index]
    }
    func hBarChartView(_ hBarChartView:HBarChartView, labelForBarAt index:Int) -> String? {
        return names[index]
    }
}
