//
//  CitiesListViewModel.swift
//  PlanRadar-Task
//
//  Created by Fady Ramzy on 16/07/2021.
//

import CoreData
import Foundation
import RxSwift
import RxCocoa

struct CityUIModel {
    // MARK: - Properties
    
    var name: String?
    var description: String?
    var humidity: String?
    var wind: String?
    var temperature: String?
    var imageURL: String?
}

protocol CitiesListViewModelProtocol: ViewLifeCycleProtocol, LoadingIndicatorProtocol {
    
    // MARK: - Properties
    
    var cityName: BehaviorRelay<String> { set get }
    var citiesNamesObservable: Observable<[String]> { get }
    var errorObservable: Observable<Error> { get }
    
    // MARK: - Methods
    
    func addButtonPressed() -> Observable<Void>
    func alertAddButtonPressed()
    func didSelectCity(at index: Int) -> Observable<Router>
    func deleteCity(at index: Int)
}

class CitiesListViewModel {
    
    // MARK: - Properties
    
    private let repository: CitiesRepositoryProtocol
    private let viewcontext: NSManagedObjectContext
    private var cityNameRelay = BehaviorRelay<String>(value: "")
    private let errorPublishSubject = PublishSubject<Error>()
    private let citiesNames = BehaviorSubject<[String]>(value: [])
    var names: [String] = []
    private var cities: [CityUIModel] = []
    private var localCities: [CityWeather] = []
    private let disposeBag = DisposeBag()
    private var cityWeatherLocalList: [CityWeather] = []
    
    enum CitiesListError: Error, LocalizedError {
        case selectedDetailsError
        
        var errorDescription: String? {
            switch self {
            case .selectedDetailsError:
                return "No details for the selected city"
            }
        }
    }
    
    // MARK: - Initializer
    
    init(repository: CitiesRepositoryProtocol, viewcontext: NSManagedObjectContext) {
        self.repository = repository
        self.viewcontext = viewcontext
        subscribeOnEvents()
    }
    
    // MARK: - Methods
    
    func subscribeOnEvents() {
        viewDidLoad()?.subscribe(onNext: { [weak self] in
            self?.fetchLocalData()
        }).disposed(by: disposeBag)
    }
    
    func citiesWithoutDeletedCity(at index: Int, storedCityNames: [String]) -> [String]? {
        var namesList = storedCityNames
        
        let isIndexValid = storedCityNames.indices.contains(index)
        
        guard isIndexValid else { return nil }
        
        namesList.remove(at: index)
        
        return namesList
    }
    
    func fetchLocalData() {
        repository.fetchLocalCitiesWeatherData(with: viewcontext, fetchRequest: CityWeather.fetchRequest()) { [weak self] result, error  in
            guard let self = self else { return }
            
            if let returnedError = error {
                self.errorPublishSubject.onNext(returnedError)
            } else {
                let cities =  result as? [CityWeather]
                cityWeatherLocalList = cities ?? []
                let citiesListUIModel = mapLocalDataToUIModel(with: cities)
                self.cities = citiesListUIModel
                names = citiesListUIModel.map({ $0.name ?? "" })
                citiesNames.onNext(names)
            }
        }
    }
    
    func fetchCityWeatherDetails() {
        showLoadingIndicator()
        repository.fetchCityWeather(with: cityNameRelay.value) { [weak self] response, error in
            guard let self = self else { return }
            
            if let returnedError = error {
                self.errorPublishSubject.onNext(returnedError)
            } else {
                self.names.append(self.cityNameRelay.value)
                self.citiesNames.onNext(self.names)
                let city = CityUIModel(name: self.cityNameRelay.value, description: response?.weather?.first?.description, humidity: "\(response?.main?.humidity ?? 0)", wind: "\(response?.wind?.speed ?? 0)", temperature: "\(response?.main?.temprature ?? 0.0)", imageURL: CitiesRequest.weatherIcon(iconId: response?.weather?.first?.icon ?? "").path)
                self.cities.append(city)
                self.saveDataLocally(with: response)
            }
            self.hideLoadingIndicator()
        }
    }
    
    func mapLocalDataToUIModel(with cityWeatherLocalList: [CityWeather]?) -> [CityUIModel] {
        guard let list = cityWeatherLocalList else { return [] }
        
        return list.map { cityWeather in
            return CityUIModel(name: cityWeather.cityName, description: cityWeather.weatherDescription, humidity: "\(cityWeather.humidity)", wind: "\(cityWeather.windSpeed)", temperature: "\(cityWeather.temprature)", imageURL: cityWeather.icon)
        }
    }
    func saveDataLocally(with weatherResponse: WeatherResponse?) {
        let cityWeather = CityWeather(context: viewcontext)
        cityWeather.cityName = cityNameRelay.value
        cityWeather.weatherDescription = weatherResponse?.weather?.first?.description ?? ""
        cityWeather.temprature = weatherResponse?.main?.temprature ?? 0.0
        cityWeather.windSpeed = weatherResponse?.wind?.speed ?? 0.0
        cityWeather.icon = CitiesRequest.weatherIcon(iconId: weatherResponse?.weather?.first?.icon ?? "").path
        cityWeather.saveDate = Date()
        repository.saveObject(viewContext: viewcontext) { [weak self] isSaved, error in
            guard let self = self else { return }
            if !isSaved, let returned = error {
                self.errorPublishSubject.onNext(returned)
                self.cityWeatherLocalList.append(cityWeather)
            } else {
                
            }
        }
    }
    
    func deleteDataLocally(at index: Int) {
        let isIndexValid = cityWeatherLocalList.indices.contains(index)
        guard isIndexValid else { return }
        
        repository.deleteFromContext(with: cityWeatherLocalList[index], viewContext: viewcontext) { isDeleted, error in
            if !isDeleted, let returnedError = error {
                self.errorPublishSubject.onNext(returnedError)
                self.cityWeatherLocalList.remove(at: index)
            } else {
                
            }
        }
    }
}

// MARK: - extensions

extension CitiesListViewModel: CitiesListViewModelProtocol {
    
    // MARK: - Properties
    
    var errorObservable: Observable<Error> {
        return errorPublishSubject.asObservable()
    }
    
    var cityName: BehaviorRelay<String> {
        set { cityNameRelay.accept(newValue.value) }
        get { return cityNameRelay }
    }
    
    var citiesNamesObservable: Observable<[String]> {
        return citiesNames.asObservable()
    }
    
    // MARK: - Methods
    
    func addButtonPressed() -> Observable<Void> {
        return Observable.create { observer in
            observer.onNext(())
            
            return Disposables.create()
        }
    }
    
    func alertAddButtonPressed() {
        fetchCityWeatherDetails()
    }
    
    func didSelectCity(at index: Int) -> Observable<Router> {
        let isIndexValid = self.cities.indices.contains(index)
        
        return Observable.create { [weak self] observer in
            guard isIndexValid else {
                observer.onError(CitiesListError.selectedDetailsError)
                
                return Disposables.create()
            }
            observer.onNext(CitiesRouter.details(city: (self?.cities[index])!))
            
            return Disposables.create()
        }
    }
    
    func deleteCity(at index: Int) {
        guard let cities = citiesWithoutDeletedCity(at: index, storedCityNames: names) else {
            errorPublishSubject.onNext(CitiesListError.selectedDetailsError)
            
            return
        }
        deleteDataLocally(at: index)
        citiesNames.onNext(cities)
    }
}
