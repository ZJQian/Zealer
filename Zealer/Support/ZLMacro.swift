//
//  ZLMacro.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import Foundation
import UIKit
import Hue

let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let IS_IPHONE_X = SCREEN_HEIGHT > 800 ? true : false
let NAV_HEIGHT: CGFloat = IS_IPHONE_X ? 88.0 : 64.0



let COLOR_F8 = UIColor(hex: "#F8F8F8")
let COLOR_CCC = UIColor(hex: "#CCCCCC")
let NAVI_COLOR = UIColor(hex: "#30343D")
let TABBAR_COLOR = UIColor(hex: "#747E91")
let BG_COLOR = UIColor(hex: "#EDEEF2")


///本地存储 userDefaults 的一些 key 值
let USER_ID = "USER_ID"



func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}
func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha/1.0)
}


func DLog<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line)
{
    #if DEBUG
        let str: String = ((fileName as NSString).pathComponents.last?.replacingOccurrences(of: "", with: "swift"))!
        
        print("\(str)---\(methodName)---[\(lineNumber)行]======>\(message)")
    #endif
}
