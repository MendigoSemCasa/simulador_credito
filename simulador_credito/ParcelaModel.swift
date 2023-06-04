//
//  ParcelaModel.swift
//  simulador_credito
//
//  Created by Vinicius Cabral on 04/06/23.
//

import Foundation


struct ParcelaModel : Codable {
    let numero: Int
    let valorAmortizacao: Double
    let valorJuros: Double
    let valorPrestacao: Double
}
