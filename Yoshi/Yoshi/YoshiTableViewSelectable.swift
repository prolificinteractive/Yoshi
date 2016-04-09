//
//  YoshiTableViewSelectable.swift
//  Yoshi
//
//  Created by Daniel Vancura on 4/9/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/** 
 A selectable item inside a debugging table view.
 */
public protocol YoshiTableViewSelectable: class {

    // Indicates whether or not this item is selectable.
    var selected: Bool { get set }

}
