//
//  ViewController.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal final class ViewController: UIViewController {

    @IBOutlet fileprivate weak var environment: UILabel!
    @IBOutlet fileprivate weak var environmentDate: UILabel!

    fileprivate let dateFormatter: DateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(ViewController.didUpdateEnvironment(_:)),
                         name: NSNotification.Name(rawValue: Notifications.EnvironmentUpdatedNotification),
                         object: nil)

        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(ViewController.didUpdateEnvironmentDate(_:)),
                         name: NSNotification.Name(rawValue: Notifications.EnvironmentDateUpdatedNotification),
                         object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func didUpdateEnvironment(_ notification: Notification) {
        guard let environment = notification.object as? String else {
            return
        }

        self.environment.text = environment
    }

    func didUpdateEnvironmentDate(_ notification: Notification) {
        guard let environmentDate = notification.object as? Date else {
            return
        }

        self.environmentDate.text = dateFormatter.string(from: environmentDate)
    }

}
