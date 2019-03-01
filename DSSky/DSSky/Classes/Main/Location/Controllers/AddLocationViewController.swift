//
//  AddLocationViewController.swift
//  DSSky
//
//  Created by 左得胜 on 2019/3/1.
//  Copyright © 2019 左得胜. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate: class {
    func controller(_ controller: AddLocationViewController, didAddWith location: LocationModel)
}

class AddLocationViewController: UITableViewController {
    // MARK: - Property
    // MARK: Public
    weak var delegate: AddLocationViewControllerDelegate?
    var viewModel: AddLocationViewModel!
    
    // MARK: Private
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchBar.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(LocationTableViewCell.self, for: indexPath)
        
        if let vm = viewModel.locationViewModel(at: indexPath.row) {
            cell.showData(vm)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let location = viewModel.location(at: indexPath.row) else { return }
        delegate?.controller(self, didAddWith: location)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Action
    
}

// MARK: - Private Method
private extension AddLocationViewController {
    func setupUI() {
        self.title = "添加城市"
        
        viewModel = AddLocationViewModel()
        viewModel.locationsDidChange = { [unowned self] locations in
            self.tableView.reloadData()
        }
        viewModel.queryingStatusDidChange = { [unowned self] isQuery in
            if isQuery {
                self.title = "搜索中……"
            } else {
                self.title = "添加城市"
            }
        }
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.queryText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.queryText = searchBar.text ?? ""
    }
}
