//
//  StarsViewController.swift
//  Stars
//
//  Created by Hannah Bain on 4/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class StarsViewController: UIViewController {
// Mark: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    let starsController = StarsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
// Mark: IBActions
    @IBAction func printButtonTapped(_ sender: Any) {
        
    }
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let starName = nameTextField.text,
            let distanceInLightYears = distanceTextField.text,
        let distance = Double(distanceInLightYears),
            !starName.isEmpty else { return }
        
        starsController.createStar(name: starName, distance: distance)
    }
    // MARK: UITableViewDataSource

    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starsController.stars.count
        
    }
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "StarCell") as? StarTableViewCell else { return UITableViewCell() }
        
        let star = starsController.stars[indexPath.row]
        
        cell.star = star
        
        return cell
    }
    
    
}

class StarTableViewCell: UITableViewCell {
    // Mark: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var star: Star? {
        didSet {
            self.updateViews()
        }
        
        func updateViews() {
        guard let star = star else { return }
        nameLabel.text = star.name
        distanceLabel.text = "\(star.distance) light years away"
        }
    }
    
}

