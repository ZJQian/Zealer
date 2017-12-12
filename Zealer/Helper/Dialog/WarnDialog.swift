//
//  WarnDialog.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/7.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

private let dispose = DisposeBag()

class WarnDialog: UIView {

    
    fileprivate var v_bg = UIView()
    fileprivate var lb_warnInfo = UILabel()

    fileprivate var warnInfo: String? {
        
        didSet {
            lb_warnInfo.text = warnInfo
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        let app = UIApplication.shared.delegate as! AppDelegate
        app.window?.addSubview(self)
        
        
        v_bg.frame = self.bounds
        v_bg.backgroundColor = rgba(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        v_bg.alpha = 0
        addSubview(v_bg)
        
        let v_warn = UIView()
        v_warn.center = self.center
        v_warn.bounds = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH-60, height: (SCREEN_WIDTH-60)*0.6)
        v_warn.setRadius(radius: 3)
        v_warn.backgroundColor = UIColor.white
        addSubview(v_warn)
        
        lb_warnInfo.textColor = NAVI_COLOR
        lb_warnInfo.textAlignment = .center
        lb_warnInfo.frame = CGRect.init(x: 15, y: 15, width: v_warn.width-30, height: v_warn.height-70)
        v_warn.addSubview(lb_warnInfo)
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("知道啦", for: .normal)
        btn.backgroundColor = NAVI_COLOR
        btn.setRadius(radius: 3)
        btn.frame = CGRect.init(x: 20, y: v_warn.height-45, width: v_warn.width-40, height: 35)
        btn.rx.tap.subscribe { (sender) in
            
            self.hide()
        }.disposed(by: dispose)
        v_warn.addSubview(btn)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    fileprivate func show() {
        
        UIView.animate(withDuration: 0.2) {
            
            self.v_bg.alpha = 0.5
        }
    }
    
    fileprivate func hide() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.v_bg.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    class func showWarnDialog(warnString: String) {
        
        let dialog = WarnDialog.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dialog.warnInfo = warnString
        dialog.show()
    }
}
