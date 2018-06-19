//
//  EmptyInfoView.swift
//  RXEmptyBgExample
//
//  Created by AlphaDog on 2018/4/11.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

class EmptyInfoView: UIView {

    // MARK: - Property
    struct controllerStruct {
        static let contentView = "contentView"
        static let noticeImgView = "noticeImgView"
        static let titleLabel = "titleLabel"
        static let detailLabel = "detailLabel"
    }
    
    var tapGesture: UITapGestureRecognizer?
    
    // MARK: - Controller
    lazy var contentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var noticeImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        contentsView.addSubview(imgView)
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        contentsView.addSubview(label)
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        contentsView.addSubview(label)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentsView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    func layout() {
        addConstraint(NSLayoutConstraint(item: contentsView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: contentsView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[\(controllerStruct.contentView)]", options: [], metrics: nil, views: [controllerStruct.contentView : contentsView]))
        
        var viewStrArr = [String]()
        var viewDic = [String: UIView]()
        
        if canShowImg() {
            viewStrArr.append(controllerStruct.noticeImgView)
            viewDic[controllerStruct.noticeImgView] = noticeImgView
            contentsView.addConstraint(NSLayoutConstraint(item: noticeImgView, attribute: .centerX, relatedBy: .equal, toItem: contentsView, attribute: .centerX, multiplier: 1, constant: 0))
        } else {
            noticeImgView.removeFromSuperview()
        }
        
        if canShowTitleLabel() {
            viewStrArr.append(controllerStruct.titleLabel)
            viewDic[controllerStruct.titleLabel] = titleLabel
            contentsView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: contentsView, attribute: .centerX, multiplier: 1, constant: 0))
            contentsView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentsView, attribute: .left, multiplier: 1, constant: 0))
            contentsView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: contentsView, attribute: .right, multiplier: 1, constant: 0))
        } else {
            titleLabel.removeFromSuperview()
        }
        
        if canShowDetailLabel() {
            viewStrArr.append(controllerStruct.detailLabel)
            viewDic[controllerStruct.detailLabel] = detailLabel
            contentsView.addConstraint(NSLayoutConstraint(item: detailLabel, attribute: .centerX, relatedBy: .equal, toItem: contentsView, attribute: .centerX, multiplier: 1, constant: 0))
            contentsView.addConstraint(NSLayoutConstraint(item: detailLabel, attribute: .left, relatedBy: .equal, toItem: contentsView, attribute: .left, multiplier: 1, constant: 0))
            contentsView.addConstraint(NSLayoutConstraint(item: detailLabel, attribute: .right, relatedBy: .equal, toItem: contentsView, attribute: .right, multiplier: 1, constant: 0))
        } else {
            titleLabel.removeFromSuperview()
        }
        
        if viewStrArr.count > 0 {
            var formatStr = String()
            for (index, str) in viewStrArr.enumerated() {
                formatStr.append("[\(str)]")
                if index < viewStrArr.count {
                    formatStr.append("-(8)-")
                }
            }
            contentsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|\(formatStr)|", options: [], metrics: nil, views: viewDic))
        }
    }
    
    // MARK: - Action
    func prepareForDisplay() {
        noticeImgView.image = nil
        titleLabel.attributedText = nil
        detailLabel.attributedText = nil
        tapGesture = nil
        removeAllConstraint()
    }
    
    // MARK: - Function
    private func removeAllConstraint() {
        removeConstraints(self.constraints)
        contentsView.removeConstraints(contentsView.constraints)
    }
    
    private func canShowImg() -> Bool {
        return noticeImgView.image != nil
    }
    
    private func canShowTitleLabel() -> Bool {
        if let text = titleLabel.attributedText {
            return text.length > 0
        }
        return false
    }
    
    private func canShowDetailLabel() -> Bool {
        if let text = detailLabel.attributedText {
            return text.length > 0
        }
        return false
    }

}
