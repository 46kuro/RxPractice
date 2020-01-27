//
//  ViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/26.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Section {
        case iPhone(rows: [iPhoneRow])
        case tableCollectionView
        case complex
        
        var title: String {
            switch self {
            case .iPhone: return "IPHONE EXAMPLES"
            case .tableCollectionView: return "TABLE/COLLECTION VIEW EXAMPLES"
            case .complex: return "COMPLEX EXAMPLES"
            }
        }
        
        enum iPhoneRow: CaseIterable {
            case addingNumbers
            case simpleValidation
            case geolocationSubscription
            
            var title: String {
                switch self {
                case .addingNumbers: return "Adding numbers"
                case .simpleValidation: return "Simple validation"
                case .geolocationSubscription: return "Geolocation Subscription"
                }
            }
            
            var subTitle: String {
                switch self {
                case .addingNumbers: return "Bindings"
                case .simpleValidation: return "Bindings"
                case .geolocationSubscription: return "Observers, services and Drive example"
                }
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var sections: [Section] = {
        return [Section.iPhone(rows: Section.iPhoneRow.allCases), 
                Section.tableCollectionView, 
                Section.complex]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Rx Examples" 
            
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .iPhone(let rows):
            return rows.count
        case .tableCollectionView:
            return 1
        case .complex:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .iPhone(let rows):
            let row = rows[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "iPhone")
            cell.textLabel?.text = row.title
            cell.detailTextLabel?.text = row.subTitle
            return cell
        case .tableCollectionView:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "notImpl")
            cell.textLabel?.text = "Not implement"
            return cell
        case .complex:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "notImpl")
            cell.textLabel?.text = "Not implement"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch sections[indexPath.section] {
        case .iPhone(let rows):
            switch rows[indexPath.row] {
            case .addingNumbers:
                let viewController = AddingNumbersViewController.instantiate() as! AddingNumbersViewController
                navigationController?.pushViewController(viewController, animated: true)
            case .simpleValidation:
                let viewController = SimpleValidationViewController.instantiate() as! SimpleValidationViewController
                navigationController?.pushViewController(viewController, animated: true)
            case .geolocationSubscription:
                let viewController = GeolocationSubscriptionViewController.instantiate() as! GeolocationSubscriptionViewController
                navigationController?.pushViewController(viewController, animated: true)
            }
        case .tableCollectionView:
            break
        case .complex:
            break
        }
    }
}
