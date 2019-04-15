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
        static let actionBtn = "actionBtn"
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
    
    lazy var actionBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 4
        btn.layer.borderColor = hexadecimalColor(hexadecimal: "#007eea").cgColor
        btn.layer.borderWidth = 0.5
        btn.setTitleColor(hexadecimalColor(hexadecimal: "#007eea"), for: .normal)
        contentsView.addSubview(btn)
        return btn
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
            detailLabel.removeFromSuperview()
        }
        
        if canShowActionBtn() {
            viewStrArr.append(controllerStruct.actionBtn)
            viewDic[controllerStruct.actionBtn] = actionBtn
            contentsView.addConstraint(NSLayoutConstraint(item: actionBtn, attribute: .centerX, relatedBy: .equal, toItem: contentsView, attribute: .centerX, multiplier: 1, constant: 0))
        } else {
            actionBtn.removeFromSuperview()
        }
        
        if viewStrArr.count > 0 {
            var formatStr = String()
            for (index, str) in viewStrArr.enumerated() {
                if index < viewStrArr.count {
                    if index == 0 {
                        formatStr += "-(8)"
                    } else {
                        formatStr += "(8)"
                    }
                }
                formatStr += "-[\(str)]-"
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

    private func canShowActionBtn() -> Bool {
        if let text = actionBtn.titleLabel?.text {
            return text.trimmingCharacters(in: .whitespaces).count > 0
        }
        return false
    }
    
    func hexadecimalColor(hexadecimal:String) -> UIColor {
        var cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
    }
}
