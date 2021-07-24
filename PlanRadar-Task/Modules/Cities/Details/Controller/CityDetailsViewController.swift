//
//  CityDetailsViewController.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

protocol CityDeatilsViewProtocol {
    var viewModel: CityDetailsViewModelProtocol? { set get}
    
    func addCloseBarButton()
}


class CityDetailsViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var weatherIconImageView: UIImageView!
    @IBOutlet private weak var descriptionTitleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var temperatureTitleLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityTitleLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windSpeedTitleLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: CityDetailsViewModelProtocol?
    let disposeBag = DisposeBag()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.viewDidLoad()?.subscribe(onNext: { [weak self] in
            self?.subscribeOnEvents()
            self?.addCloseBarButton()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    @objc
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCloseBarButton() {
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func subscribeOnEvents() {
        viewModel?.cityObservable.subscribe(onNext: { [weak self] city in
            guard let self = self else { return }
            
            self.title = city.name
            self.weatherIconImageView.kf.setImage(with: URL(string: city.imageURL ?? ""))
            self.temperatureLabel.text = city.temperature
            self.descriptionLabel.text = city.description
            self.humidityLabel.text = city.humidity
            self.windSpeedLabel.text = city.wind
        }).disposed(by: disposeBag)
    }
}
