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
    var scrollView = UIScrollView()
    let v_line = UIView()
    
    init(frame: CGRect,titleArray: Array<String>) {
        super.init(frame: frame)
        
        scrollView = UIScrollView.init(frame: bounds)
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
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
            scrollView.addSubview(btn)
            sum_width += width
            
            if index == 0 {
                v_line.frame = CGRect.init(x: btn.left, y: scrollView.height-3, width: btn.width, height: 3);
                v_line.backgroundColor = UIColor.white
                scrollView.addSubview(v_line)
            }
        }
        scrollView.contentSize = CGSize.init(width: sum_width+CGFloat(titleArray.count*padding), height: scrollView.height)
        
    }
    
    public func lineWillRoll(toIndex index: NSInteger) {
        
        let btn = viewWithTag(index+100) as! UIButton
        animitedLine(withButton: btn)
    }
    
    @objc func changeLineFrame(_ sender: UIButton) {
        
        self.delegate?.clickSegment(withIndex: sender.tag-100)
        animitedLine(withButton: sender)
    }
    
    private func animitedLine(withButton button: UIButton) {
        
        scrollView.scrollRectToVisible(CGRect.init(x: button.frame.minX-30, y: 0, width: scrollView.width, height: scrollView.height), animated: true)
        UIView.animate(withDuration: 0.5) {
            var rect = self.v_line.frame
            rect.origin.x = button.left
            rect.size.width = button.width
            self.v_line.frame = rect
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
