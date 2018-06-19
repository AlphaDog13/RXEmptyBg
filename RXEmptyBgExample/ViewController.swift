//
//  ViewController.swift
//  RXEmptyBgExample
//
//  Created by AlphaDog on 2018/4/11.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

struct controllers {
    static let TableView = "tableView"
    static let Cell = "Cell"
}

class ViewController: UIViewController {
    
    var rowNum: NSInteger = 0
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyBgDelegate = self
        tableView.emptyBgDataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(tableView)
        layout()
        tableView.reloadData()
    }

    func layout() {
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[\(controllers.TableView)]-|", options: [], metrics: nil, views: [controllers.TableView : tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[\(controllers.TableView)]-(16)-|", options: [], metrics: nil, views: [controllers.TableView : tableView]))
    }
    
    func changeBgInfo() {
        if rowNum == 0 {
            rowNum = 2
        } else {
            rowNum = 0
        }
        tableView.reloadData()
    }

}

extension ViewController: EmptyBgDataSource, EmptyBgDelegate {
    
    func imgForEmptyBg(in scrollView: UIScrollView) -> UIImage? {
        return UIImage.init(named: "成功")
    }
    
    func titleForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "title")
    }
    
    func detailForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "detail")
    }
    
    func emptyBgShouldDisplay(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyBgShouldTap(in scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyBgTapAction(in scrollView: UIScrollView) {
        changeBgInfo()
    }
    
    func emptyBgWillDisplay(in scrollView: UIScrollView) {
        
    }
    
    func emptyBgDidDisplay(in scrollView: UIScrollView) {
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: controllers.Cell)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: controllers.Cell)
        }
        cell!.accessoryType = .disclosureIndicator
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeBgInfo()
    }
    
}

