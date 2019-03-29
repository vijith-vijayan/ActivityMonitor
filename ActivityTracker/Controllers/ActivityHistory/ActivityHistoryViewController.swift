//
//  ActivityHistoryViewController.swift
//  ActivityTracker
//
//  Created by Vijith TV on 28/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import UIKit

class ActivityHistoryViewController: BaseViewController {

    @IBOutlet weak var activityHistoryTabel: UITableView!
    
    lazy var viewModel: HistoryViewModel = {
       return HistoryViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVM()
        navigationBar(imageName: "back.png", direction: .left)
    }
    
    private func initVM() {
        
        viewModel.reloadTableCellClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.activityHistoryTabel.reloadData()
            }
        }
        viewModel.initFetch()
    }
}

extension ActivityHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.numberofCells == 0 {
            tableView.emptyMessage(title: "You don't have any data",
                                   message: "Your walking data's will be here",
                                   emptyImage: UIImage(named: "database.png")!)
        } else {
            tableView.restoreTableView()
        }
        return viewModel.numberofCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? ActivityHistoryCell else {
            fatalError("Cell does not exist in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        
        cell.distanceLabel.text = "Distance: \(cellVM.distance.rounded()) m"
        cell.avgSpeedLabel.text = "Avarage Speed: \(cellVM.avgSpeed.rounded())"
        return cell
    }
}
