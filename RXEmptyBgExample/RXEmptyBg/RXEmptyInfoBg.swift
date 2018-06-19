//
//  RXEmptyInfoBg.swift
//  RXEmptyBgExample
//
//  Created by AlphaDog on 2018/4/12.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // MARK: - Property
    @objc weak public var emptyBgDataSource: EmptyBgDataSource? {
        get {
            let container = objc_getAssociatedObject(self, &AssociatedKey.emptyInfoDataSource) as? WeakObjectContanier
            return container?.obj as? EmptyBgDataSource
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKey.emptyInfoDataSource, WeakObjectContanier(object: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                switch self {
                case is UITableView:
                    UITableView.rx_swizzleTableViewReload()
                    UITableView.rx_swizzleTableViewEndUpdates()
                case is UICollectionView:
                    UICollectionView.rx_swizzleTableViewReload()
                    UICollectionView.rx_swizzleCollectionPerformBatchUpdates()
                default:
                    break
                }
            } else {
                invalidEmptyInfoView()
            }
        }
    }
    
    @objc weak public var emptyBgDelegate: EmptyBgDelegate? {
        get {
            let container = objc_getAssociatedObject(self, &AssociatedKey.emptyInfoDelegate) as? WeakObjectContanier
            return container?.obj as? EmptyBgDelegate
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKey.emptyInfoDelegate, WeakObjectContanier(object: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var emptyInfoView: EmptyInfoView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.emptyInfoView) as? EmptyInfoView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.emptyInfoView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Layout
    func reloadEmptyInfoBg() {
        guard emptyInfoBgAvailable() else {
            return
        }
        
        guard emptyInfoViewShouldDisplay() && cellCount() == 0 else {
            if isEmptyInfoShow {
                invalidEmptyInfoView()
            }
            return
        }
        
        let emptyBgView: EmptyInfoView = {
            if let view = self.emptyInfoView {
                return view
            } else {
                let view = makeEmptyBg()
                emptyInfoView = view
                return view
            }
        }()
        
        emptyBgDelegate?.emptyBgWillDisplay(in: self)
        if emptyBgView.superview == nil {
            if (self is UITableView || self is UICollectionView) && subviews.count > 1 {
                insertSubview(emptyBgView, at: 0)
            } else {
                addSubview(emptyBgView)
            }
        }
        
        emptyBgView.prepareForDisplay()
        emptyBgView.noticeImgView.image = emptyInfoViewImg()
        emptyBgView.titleLabel.attributedText = emptyInfoViewTitle()
        emptyBgView.detailLabel.attributedText = emptyInfoViewDetail()
        emptyBgView.tapGesture?.isEnabled = emptyInfoViewTapEnable()
        emptyBgView.isHidden = false
        
        emptyBgView.layout()
        emptyBgView.layoutIfNeeded()
        
        emptyBgDelegate?.emptyBgDidDisplay(in: self)
    }
    
    // MARK: - Function
    fileprivate func invalidEmptyInfoView() {
//        emptyDataSetDelegate?.emptyDataSetWillDisappear(in: self)
        
        emptyInfoView?.removeFromSuperview()
        emptyInfoView = nil
        isScrollEnabled = true
        
//        emptyDataSetDelegate?.emptyDataSetDidDisappear(in: self)
    }
    
    private func emptyInfoBgAvailable() -> Bool {
        if let _ = emptyBgDataSource {
            return (self is UITableView) || (self is UICollectionView)
        }
        return false
    }
    
    private func cellCount() -> Int {
        var count = 0
        if let tableView = self as? UITableView {
            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: TableViewSelector.numberOfSections) {
                    let num = dataSource.numberOfSections?(in: tableView) ?? 0
                    for section in 0..<num {
                        count += dataSource.tableView(tableView, numberOfRowsInSection: section)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: CollectionViewSeletor.numberOfSections) {
                    let num = dataSource.numberOfSections?(in: collectionView) ?? 0
                    for section in 0..<num {
                        count += dataSource.collectionView(collectionView, numberOfItemsInSection: section)
                    }
                }
            }
        }
        
        return count
    }
    
    private func makeEmptyBg() -> EmptyInfoView {
        let view = EmptyInfoView(frame: frame)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        if emptyInfoViewTapEnable() {
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(emptyBgViewAction))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGesture)
            view.tapGesture = tapGesture
        }
        view.isHidden = true
        return view
    }
    
    // MARK: - Action
    public var isEmptyInfoShow: Bool {
        if let view = emptyInfoView {
            return !view.isHidden
        }
        return false
    }
    
    public func updateEmptyInfoBgIfNeeded() {
        reloadEmptyInfoBg()
    }
    
    @objc
    private func emptyBgViewAction() {
        emptyBgDelegate?.emptyBgTapAction(in: self)
    }
    
    // MARK: - EmptyBgDataSource & EmptyBgDelegate
    private func emptyInfoViewImg() -> UIImage? {
        return emptyBgDataSource?.imgForEmptyBg(in: self)
    }
    
    private func emptyInfoViewTitle() -> NSAttributedString? {
        return emptyBgDataSource?.titleForEmptyBg(in: self)
    }
    
    private func emptyInfoViewDetail() -> NSAttributedString? {
        return emptyBgDataSource?.detailForEmptyBg(in: self)
    }
    
    private func emptyInfoViewShouldDisplay() -> Bool {
        return emptyBgDelegate?.emptyBgShouldDisplay(in: self) ?? true
    }
    
    private func emptyInfoViewTapEnable() -> Bool {
        let bool = emptyBgDelegate?.emptyBgShouldTap(in: self)
        return bool ?? false
    }
    
    // MARK: - Swizzle
    private static func rx_swizzleTableViewReload() {
        swizzleMethod(for: UITableView.self, originalSelector: TableViewSelector.reloadData, swizzleSelector: SwizzleSelector.tableViewSwizzleReload)
    }
    
    private static func rx_swizzleTableViewEndUpdates() {
        swizzleMethod(for: UITableView.self, originalSelector: TableViewSelector.endUpdates, swizzleSelector: SwizzleSelector.tableViewSwizzleEndUPdates)
    }
    
    private static func rx_swizzleCollectionViewReload() {
        swizzleMethod(for: UITableView.self, originalSelector: CollectionViewSeletor.reloadData, swizzleSelector: SwizzleSelector.collectionViewSwizzleReload)
    }
    
    private static func rx_swizzleCollectionPerformBatchUpdates() {
        swizzleMethod(for: UITableView.self, originalSelector: CollectionViewSeletor.performBatchUpdates, swizzleSelector: SwizzleSelector.collectionViewSwizzleBatchUpdates)
    }
    
    @objc
    func rx_tableViewReload() {
        rx_tableViewReload()
        reloadEmptyInfoBg()
    }
    
    @objc
    func rx_tableViewEndUpdates() {
        rx_tableViewEndUpdates()
        reloadEmptyInfoBg()
    }
    
    @objc
    func rx_collectionViewReload() {
        rx_collectionViewReload()
        reloadEmptyInfoBg()
    }
    
    @objc
    func rx_collectionViewPerformBatchUpdates(_ updates: (() -> Swift.Void)?, completion: ((Bool) -> Swift.Void)? = nil) {
        rx_collectionViewPerformBatchUpdates(updates) { [weak self](completed) in
            completion?(completed)
            self?.reloadEmptyInfoBg()
        }
    }
    
    private static func swizzleMethod(for aClass: AnyClass, originalSelector: Selector, swizzleSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(aClass, originalSelector), let swizzleMethod = class_getInstanceMethod(aClass, swizzleSelector) else {
            return
        }
        
        let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))
        if didAddMethod {
            class_replaceMethod(aClass, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
    }
    
}
