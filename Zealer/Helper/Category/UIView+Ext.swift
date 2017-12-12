//
//  UIView+Ext.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setRadius(radius: CGFloat) {
        
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
