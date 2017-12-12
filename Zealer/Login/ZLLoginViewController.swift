//
//  ZLLoginViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/6.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit

typealias LoginSuccessCallback = () -> Void

class ZLLoginViewController: ZLBaseViewController {

    var loginSuccessCallback: LoginSuccessCallback?
    
    
    @IBOutlet weak var tf_psw: UITextField!
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        btn_login.setRadius(radius: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func loginAction(_ sender: Any) {
        
        if (tf_phone.text?.isEmpty)! {
            WarnDialog.showWarnDialog(warnString: "请输入用户名")
            return
        }else if(tf_psw.text?.isEmpty)! {
            WarnDialog.showWarnDialog(warnString: "请输入密码")
            return
        }
        
        UserInfoUtils.saveUserID(userID: "user1")
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            
            if (self.loginSuccessCallback != nil) {
                self.loginSuccessCallback!()
            }
            self.dismiss(animated: true, completion: nil)
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
