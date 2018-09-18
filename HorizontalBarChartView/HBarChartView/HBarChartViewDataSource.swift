//
//  HBarChartViewDataSource.swift
//  HorizontalBarChartView
//
//  Created by R0uter on 12/18/17.
//  Copyright © 2017 logcg. All rights reserved.
//

import Cocoa

protocol HBarChartViewDataSource:class {
    func numberOfBars(_ hBarChartView:HBarChartView) -> Int
    
    func hBarChartView(_ hBarChartView:HBarChartView, valueForBarAt index:Int) -> Double
    func hBarChartView(_ hBarChartView:HBarChartView, labelForBarAt index:Int) -> String?
    func hBarChartView(_ hBarChartView:HBarChartView, widthForBarAt index:Int) -> Double
    func hBarChartView(_ hBarChartView:HBarChartView, colorForBarAt index:Int) -> NSColor
    func hBarChartView(_ hBarChartView:HBarChartView, backgroundColorForBarAt index:Int) -> NSColor
    
    func hBarChartView(_ hBarChartView:HBarChartView, attributeForBarLabelAt index:Int) -> [NSAttributedString.Key:Any]
    func hBarChartView(_ hBarChartView:HBarChartView, attributeForValueLabel index:Int) -> [NSAttributedString.Key:Any]
}
extension HBarChartViewDataSource {
    func hBarChartView(_ hBarChartView:HBarChartView, backgroundColorForBarAt index:Int) -> NSColor {
        return NSColor.lightGray
    }
    func hBarChartView(_ hBarChartView:HBarChartView, colorForBarAt index:Int) -> NSColor {
        return NSColor.red
    }
    func hBarChartView(_ hBarChartView:HBarChartView, widthForBarAt index:Int) -> Double {
        return 5
    }
    func hBarChartView(_ hBarChartView:HBarChartView, attributeForValueLabel index:Int) -> [NSAttributedString.Key:Any] {
        return [:]
    }
    func hBarChartView(_ hBarChartView:HBarChartView, attributeForBarLabelAt index:Int) -> [NSAttributedString.Key:Any] {
        return [:]
    }
}
