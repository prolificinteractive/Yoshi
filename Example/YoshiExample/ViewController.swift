//
//  ViewController.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var environment: UILabel!
    @IBOutlet private weak var environmentDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didUpdateEnvironment:"),
            name: Notifications.EnvironmentUpdatedNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didUpdateEnvironmentDate:"),
            name: Notifications.EnvironmentDateUpdatedNotification, object: nil)
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

        self.environmentDate.text = environmentDate.description
    }

}

