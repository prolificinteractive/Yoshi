//
//  ViewController.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal final class ViewController: UIViewController {

    @IBOutlet private weak var environment: UILabel!
    @IBOutlet private weak var environmentDate: UILabel!

    private let dateFormatter: NSDateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle

        NSNotificationCenter.defaultCenter()
            .addObserver(self,
                         selector: #selector(ViewController.didUpdateEnvironment(_:)),
                         name: Notifications.EnvironmentUpdatedNotification,
                         object: nil)

        NSNotificationCenter.defaultCenter()
            .addObserver(self,
                         selector: #selector(ViewController.didUpdateEnvironmentDate(_:)),
                         name: Notifications.EnvironmentDateUpdatedNotification,
                         object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func didUpdateEnvironment(notification: NSNotification) {
        guard let environment = notification.object as? String else {
            return
        }

        self.environment.text = environment
    }

    func didUpdateEnvironmentDate(notification: NSNotification) {
        guard let environmentDate = notification.object as? NSDate else {
            return
        }

        self.environmentDate.text = dateFormatter.stringFromDate(environmentDate)
    }

}
