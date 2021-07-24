//
//  CitiesListViewModelTest.swift
//  PlanRadar-TaskTests
//
//  Created by Fady Ramzy on 24/07/2021.
//

import XCTest
import RxSwift
import RxCocoa
@testable import PlanRadar_Task

class CitiesListViewModelTest: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: CitiesListViewModel!
    var repository: CitiesRepositoryMock!
    var disposeBag: DisposeBag!
    var citiesNames: [String]!
    
    enum WeatherResponseError: Error, LocalizedError {
        case invalidCityName
        case selectedDetailsError
        
        var errorDescription: String? {
            switch self {
            case .invalidCityName:
                return "Invalid City Name"
            case .selectedDetailsError:
                return "No details for the selected city"
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func setUpWithError() throws {
        citiesNames = ["Cairo", "Alexandria"]
        disposeBag = DisposeBag()
        repository = CitiesRepositoryMock()
        viewModel = CitiesListViewModel(repository: repository)
    }

    override func tearDownWithError() throws {
        repository = nil
        citiesNames = nil
        viewModel = nil
        disposeBag = nil
    }
    
    // MARK; - Methods
    
    func test_citiesListViewModel_fetchCityWeatherDetails_withValidCityName_cityNamesObservableShouldReturnOneCity() {
        // Given
        
        repository.weatherResponse = WeatherResponse(weather: [Weather(description: "Cloudy", icon: "icon1")], main: Main(temprature: 20.0, humidity: 10), wind: Wind(speed: 20.0))
        
        // When
        
        viewModel.fetchCityWeatherDetails()
        
        // Then
        
        viewModel.citiesNamesObservable.subscribe(onNext: { cities in
            XCTAssertEqual(cities.count, 1)
        }).disposed(by: disposeBag)
    }
    
    
    func test_citiesListViewModel_fetchCityWeatherDetails_withInValidCityName_errorObservableShouldReturnError() {
        // Given
        
        repository.error = WeatherResponseError.invalidCityName
        
        // When
        
        viewModel.fetchCityWeatherDetails()
        
        // Then
        
        viewModel.errorObservable.subscribe(onNext: { error in
            XCTAssertEqual(error.localizedDescription, WeatherResponseError.invalidCityName.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    
    func test_citiesListViewModel_deleteCity_atInvalidIndex_shouldReturnError() {
        // Given
        
        viewModel.names = ["Cairo"]
        
        // When
        
        viewModel.deleteCity(at: 1)
        
        // Then
        
        viewModel.errorObservable.subscribe(onNext: { error in
            XCTAssertEqual(error.localizedDescription, WeatherResponseError.invalidCityName.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func test_citiesListViewModel_deleteCity_atValidIndex_shouldReturnCityWithoutDeletedCity() {
        // Given
        
        viewModel.names = ["Cairo", "Alexandria"]
        
        // When
        
        viewModel.deleteCity(at: 1)
        
        // Then
        
        viewModel.citiesNamesObservable.subscribe(onNext: { names in
            XCTAssertEqual(self.viewModel.names.count, 1)
        }).disposed(by: disposeBag)
    }
    
    func test_citiesListViewModel_citiesWithoutDeletedCity_atInvalidIndex_shouldReturnError() {
        // Given
        // When
        
        let cities = viewModel.citiesWithoutDeletedCity(at: 1, storedCityNames: citiesNames)
        
        // Then
        
        XCTAssertNil(cities)
    }
    
    func test_citiesListViewModel_citiesWithoutDeletedCity_atValidIndex_shouldDeleteSelectedCity() {
        // Given
        // When
        
       let cities = viewModel.citiesWithoutDeletedCity(at: 1, storedCityNames: citiesNames)
        
        // Then
        
        XCTAssertEqual(cities?.count, 1)
    }
    
    func test_citiesViewModel_addButtonPressed_shouldTriggerPressAction() {
        // Given
        // When
        
        let observable = viewModel.addButtonPressed()
        
        // Then
        
        observable.subscribe { _ in
            XCTAssertTrue(true)
        }.disposed(by: disposeBag)
    }
    
    func test_citiesListViewModel_addAlertButtonPressed_shouldFetchWeatherDetails() {
        // Given
        
        repository.weatherResponse = WeatherResponse(weather: [Weather(description: "Cloudy", icon: "icon1")], main: Main(temprature: 20.0, humidity: 10), wind: Wind(speed: 20.0))
        
        // When
        
        viewModel.alertAddButtonPressed()
        
        // Then
        
        viewModel.citiesNamesObservable.subscribe(onNext: { cityNames in
            XCTAssertEqual(cityNames.count, 1)
        }).disposed(by: disposeBag)
    }
}
