//
//  YoshiSingleSelectionMenu.swift
//  Yoshi
//
//  Created by Kanglei Fang on 7/2/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

public typealias YoshiSingleSelection = (title: String, subtitle: String?)

open class YoshiSingleSelectionMenu: YoshiSubmenu {
    
    open let title: String
    
    open var subtitle: String? {
        return availableSelections[selectedIndex].title
    }
    
    open var options: [YoshiGenericMenu] {
        return availableSelections.enumerated().map {
            YoshiSingleSelectionMenuItem(selection: $0.element,
                                         selected: $0.offset == selectedIndex,
                                         action: selectedAction)
        }
    }
    
    private let availableSelections: [YoshiSingleSelection]
    private var selectedIndex: Int
    private var selectedAction: ((YoshiSingleSelection) -> Void)?
    
    
    public init(title: String,
                options: [YoshiSingleSelection],
                selectedIndex: Int,
                didSelect: ((YoshiSingleSelection) -> Void)?) {
        self.title = title
        self.selectedIndex = selectedIndex
        self.availableSelections = options
        self.selectedAction = { [weak self] selectedSelection in
            for (index, selection) in self?.availableSelections.enumerated() ?? [].enumerated() {
                if selectedSelection.title == selection.title && selectedSelection.subtitle == selection.subtitle {
                    self?.selectedIndex = index
                    break
                }
            }
            didSelect?(selectedSelection)
        }
    }
    
}
