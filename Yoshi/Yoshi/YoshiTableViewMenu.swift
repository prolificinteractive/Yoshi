//
//  YoshiTableViewMenu.swift
//  Pods
//
//  Created by Christopher Jones on 2/8/16.
//
//

public protocol YoshiTableViewMenu: YoshiMenu {

    var displayItems: [YoshiTableViewMenuItem] { get }
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> () { get }

}
