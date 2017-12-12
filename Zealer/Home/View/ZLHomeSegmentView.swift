//
//  ZLHomeSegmentView.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import YYKit


protocol ZLHomeSegmentViewDelegate {
    
    func clickSegment(withIndex index:Int)
}
class ZLHomeSegmentView: UIView {

    var delegate: ZLHomeSegmentViewDelegate?
    
    
    let v_line = UIView()
    
    init(frame: CGRect,titleArray: Array<String>) {
        super.init(frame: frame)
        
        let sv = UIScrollView.init(frame: bounds)
        sv.showsHorizontalScrollIndicator = false
        addSubview(sv)
        
        var sum_width: CGFloat = 0.0
        let padding = 20
        
        
        for index in 0..<titleArray.count {
            let str = titleArray[index] as NSString
            let width = str.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(40)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)], context: nil).size.width
            
            let btn = UIButton.init(type: .custom)
            btn.setTitle(titleArray[index], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
            btn.frame = CGRect.init(x: sum_width + CGFloat(padding*index), y: 0, width: width, height: 40)
            btn.tag = 100+index
            btn.addTarget(self, action: #selector(changeLineFrame(_:)), for: .touchUpInside)
            sv.addSubview(btn)
            sum_width += width
            
            if index == 0 {
                v_line.frame = CGRect.init(x: btn.left, y: sv.height-3, width: btn.width, height: 3);
                v_line.backgroundColor = UIColor.white
                sv.addSubview(v_line)
            }
        }
        sv.contentSize = CGSize.init(width: sum_width+CGFloat(titleArray.count*padding), height: sv.height)
        
    }
    
    @objc func changeLineFrame(_ sender: UIButton) {
        
        self.delegate?.clickSegment(withIndex: sender.tag-100)
        UIView.animate(withDuration: 0.5) {
            var rect = self.v_line.frame
            rect.origin.x = sender.left
            rect.size.width = sender.width
            self.v_line.frame = rect
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
