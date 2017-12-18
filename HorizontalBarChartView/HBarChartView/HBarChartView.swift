//
//  HorizontalBarChartView.swift
//  HorizontalBarChartView
//
//  Created by R0uter on 12/18/17.
//  Copyright © 2017 logcg. All rights reserved.
//

import Cocoa

class HBarChartView:NSView {
    weak var dataSource:HBarChartViewDataSource?
    weak var delegate:HBarChartViewDelegate?
    
    var barSpace:CGFloat = 5.0
    var autoBarWidth = true
    var labelWidth:CGFloat = 20
    var barCornerRadius:CGFloat = 0
    var isBackgroundBar = true
    var maxBarValue:CGFloat = 0
    
    private var barLabels:[NSTextField] = []
    private var barViews:[NSView] = []
    private var backgroundBarViews:[NSView] = []
    private var barValueLabels:[NSTextField] = []
    
    
    override func awakeFromNib() {
        
    }
    func reloadData() {
        loadControls()
        layoutBars()
        var values:[CGFloat] = []
        for bar in barViews {
            values.append(bar.frame.width)
            bar.frame.size.width = 0
        }
        for label in barValueLabels {
            label.isHidden = true
        }
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.8
            
            for (index,bar) in barViews.enumerated() {
                bar.animator().frame.size.width = values[index]
            }
        }, completionHandler: {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.3
                for label in self.barValueLabels {
                    label.animator().isHidden = false
                }
            }, completionHandler: nil)
            
        })
    }
    
    
    private func loadControls() {
        for v in barLabels {v.removeFromSuperview()}
        for v in barViews {v.removeFromSuperview()}
        for v in barValueLabels {v.removeFromSuperview()}
        for v in backgroundBarViews {v.removeFromSuperview()}
        barLabels.removeAll()
        barViews.removeAll()
        barValueLabels.removeAll()
        backgroundBarViews.removeAll()
        
        let barNumbers = dataSource?.numberOfBars(self) ?? 0
        for i in 0..<barNumbers {
            let newValue = CGFloat(dataSource?.hBarChartView(self, valueForBarAt: i) ?? 0)
            self.maxBarValue = maxBarValue < newValue ? newValue : maxBarValue
            let s =  dataSource?.hBarChartView(self, labelForBarAt: i) ?? ""
            let label = NSTextField()
            let attForLabel = dataSource?.hBarChartView(self, attributeForBarLabelAt: i)
            setLable(label)
            label.isEditable = false
            label.isSelectable = false
            label.attributedStringValue = NSAttributedString(string: s, attributes: attForLabel)
            barLabels.append(label)
            let barValueLabel = NSTextField()
            let attForValue = dataSource?.hBarChartView(self, attributeForValueLabel: i)
            let value = String(format: "%.2f", arguments: [dataSource?.hBarChartView(self, valueForBarAt: i) ?? 0.0])
            setLable(barValueLabel)
            barValueLabel.isEditable = false
            barValueLabel.isSelectable = false
            barValueLabel.attributedStringValue = NSAttributedString(string: value, attributes: attForValue)
            barValueLabels.append(barValueLabel)
            let bar = NSView()
            bar.wantsLayer = true
            bar.layer?.backgroundColor = dataSource!.hBarChartView(self, colorForBarAt: i).cgColor
            bar.layer?.cornerRadius = barCornerRadius
            barViews.append(bar)
            let bgBar = NSView()
            bgBar.wantsLayer = true
            bgBar.layer?.backgroundColor = dataSource!.hBarChartView(self, backgroundColorForBarAt: i).cgColor
            bgBar.layer?.cornerRadius = barCornerRadius
            backgroundBarViews.append(bgBar)
        }
    }
    
    private func layoutBars() {
        let width = frame.width
        let height = frame.height
        let maxValue = width - (leftPadding+labelWidth+5+rightPadding)
        
        for (index,v) in barViews.enumerated() {
            if isBackgroundBar {
                addSubview(backgroundBarViews[index])
            }
            addSubview(v)
            if autoBarWidth {
                let barWidth = (height-(topPadding+bottomPadding)-(CGFloat(dataSource!.numberOfBars(self))*barSpace))/(CGFloat(dataSource!.numberOfBars(self)))
                let value = CGFloat(dataSource?.hBarChartView(self, valueForBarAt: index) ?? 0)
                let offset = CGFloat(index)*(barSpace+barWidth)
                v.frame = CGRect(x: leftPadding+labelWidth+5, y: height-10-barWidth-offset, width: value/maxBarValue*maxValue, height: barWidth)
                backgroundBarViews[index].frame = CGRect(x: leftPadding+labelWidth+5, y: height-10-barWidth-offset, width: maxValue, height: barWidth)
            } else {
                let barWidth = CGFloat(dataSource?.hBarChartView(self, widthForBarAt: index) ?? 5)
                let value = CGFloat(dataSource?.hBarChartView(self, valueForBarAt: index) ?? 0)
                let offset = CGFloat(index)*(barSpace+barWidth)
                v.frame = CGRect(x: leftPadding+labelWidth+5, y: height-10-barWidth-offset, width: value/maxBarValue*maxValue, height: barWidth)
                backgroundBarViews[index].frame = CGRect(x: leftPadding+labelWidth+5, y: height-10-barWidth-offset, width: maxValue, height: barWidth)
            }
        }
        for (index,v) in barLabels.enumerated() {
            addSubview(v)
            let barFrame = barViews[index].frame
            v.frame = CGRect(x: leftPadding, y: barFrame.minY, width: labelWidth, height: barFrame.height)
        }

        for (index,v) in barValueLabels.enumerated() {
            addSubview(v)
            let barFrame = isBackgroundBar ? backgroundBarViews[index].frame : barViews[index].frame
            v.frame = CGRect(x: barFrame.maxX, y: barFrame.minY, width: rightPadding, height: barFrame.height)
        }
    }
    private func setLable(_ lable:NSTextField) {
        lable.cell = HBTextFieldCell()
        lable.isEditable = false
        lable.isBordered = false
        lable.alignment = .center
    }
}
extension HBarChartView {
    var leftPadding:CGFloat {return 8}
    var rightPadding:CGFloat {return 80}
    var topPadding:CGFloat {return 8}
    var bottomPadding:CGFloat {return 8}
}

class HBTextFieldCell : NSTextFieldCell {
    override func titleRect(forBounds rect: NSRect) -> NSRect {
        var titleRect = super.titleRect(forBounds: rect)
        
        let minimumHeight = self.cellSize(forBounds: rect).height
        titleRect.origin.y += (titleRect.height - minimumHeight) / 2
        titleRect.size.height = minimumHeight
        
        return titleRect
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: titleRect(forBounds: cellFrame), in: controlView)
    }
}
