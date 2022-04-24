//
//  UIViewController+.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

extension UIViewController {
    func showErrorAlert(error: Error) {
        guard let error = error as? ErrorBase else {
            return
        }
        let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
