//
//  AlertManager.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 03/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

class AlertManager {

    private init() {}

    static func show(title: String, message: String, viewController: UIViewController) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)

        viewController.present(alert, animated: true)
    }

}
