//
//  PrivacyPwdViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/22.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import RxSwift


private let dispose = DisposeBag()

typealias SettingPwdSuccess = () -> Void

class PrivacyPwdViewController: ZLBaseViewController {

    let verifyNum       = 4    //验证码位数
    let gap             = 20   //每个框之间的间隙
    let width           = 50   //每个框的 宽和高
    var settingPwdCallBack: SettingPwdSuccess?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        // Do any additional setup after loading the view.
    }
    
    override func leftItemAction() {
        super.leftItemAction()
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:=========== 创建 ===========
    var  verTF:UITextField?
    func createViews() {
        
        naviTitle = "设置密码"
        let backView = UIView()
        self.view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.width.equalTo(verifyNum * width + (verifyNum - 1) * gap)
            make.height.equalTo(width)
            make.centerX.equalTo(self.view)
        }
        
        var tmpLabel :UILabel?
        for i in 0..<verifyNum {
            let subLabel = UILabel()
            subLabel.tag = i + 10
            subLabel.setRadius(radius: 5)
            subLabel.layer.borderWidth = 0.5
            subLabel.textAlignment = .center
            subLabel.font = UIFont.systemFont(ofSize: 20)
            subLabel.layer.borderColor = NAVI_COLOR.cgColor
            backView.addSubview(subLabel)
            subLabel.snp.makeConstraints({ (make) in
                make.width.height.equalTo(width)
                make.centerY.equalTo(backView)
                if tmpLabel != nil {
                    make.left.equalTo(tmpLabel!.snp.right).offset(gap)
                }else {
                    make.left.equalTo(backView)
                }
            })
            tmpLabel = subLabel
        }
        
        verTF = UITextField()
        verTF?.keyboardType = UIKeyboardType.numberPad
        verTF?.tintColor = UIColor.clear
        verTF?.textColor = UIColor.clear
        verTF?.backgroundColor = UIColor.clear
        verTF?.delegate = self
        verTF?.rx.controlEvent(UIControlEvents.editingChanged).subscribe({ (event)  in
            
            let cStr = self.verTF?.text
            var cArray = [Character]()
            for c in (cStr?.characters)! {
                cArray.append(c)
            }
            
            for i in 0..<self.verifyNum {
                let label = self.view.viewWithTag(10 + i) as! UILabel
                if i < cArray.count {
                    label.text = "\(cArray[i])"
                    if i == self.verifyNum - 1 {
                        self.backToPrevious()
                    }
                }else {
                    label.text = ""
                }
            }
        }).disposed(by: dispose)
        backView.addSubview(verTF!)
        verTF?.snp.makeConstraints { (make) in
            make.edges.equalTo(backView)
        }
        verTF?.becomeFirstResponder()

        
        //避免 复制粘贴长按滑动等操作
        let forbidButton = UIButton()
        forbidButton.rx.tap.subscribe { () in
            
            self.verTF?.becomeFirstResponder()
        }.disposed(by: dispose)
        backView.addSubview(forbidButton)
        forbidButton.snp.makeConstraints { (make) in
            make.edges.equalTo(backView)
        }
    }
    
    private func backToPrevious() {
        
        settingPwdCallBack!()
        dismiss(animated: true, completion: nil)
    }
}

extension PrivacyPwdViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //判断只能输入数字，并且个数不能大于 verifyNum 个。
        if range.location + string.characters.count > verifyNum{
            return false
        }
        //10进制数进行判断，防止搜狗输入法导致数字键盘失效
        let cs = NSCharacterSet.decimalDigits.inverted
        let a = string.components(separatedBy: cs).joined()
        
        if string == a {
            return true
        }else {
            return false
        }
    }
}
