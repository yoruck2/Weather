//
//  MeasurementFormatter+.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import Foundation

extension MeasurementFormatter {
    
    enum RoundDigit: Int {
        case first = 0
        case second = 1
    }
    
    // TODO: 이게 날 지 Double에 하는게 날지..
    
    static func kelvinToCelsius(_ kelvinValue: Double,_ roundDigit: RoundDigit) -> String {
        let kelvin = Measurement(value: kelvinValue, unit: UnitTemperature.kelvin)
        let celsius = kelvin.converted(to: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .temperatureWithoutUnit
        formatter.numberFormatter.maximumFractionDigits = roundDigit.rawValue
        let convertedResult = formatter.string(from: celsius)
        return convertedResult
    }
}
