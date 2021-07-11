//
//  PersistingManagerTest.swift
//  HeyoCatsTests
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import XCTest

class PersistingManagerTest: XCTestCase {
    var cats: [Cat]!
    
    let item1 = Cat(id: "1", image: nil, name: nil)
    let item2 = Cat(id: "2", image: nil, name: nil)


    override func setUpWithError() throws {
        cats = CatsPersistenceManager.shared.load()
    }

    override func tearDownWithError() throws {
        cats = []
        CatsPersistenceManager.shared.clear()
    }
    func test_movies_empty() throws {
        XCTAssertEqual(cats, [])
    }
    
    func test_count1() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        XCTAssertEqual(CatsPersistenceManager.shared.load().count, 1)
    }
    
    func test_count2() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        XCTAssertEqual(CatsPersistenceManager.shared.load().count, 2)
    }
    
    func test_count_same_item() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item1)
        XCTAssertEqual(CatsPersistenceManager.shared.load().count, 1)
    }
    
    func test_remove_count1() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.remove(cat: item1)
        XCTAssertEqual(CatsPersistenceManager.shared.load().count, 1)
    }
    
    func test_remove_count2() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.remove(cat: item1)
        CatsPersistenceManager.shared.remove(cat: item2)
        XCTAssertEqual(CatsPersistenceManager.shared.load().count, 0)
    }
    
    func test_find_item1() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        XCTAssertTrue(CatsPersistenceManager.shared.load().contains(where: {$0 == item1}))
    }
    
    func test_find_item2() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        XCTAssertTrue(CatsPersistenceManager.shared.load().contains(where: {$0 == item2}))
    }
    
    func test_confirm_remove_item1() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.remove(cat: item1)
        XCTAssertFalse(CatsPersistenceManager.shared.load().contains(where: {$0 == item1}))
    }
    
    func test_confirm_remove_item2() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.remove(cat: item2)
        XCTAssertFalse(CatsPersistenceManager.shared.load().contains(where: {$0 == item2}))
    }
    
    func test_confirm_remove_both() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.remove(cat: item2)
        CatsPersistenceManager.shared.remove(cat: item1)
        XCTAssertFalse(CatsPersistenceManager.shared.load().contains(where: {$0 == item2}))
        XCTAssertFalse(CatsPersistenceManager.shared.load().contains(where: {$0 == item1}))
    }
    
    func test_insertDuplicate() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.save(cat: item2)
        XCTAssertEqual(CatsPersistenceManager.shared.load().count, 2)
    }
    
    func test_clear() throws {
        CatsPersistenceManager.shared.save(cat: item1)
        CatsPersistenceManager.shared.save(cat: item2)
        CatsPersistenceManager.shared.clear()
        XCTAssertFalse(CatsPersistenceManager.shared.load().contains(where: {$0 == item2}))
        XCTAssertFalse(CatsPersistenceManager.shared.load().contains(where: {$0 == item1}))
        XCTAssertEqual(CatsPersistenceManager.shared.load(), [])
    }
}
