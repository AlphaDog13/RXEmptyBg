//
//  WeakObjectContanier.swift
//  RXEmptyBgExample
//
//  Created by AlphaDog on 2018/4/12.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

class WeakObjectContanier: NSObject {
    
    weak var obj: AnyObject?
    
    init(object: Any) {
        super.init()
        obj = object as AnyObject
    }

}
