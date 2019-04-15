//
//  Constants.swift
//  RXEmptyBgExample
//
//  Created by AlphaDog on 2018/4/12.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

var tableOnce: NSInteger = 0
var collectionOnce: NSInteger = 0

struct AssociatedKey {
    static var emptyInfoDataSource = "emptyInfoDataSource"
    static var emptyInfoDelegate = "emptyInfoDelegate"
    static var emptyInfoView = "emptyInfoDelegate"
}

struct SwizzleSelector {
    static let tableViewSwizzleReload = #selector(UIScrollView.rx_tableViewReload)
    static let tableViewSwizzleEndUPdates = #selector(UIScrollView.rx_tableViewEndUpdates)
    static let collectionViewSwizzleReload = #selector(UIScrollView.rx_collectionViewReload)
    static let collectionViewSwizzleBatchUpdates = #selector(UIScrollView.rx_collectionViewPerformBatchUpdates(_:completion:))
}

struct TableViewSelector {
    static let reloadData = #selector(UITableView.reloadData)
    static let endUpdates = #selector(UITableView.endUpdates)
    static let numberOfSections = #selector(UITableViewDataSource.numberOfSections(in:))
}

struct CollectionViewSeletor {
    static let reloadData = #selector(UICollectionView.reloadData)
    static let performBatchUpdates = #selector(UICollectionView.performBatchUpdates(_:completion:))
    static let numberOfSections = #selector(UICollectionViewDataSource.numberOfSections(in:))
}

struct DefaultValues {
    static let verticalOffset: CGFloat = 0
    static let verticalSpace: CGFloat = 12
    static let verticalSpaces = [verticalSpace, verticalSpace]
    static let titleMargin: CGFloat = 15
    static let descriptionMargin: CGFloat = 15
}
