//
//  HomeViewModel.swift
//  Zealer
//
//  Created by ZJQian on 2018/5/2.
//  Copyright © 2018年 zjq. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import ObjectMapper

//class HomeViewModel {
//
//
//    /**** 输出部分 ***/
//    //所有的查询结果
//    let searchResult: Driver<HomeModels>
//
//    //查询结果里的资源列表
//    let repositories: Driver<[HomeModel]>
//
//
//    //导航栏标题
//    let navigationTitle: Driver<String>
//
//    //ViewModel初始化（根据输入实现对应的输出）
////    init(api_type: APIManager) {
////
////        //生成查询结果序列
//////        self.searchResult = NetService.rx.request(.repositories($0))
//////            .filterSuccessfulStatusCodes()
//////            .mapObject(GitHubRepositories.self)
//////            .asDriver(onErrorDriveWith: Driver.empty())
////
////
////
//////        //生成查询结果里的资源列表序列（如果查询到结果则返回结果，如果是清空数据则返回空数组）
//////        self.repositories = Driver.merge(
//////            searchResult.map{ $0.items }
//////        )
//////
//////        //生成导航栏标题序列（如果查询到结果则返回数量，如果是清空数据则返回默认标题）
//////        self.navigationTitle = Driver.merge(
//////            searchResult.map{ "共有 \($0.totalCount!) 个结果" }
//////        )
////    }
//}
