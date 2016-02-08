//
//  YoshiDateSelectorMenu.swift
//  Pods
//
//  Created by Christopher Jones on 2/8/16.
//
//

public protocol YoshiDateSelectorMenu: YoshiMenu {

    var didUpdateDate: (dateSelected: NSDate) -> () { get }

}
