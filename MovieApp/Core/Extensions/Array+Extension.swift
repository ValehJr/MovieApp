//
//  Array+Extension.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//


extension Array where Element: Identifiable {
    func uniqued() -> [Element] {
        var seen = Set<Element.ID>()
        return filter { seen.insert($0.id).inserted }
    }
}
