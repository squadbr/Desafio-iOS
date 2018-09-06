//
//  DataSource.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Foundation
import UIKit

protocol BindableView {
    associatedtype Model
    func bind(_ model: Model)
}

class SingleSectionDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    weak var tableView: UITableView?
    
    static var cellReuseIdentifier: String {
        return "cell"
    }
    private(set) var models: [Model]
    private let bindCell: (Cell, Model) -> Void
    
    init(tableView: UITableView,
         models: [Model] = [],
         bindCell: @escaping (Cell, Model) -> Void) {
        self.tableView = tableView
        self.models = models
        self.tableView = tableView
        self.bindCell = bindCell
        super.init()
        registerCells(in: tableView)
    }

    func update(_ models: [Model]) {
        self.models = models
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    private func registerCells(in tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: SingleSectionDataSource.cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SingleSectionDataSource.cellReuseIdentifier,
                                      for: indexPath) as! Cell
        bindCell(cell, models[indexPath.row])
        return cell
    }
}
