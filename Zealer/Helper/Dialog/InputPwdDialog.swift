//
//  InputPwdDialog.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/21.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias InputFinished = (_ code: String) -> Void

class InputPwdDialog: UIView {

    var inputCodeFinished: InputFinished?
    var hideCallBack: HideCallBack?
    
    
    var lb_array = Array<UILabel>()
    var lb1 = UILabel()
    var lb2 = UILabel()
    var lb3 = UILabel()
    var lb4 = UILabel()
    var v_bg = UIView()


    var tf = UITextField()
    let verifyNum       = 4    //验证码位数
    
    init(frame: CGRect, inputFinished: @escaping InputFinished) {
        super.init(frame: frame)
        
        
        let app = UIApplication.shared.delegate as! AppDelegate
        app.window?.addSubview(self)
        
        
        v_bg.frame = CGRect.init(x: 0, y: self.height, width: SCREEN_WIDTH, height: self.height)
        v_bg.backgroundColor = rgba(red: 0, green: 0, blue: 0, alpha: 0.5)
        addSubview(v_bg)
        
        inputCodeFinished = inputFinished
        
        let lb_width: CGFloat = 50.0
        let lb_height: CGFloat = 50.0
        let spacing: CGFloat = 18.0
        let margin = (self.width-lb_width*4-spacing*3)/2.0
        
        for index in 0..<verifyNum {
            let lb = UILabel.init(frame: CGRect.init(x: margin+(lb_width+spacing)*CGFloat(index), y: 50, width: lb_width, height: lb_height))
            lb.backgroundColor = UIColor.white
            lb.textAlignment = .center
            lb.layer.borderColor = NAVI_COLOR.cgColor
            lb.layer.borderWidth = 0.5
            lb.setRadius(radius: 5)
            lb.tag = 10 + index
            v_bg.addSubview(lb)
            lb_array.append(lb)
            if index == 0 {
                lb1 = lb
            }else if index == 1 {
                lb2 = lb
            }else if index == 2 {
                lb3 = lb
            }else{
                lb4 = lb
            }
        }
        
        tf = UITextField.init(frame: CGRect.init(x: margin, y: 50, width: lb_width, height: lb_height))
        tf.textAlignment = .center
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.rx.controlEvent(UIControlEvents.editingChanged).subscribe { () in
            
            
            
        }.disposed(by: DisposeBag())
        v_bg.addSubview(tf)
        tf.becomeFirstResponder()
        
    }

    func show() {
        
        UIView.animate(withDuration: 0.3) {
            
            var rect = self.v_bg.frame
            rect.origin.y -= self.v_bg.height
            self.v_bg.frame = rect
        }
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            var rect = self.v_bg.frame
            rect.origin.y += self.v_bg.height
            self.v_bg.frame = rect
        }) { (finish) in
            if (self.hideCallBack != nil) {
                self.hideCallBack!()
            }
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputPwdDialog: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
}
