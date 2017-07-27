//
//  WBCommon.swift
//  JTWeibo
//
//  Created by BJT on 17/7/13.
//  Copyright © 2017年 BJT. All rights reserved.
// 一些常量

import Foundation


// MARK: - 微博账号信息
/// 账号信息
let  WBAppKey = "1073508449"
let  WBAppSecret = "b73b9c801631be81412e904cb5e4287d"
let  WBAppRedirectUri = "http://www.baidu.com"

// MARK: - 通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"



//MARK: - 微博配图视图常量
/// 配图视图外侧的间距
let pictureOutterMargin = CGFloat(12)

/// 配图视图内侧的间距
let pictureInnerMargin = CGFloat(3)

/// 视图 总宽度
let WBStatusPictureViewWidth = UIScreen.screenWidth() - 2 * pictureOutterMargin

/// 每个Item 默认的高宽度
let WBStatusPictureItemWidth = (WBStatusPictureViewWidth - CGFloat(2) * pictureInnerMargin)/CGFloat(3)
