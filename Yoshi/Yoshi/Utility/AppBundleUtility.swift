//
//  AppBundleUtility.swift
//  Yoshi
//
//  Created by Michael Campbell on 1/4/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

let appDisplayNameDictionaryKey = "CFBundleName"
let appVersionNumberDictionaryKey = "CFBundleShortVersionString"
let appBuildNumberDictionaryKey = "CFBundleVersion"

internal class AppBundleUtility: NSObject {

    class func appVersionText() -> String {
        return "\(AppBundleUtility.appDisplayName()) | Version \(AppBundleUtility.appVersionNumber()) (\(AppBundleUtility.appBuildNumber()))"
    }

    private class func appDisplayName() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(appDisplayNameDictionaryKey) as? String ?? ""
    }

    private class func appVersionNumber() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(appVersionNumberDictionaryKey) as? String ?? ""
    }

    private class func appBuildNumber() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(appBuildNumberDictionaryKey) as? String ?? ""
    }

}
