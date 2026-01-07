//
//  String+Extension.swift
//  MovieApp
//
//  Created by Valeh Ismayilov on 07.01.26.
//

import SwiftUI

extension String {
    func dateFormatter(
        from inputFormat: String = "yyyy-MM-dd"
    ) -> String{
        let input = DateFormatter()
        input.dateFormat = inputFormat
        
        let output = DateFormatter()
        output.dateFormat = "MM/yyyy"
        
        return output.string(from: Date())
    }
}
