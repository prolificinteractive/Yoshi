//
//  YoshiSingleSelectionMenu.swift
//  Yoshi
//
//  Created by Kanglei Fang on 7/2/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

/// A tuple with a title and an optional subtitle representing a single selection.
public typealias YoshiSingleSelection = (title: String, subtitle: String?)

/// A YoshiSubmenu implementation used to host a group of single selection.
/// Once provided with initial selection and options, Yoshi will maintain the selection and present them in a tableview.
open class YoshiSingleSelectionMenu: YoshiSubmenu {

    public let title: String

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

    /// Initialize the YoshiSingleSelectionMenu with title, options, initial selected index,
    /// and the action when one of the options is selected.
    ///
    /// - Parameters:
    ///   - title: Title for the menu.
    ///   - options: Available options under this menu.
    ///   - selectedIndex: Initial selected index among the options.
    ///   - didSelect: Action executed when one of the selection is selected by Yoshi.
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
