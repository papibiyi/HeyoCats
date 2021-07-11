//
//  AllCatsViewModelTest.swift
//  HeyoCatsTests
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import XCTest

class MockWebService: CatsWebService {
    func getCatBreeds(completion: @escaping (Result<[Cat], Error>) -> Void) {
        let cats = [Cat(id: "1", image: nil, name: nil), Cat(id: "2", image: nil, name: nil)]
        completion(.success(cats))
    }
    
    
}

class MockAllCatsViewModel: AllCatsViewModelActions {
    var webService: CatsWebService
    
    var cats: [Cat] = []
    
    init(webService: CatsWebService) {
        self.webService = webService
        getCats()
    }
    
    func getCats() {
        webService.getCatBreeds { response in
            switch response {
            case .success(let cats):
                self.cats = cats
            case .failure:
                break
            }
        }
    }
}

class AllCatsViewModelTest: XCTestCase {
    
    var viewModel: MockAllCatsViewModel!

    override func setUpWithError() throws {
        viewModel = MockAllCatsViewModel(webService: MockWebService())
    }

    override func tearDownWithError() throws {
        CatsPersistenceManager.shared.clear()
    }

    func test_isFavouriteFalse() throws {
        XCTAssertEqual(viewModel.isFavotite(row: 0), false)
        XCTAssertEqual(viewModel.isFavotite(row: 1), false)
    }
    
    func testSave() {
        XCTAssertEqual(viewModel.saveCat(row: 0), true)
    }
}
