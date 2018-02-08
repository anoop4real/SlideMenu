//
//  ProtocolsAndExtensions.swift
//  SlideViewNavigation
//
//  Created by anoop mohanan on 06/02/18.
//  Copyright © 2018 anoop. All rights reserved.
//

import Foundation
import UIKit

//From :https://gist.github.com/gonzalezreal/92507b53d2b1e267d49a
protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UITableViewCell: ReusableView {
}

// MARK: - Segue Handler protocol
// https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/
protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self:UIViewController, SegueIdentifier.RawValue == String {
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier,
                                    sender: AnyObject?) {

        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }

    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {

        // still have to use guard stuff here, but at least you're
        // extracting it this time
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(String(describing: segue.identifier)).") }

        return segueIdentifier
    }
}

extension String {

    func asURLRequest() -> URLRequest? {
        var urlRequest: URLRequest?
        if self.isValidForUrl() {
            if let url = URL(string: self) {
                urlRequest = URLRequest(url: url)
            }
        } else {
            urlRequest = nil
        }
        return urlRequest
    }
    func isValidForUrl() -> Bool {

        if(self.hasPrefix("http") || self.hasPrefix("https")) {
            return true
        }
        return false
    }
    var withEscapedNewlines: String { return self.replacingOccurrences(of: "\n", with: " ") }
}
