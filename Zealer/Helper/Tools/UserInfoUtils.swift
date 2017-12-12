//
//  UserInfoUtils.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/7.
//  Copyright © 2017年 zjq. All rights reserved.
//

import Foundation
import UIKit

class UserInfoUtils {
    
    
    /// 存储 userID
    ///
    /// - Parameter userID: userID
    class func saveUserID(userID: String) {
        
        let ud = UserDefaults.standard
        ud.set(userID, forKey: USER_ID)
        ud.synchronize()
    }
    
    
    /// 移除 userID
    class func removeUserID() {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: USER_ID)
        ud.synchronize()
    }
    
    
    /// 判断是否登录
    ///
    /// - Returns: 登录状态
    class func isLogin() -> Bool {
        
        let ud = UserDefaults.standard
        let userID = ud.object(forKey: USER_ID) as? String
        if userID == nil {
            return false
        }else if (userID?.isEmpty)! {
            return false
        }
        return true
    }
}
