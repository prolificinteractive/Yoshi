//
//  YoshiCustomMenu.swift
//  Pods
//
//  Created by Christopher Jones on 2/8/16.
//
//

public protocol YoshiCustomMenu: YoshiMenu {

    var setup: () -> () { get }
    var completion: () -> () { get }

}
