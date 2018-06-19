# RXEmptyBg
参考：TBEmptyDataSet

## 内容

- [样例](#样例)
- [需要](#需要)
- [使用](#使用)
- [开始](#开始)
- [License](#license)

## 样例

![](https://github.com/AlphaDog13/RXCalendarView/blob/master/IMB_JD4rri.GIF) 


## 需要

- iOS 8.0+
- Xcode 9.0+
- Swift 3.0+

## 使用

### CocoaPods

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'RXEmptyBg', '~> 0.1.0'
end
```

## 开始

### 初始化

```swift
extension ViewController: EmptyBgDataSource, EmptyBgDelegate

lazy var tableView: UITableView = {
let tableView = UITableView(frame: CGRect.zero, style: .plain)
tableView.translatesAutoresizingMaskIntoConstraints = false
tableView.dataSource = self
tableView.delegate = self
tableView.emptyBgDelegate = self
tableView.emptyBgDataSource = self
return tableView
}()
```

### EmptyBgDataSource

```swift
func imgForEmptyBg(in scrollView: UIScrollView) -> UIImage?                //背景图片
func titleForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString?   //背景标题
func detailForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString?  //背景详情
```

### EmptyBgDelegate

```swift
func emptyBgShouldDisplay(in scrollView: UIScrollView) -> Bool  //是否显示背景
func emptyBgShouldTap(in scrollView: UIScrollView) -> Bool      //背景是否可点击

func emptyBgTapAction(in scrollView: UIScrollView)              //背景点击事件

func emptyBgWillDisplay(in scrollView: UIScrollView)            //背景将显示
func emptyBgDidDisplay(in scrollView: UIScrollView)             //背景已显示
```

## License

纯粹开源

