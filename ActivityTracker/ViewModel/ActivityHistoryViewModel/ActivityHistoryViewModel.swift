//
//  ActivityHistoryModel.swift
//  ActivityTracker
//
//  Created by Vijith TV on 28/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import Foundation

class HistoryViewModel {
    
    private var walks: [Activity] = []
    private let activityVm = ActivityViewModel()
    var reloadTableCellClosure: (() -> ())?
    
    private var cellViewModel: [HistoryCellViewModel] = [HistoryCellViewModel]() {
        didSet {
            self.reloadTableCellClosure?()
        }
    }
    
    var numberofCells: Int {
        return cellViewModel.count
    }
    
    func initFetch()  {
        let walkData: [Activity] = activityVm.processWalkData()
        self.getWalkData(walks: walkData)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> HistoryCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    func createCellViewModel(activity: Activity) -> HistoryCellViewModel {
        return HistoryCellViewModel(avgSpeed: activity.averageSpeed,
                                    distance: activity.distance)
    }
    
    private func getWalkData(walks: [Activity]) {
        self.walks = walks
        var vms = [HistoryCellViewModel]()
        for walk in walks {
            vms.append(createCellViewModel(activity: walk))
        }
        self.cellViewModel = vms
    }
    
}
