# HorizontalBarChartView
HorizontalBarChartView for osx

![HorizontalBarChartView](https://github.com/R0uter/HorizontalBarChartView/raw/master/img.png)

Just a simple horizontal bar chart.

you can change this color and bar width easily.


## Usage
Drag `HBarChartView` to your project.

Lets say you have data like this:
```swift
let values = [22.3,44.5,32,33,11]
let names = ["apple","pie","pen","coffie","cat"]
```

implement `HBarChartViewDataSource` :
```swift
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
```
then do this:
```swift
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
```

