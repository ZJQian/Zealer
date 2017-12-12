//
//  ZLRegisterViewController.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/7.
//  Copyright © 2017年 zjq. All rights reserved.
//

import UIKit

class ZLRegisterViewController: ZLBaseViewController {

    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var btn_code: UIButton!
    @IBOutlet weak var btn_state: UIButton!
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tf_psw: UITextField!
    @IBOutlet weak var tf_code: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        btn_code.setRadius(radius: 2)
        btn_register.setRadius(radius: 2)
    }

    @IBAction func registerAction(_ sender: Any) {
        
        DLog(message: "去注册")
    }
    @IBAction func getCodeAction(_ sender: Any) {
        
        DLog(message: "获取验证码")
    }
    @IBAction func backToLoginAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func dismissAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func switchStateAction(_ sender: Any) {
        
        btn_state.isSelected = !btn_state.isSelected
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
