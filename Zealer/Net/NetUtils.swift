//
//  NetUtils.swift
//  Zealer
//
//  Created by ZJQian on 2017/12/7.
//  Copyright © 2017年 zjq. All rights reserved.
//

import Foundation
import Moya
import Result

enum APIManager {
    case in_theaters//正在热映
    case coming_soon//即将上映
    case top250//top250
    case us_box//北美票房榜
    case music_list(key:String)//音乐列表
}

let base_douban: String = "https://api.douban.com"

extension APIManager: TargetType {
    
    
    var baseURL: URL {
        
        return URL.init(string: base_douban)!
    }
    
    var path: String {
        
        switch self {
        case .in_theaters:
            return "/v2/movie/in_theaters"
        case .coming_soon:
            return "/v2/movie/coming_soon"
        case .top250:
            return "/v2/movie/top250"
        case .us_box:
            return "/v2/movie/us_box"
        case .music_list(key: _):
            return "/v2/music/search"
        }
    }
    
    var method: Moya.Method {
        
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .music_list(key: let q):
            var params: [String: Any] = [:]
            params["q"] = q
            return .requestParameters(parameters: params,encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        
        return nil
    }
}
class CustomePlugin: PluginType {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func willSend(request: RequestType, target: TargetType) {
        //........//实现发送请求前需要做的事情
        
        DLog(message: "will send")
    }
    
    func didReceive(result: Result<Response, MoyaError>, target: TargetType) {
        
        DLog(message: result)
        guard case Result.failure(_) = result
            
            else {
                
                
            return
                
        }//只监听失败
        
        let error = result.error
        
        // 弹出Alert
        let alertViewController = UIAlertController(title: "Error", message: "Request failed with status code: \(error?.response?.statusCode ?? 0)", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertViewController, animated: true)
    }
}
