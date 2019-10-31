//
//  FriendsHomeViewController.swift
//  Friendlist
//
//  Created by Mufakkharul Islam Nayem on 10/25/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import UIKit

class FriendsHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showAlertButtonDidTap(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Alert!", message: "Please Turn Off the fan.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController, let friendListViewController = destination.viewControllers.first as? FriendListViewController {
            friendListViewController.user = "Nayem"
        }
    }

}
