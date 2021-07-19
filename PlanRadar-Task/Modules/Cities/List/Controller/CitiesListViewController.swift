//
//  CitiesListViewController.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 17/07/2021.
//

import UIKit
import RxCocoa
import RxSwift

protocol CitiesListViewProtocol: NavigationRoute {
    func localize()
    func addNavigationBarButtonItem()
    func addListItem()
    func showAddCityAlertController()
    func showErrorAlertController(with error: Error)
}

class CitiesListViewController: UITableViewController {
    
    // MARK: - Properties
    
    var viewModel: CitiesListViewModelProtocol?
    let disposeBag = DisposeBag()
    var cities: [String] = []
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeOnEvents()
    }
    
    private func subscribeOnEvents() {
        viewModel?.viewDidLoad().subscribe(onNext: { [weak self] in
            self?.localize()
            self?.addNavigationBarButtonItem()
            self?.registerTableViewCell()
            self?.tableView.tableFooterView = UIView()
        }).disposed(by: disposeBag)
        viewModel?.citiesNamesObservable.subscribe(onNext: { [weak self] cities in
            self?.cities = cities
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        viewModel?.errorObservable.subscribe(onNext: { [weak self] error in
            self?.showErrorAlertController(with: error)
        }).disposed(by: disposeBag)
    }
    
    private func registerTableViewCell() {
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: Bundle(for: CitiesListViewController.self)), forCellReuseIdentifier: "CityTableViewCell")
    }
}

// MARK: - extensions

// MARK: - UITableViewDataSpurce Methods

extension CitiesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cell.configure(with: cities[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableView Delegate Methods

extension CitiesListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectCity(at: indexPath.row).subscribe(onNext: { [weak self] router in
            self?.navigate(to: router)
        }).disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        viewModel?.deleteCity(at: indexPath.row)
    }
}

extension CitiesListViewController: CitiesListViewProtocol {
    
    // MARK: - Methods
    
    func localize() {
        title = "Cities List"
    }
    
    func addNavigationBarButtonItem() {
        let addBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addListItem))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    func showAddCityAlertController() {
        let alertController = UIAlertController(title: "Add City", message: "Please add your favorite city", preferredStyle: .alert)
        alertController.addTextField { [weak self] textField in
            guard let self = self else { return }
            
            textField.placeholder = "Enter City Name"
            
            if let citiesListViewModel = self.viewModel {
                textField.rx.text.orEmpty.asDriver().drive(citiesListViewModel.cityName).disposed(by: self.disposeBag)
            }
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            self?.viewModel?.alertAddButtonPressed()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlertController(with error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func addListItem() {
        viewModel?.addButtonPressed().subscribe(onNext: { [weak self] in
            DispatchQueue.main.async {
                self?.showAddCityAlertController()
            }
        }).disposed(by: disposeBag)
    }
}
