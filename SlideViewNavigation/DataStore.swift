//
//  DataStore.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 04/09/17.
//  Copyright © 2017 anoop. All rights reserved.
//

import Foundation

class DataStore {

    fileprivate var menuItems = [MenuItem]()

    private init() {
        fetchMenuItemsFromJSON()
    }

    private static let sharedDataStore = DataStore()

    class func sharedStore() -> DataStore {

        return sharedDataStore
    }

    // MARK: Get menu items

    private func fetchMenuItemsFromJSON() {

        if let pathURL = Bundle.main.url(forResource: "MenuItem", withExtension: "json") {

            do {

                let jsonData = try Data(contentsOf: pathURL, options: .mappedIfSafe)

                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String: Any]
                if let items = jsonResult["MenuItems"] as? [Any] {

                    for item in items {
                        if let menuItem = MenuItem(with: item as! [String: Any]) {
                            menuItems.append(menuItem)
                        }
                    }
                }

            } catch(let error) {
                print (error.localizedDescription)
            }
        }
    }
}

extension DataStore: DataStoreProtocol {

    func sectionCount() -> Int {
        return 1
    }
    func rowsCountIn(section: Int) -> Int {

        var rowCount = 0

        if !menuItems.isEmpty {
            rowCount = menuItems.count
        }
        return rowCount
    }
    func itemAt(row: Int) -> MenuItem? {

        return menuItems[row]
    }
}
