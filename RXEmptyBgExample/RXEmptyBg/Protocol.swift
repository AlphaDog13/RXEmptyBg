//
//  Protocol.swift
//  RXEmptyBgExample
//
//  Created by AlphaDog on 2018/4/12.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

@objc(EmptyBgDataSource)
public protocol EmptyBgDataSource {
    func imgForEmptyBg(in scrollView: UIScrollView) -> UIImage?
    func titleForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString?
    func detailForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString?
}

@objc(EmptyBgDelegate)
public protocol EmptyBgDelegate {
    func emptyBgShouldDisplay(in scrollView: UIScrollView) -> Bool
    func emptyBgShouldTap(in scrollView: UIScrollView) -> Bool
    
    func emptyBgTapAction(in scrollView: UIScrollView)
    
    func emptyBgWillDisplay(in scrollView: UIScrollView)
    func emptyBgDidDisplay(in scrollView: UIScrollView)
}

extension EmptyBgDataSource {
    
//    func imgForEmptyBg(in scrollView: UIScrollView) -> UIImage? {
//        return nil
//    }
//
//    func titleForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString? {
//        return nil
//    }
//
//    func detailForEmptyBg(in scrollView: UIScrollView) -> NSAttributedString? {
//        return nil
//    }
    
}

extension EmptyBgDelegate {
    
//    func emptyBgShouldTap(in scrollView: UIScrollView) -> Bool {
//        return false
//    }
//
//    func emptyBgTapAction(in scrollView: UIScrollView) {
//
//    }
    
}
