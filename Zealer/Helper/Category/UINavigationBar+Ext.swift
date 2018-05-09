//
//  UINavigationBar+Ext.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/26.
//  Copyright © 2017年 zjq. All rights reserved.
//

import Foundation
import UIKit

var key:String = "CoverView"

extension UINavigationBar {
    
    var coverView:UIView?{
        
        set{
            //runtime添加动态关联的属性
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            //runtime读取动态关联的属性
            return objc_getAssociatedObject(self, &key) as? UIView
        }
    }
    
    
    
    /**
     *  设置 背景色
     */
    @available(iOS 8.0,*)
    func setViewColor(_ color:UIColor)
    {
        //如果覆盖图层为nil
        if(self.coverView == nil)
        {
            //设置背景图片及度量
            self.setBackgroundImage(UIImage(), for: .default)
            //去除自定义背景图后形成的下端黑色横线
            self.shadowImage = UIImage()
            //设置图层的frame
            let view = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.width, height: self.frame.height + 20))
            view.isUserInteractionEnabled = false//人机不交互
            view.autoresizingMask = [.flexibleWidth , .flexibleHeight]//自适应宽度和高度
            //将图层添加到导航Bar的底层
            self.insertSubview(view, at: 0)
            
            //因为这里不是一个真正的属性，是在runtime时进行关联的属性，所以相关属性的修改需要实例对象来"赋值"
            self.coverView = view
        }
        
        self.coverView?.backgroundColor = color
    }
    
    
    
    /**
     *  设置透明度
     */
    @available (iOS 8.0, *)
    func setViewAlpha(_ alpha:CGFloat)
    {
        //如果view = self.coverView不成立，就return
        guard let view = self.coverView else
        {
            return
        }
        
        self.coverView!.backgroundColor = view.backgroundColor?.withAlphaComponent(alpha)
    }
    
    
    
    /**
     *  清除图层,视图消失时需要调用该方法，不然会影响其他页面的效果
     */
    @available (iOS 8.0, *)
    func relieveCover()
    {
        self.setBackgroundImage(nil, for: .default)
        coverView?.removeFromSuperview()
        coverView = nil
    }
}
