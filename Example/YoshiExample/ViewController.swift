//
//  ViewController.swift
//  YoshiExample
//
//  Created by Michael Campbell on 12/22/15.
//  Copyright © 2015 Prolific Interactive. All rights reserved.
//

import UIKit

internal final class ViewController: UIViewController {

    @IBOutlet private weak var environment: UILabel! {
        didSet {
            environment.text = environmentName
        }
    }
    @IBOutlet private weak var environmentDate: UILabel!

    private let dateFormatter: DateFormatter = DateFormatter()
    
    private var environmentName: String? {
        didSet {
            environment?.text = environmentName
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(ViewController.didUpdateEnvironmentDate(_:)),
                         name: NSNotification.Name(rawValue: Notifications.EnvironmentDateUpdatedNotification),
                         object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func updateEnvironment(name: String, url: URL) {
        environmentName = name
    }

    @objc func didUpdateEnvironmentDate(_ notification: Notification) {
        guard let environmentDate = notification.object as? Date else {
            return
        }

        self.environmentDate.text = dateFormatter.string(from: environmentDate)
    }

}
