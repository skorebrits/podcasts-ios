//
//  Presenter.swift
//  podcasts-ios
//
//  Created by Sander Korebrits on 01/03/2026.
//

protocol Presenter {
    associatedtype Data
    associatedtype Presented: ViewData

    static func present(_ data: Data) -> Presented
}
