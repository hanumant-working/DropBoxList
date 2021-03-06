//
//  FactsTableViewController.swift
//  DropBoxList
//
//  Created by Hanumant S on 29/01/18.
//  Copyright © 2018 Hanumant S. All rights reserved.
//

import UIKit

class FactsTableViewController: UITableViewController {

    var factsArray = [DataFactModel]()
    let jsonFileName = "Fact"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
        getData()
        
    }

    func configureScreen() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70.0
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(FactsTableViewController.getData))
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func getData() {
        DataParser().getFactsData(fileName: jsonFileName) { (data, screenTitle) in
            title = screenTitle
            factsArray = data
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        var secCount = 0
        if factsArray.count > 0 {
            secCount = 1
        }
        // Set empty screen message
        if secCount == 0 {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.size.width-32, height: tableView.bounds.size.height))
            noDataLabel.text          = "There are no data.."
            noDataLabel.textColor     = UIColor.gray
            noDataLabel.textAlignment = .center
            noDataLabel.numberOfLines = 0
            tableView.backgroundView  = noDataLabel
        } else {
            tableView.backgroundView = nil
        }
        
        return secCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Used default iOS Subtitle cell to set Title, Description and Image
        let cellIdentifier = "factsCell"
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
                return UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
            }
            cell.selectionStyle = .none
            return cell
        }()

        let factObj = factsArray[indexPath.row]
        
        // Set title
        if let title = factObj.title {
            cell.textLabel?.text = title
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
        }
        
        // Set description
        if let description = factObj.description {
            cell.detailTextLabel?.text = description
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        }
        
        // Set image
        cell.imageView?.image = UIImage(named: "placeholder") // Set default image
        if let imagePath = factObj.imageURL {
            cell.imageView?.contentMode = .scaleAspectFit
            cell.imageView?.imageFromURL(urlString: imagePath)
        }
    
        return cell
    }
 
}










