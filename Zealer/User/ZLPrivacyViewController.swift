//
//  ZLPrivacyViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/21.
//  Copyright © 2017年 zjq. All rights reserved.
//  设置密码和指纹登录

import UIKit
import RxSwift
import LocalAuthentication

private let dispose = DisposeBag()
class ZLPrivacyViewController: ZLBaseViewController {

    @IBOutlet weak var privacyTableView: UITableView!
    let titleArray = ["开启密码锁定","开启Touch ID指纹解锁"]
    var switch_pwd: UISwitch? = nil
    var switch_touch: UISwitch? = nil
    var input: InputPwdDialog?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        naviTitle = "安全设置"
    }
    
    override func leftItemAction() {
        
        if input != nil {
            input?.hide()
        }else{
            super.leftItemAction()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "privacyCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = titleArray[indexPath.section]
        
        let switchBar = UISwitch()
        cell?.contentView.addSubview(switchBar)
        switchBar.snp.makeConstraints { (make) in
            make.centerY.equalTo((cell?.contentView)!)
            make.right.equalTo(-12)
        }
        if indexPath.section == 0 {
            switch_pwd = switchBar
            switchBar.rx.controlEvent(.touchUpInside).subscribe({ (sender) in
                
                let vc = PrivacyPwdViewController()
                let nav = ZLBaseNavigationController.init(rootViewController: vc)
                vc.settingPwdCallBack = {
                    
                    switchBar.setOn(switchBar.isOn, animated: true)
                }
                self.present(nav, animated: true, completion: nil)
            }).disposed(by: dispose)
        }else{
            switch_touch = switchBar
            switchBar.rx.controlEvent(UIControlEvents.touchUpInside).subscribe({ (event) in
                
                self.touchID()
            }).disposed(by: dispose)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func touchID() {
        let laContext = LAContext()
        var error: NSError?
        if laContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            laContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请验证你的指纹", reply: { (success: Bool, error: NSError?) in
                
                if success {
                    
                    DLog(message: "验证成功")
                }else{
                    
                    
                    DLog(message: error)
                    switch error?.code {
                        
                        
                    default: break
                        
                    }
                }
                } as! (Bool, Error?) -> Void)
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
