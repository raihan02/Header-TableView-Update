//
//  FriendListViewController.swift
//  Friendlist
//
//  Created by Mufakkharul Islam Nayem on 10/24/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var user: String?

    private var sections = [Section]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(user ?? "No User")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "FriendCell", bundle: Bundle.main) , forCellReuseIdentifier: "FriendCell")
        tableView.register(UINib(nibName: "HeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "header")
        // mimicking long running task in a background queue
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
            self.sections = Section.alphabaticallySectionedFriends()
        }
    }

    /*deinit {
        print("\(String(describing: self)) deinitialized")
    }*/

    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

extension FriendListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].friends.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        let friend = sections[indexPath.section].friends[indexPath.row]
        cell.nameLabel.text = friend.name
        cell.countryLabel.text = friend.countryName
        cell.aboutLabel.text = friend.bio
        return cell
    }
    


//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let title = sections[section].name
//        return title
//    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let indexTitles = sections.map { $0.name }
        return indexTitles
    }
}

extension FriendListViewController: UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView( frame: CGRect( x: 0, y: 0, width: 0, height: 70))
//
//        if section % 2 == 0{
//            header.backgroundColor = UIColor.blue
//        }
//        else
//        {
//            header.backgroundColor = UIColor.green
//        }
//
//        let level = UILabel(frame: CGRect(x: 200, y: 5, width: 15, height: 15))
//        //level.backgroundColor = UIColor.gray
//        level.textColor = UIColor.black
//        level.text = sections[section].name
//        header.addSubview(level)
//        return header
        
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HeaderView
        view.sectionTitleLabel.text = sections[section].name
        if section % 2 == 0{
        let background = UIView(frame: view.bounds)
        background.backgroundColor = .cyan
        view.backgroundView = background
        }
        else
        {
            let background = UIView(frame: view.bounds)
            background.backgroundColor = .red
            view.backgroundView = background
            
        }
        return view
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = sections[indexPath.section].friends[indexPath.row]
        print("Tapped \(friend.name)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, actionPerformed) in
            self.sections[indexPath.section].friends.remove(at: indexPath.row)
            actionPerformed(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeActionConfiguration.performsFirstActionWithFullSwipe = false
        return swipeActionConfiguration
    }
    
   

}
