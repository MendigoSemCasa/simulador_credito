
import Foundation

struct SimulacaoResponse: Codable {
    let codigoProduto: Int
    let descricaoProduto: String
    let taxaJuros: Double
    let resultadoSimulacao: [ResultadoSimulacao]
}

struct ResultadoSimulacao: Codable {
    let tipo: String
    let parcelas: [ParcelaModel]
}


func calcularParcela(valor: Double, prazo: Int, closure: @escaping (ParcelaModel) -> Void) {
    let url = URL(string: "https://apphackaixades.azurewebsites.net/api/Simulacao")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("text/plain", forHTTPHeaderField: "accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let requestBody = [
        "valorDesejado": valor,
        "prazo": prazo
    ] as [String : Any]
    
    do {
        let requestBodyData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        request.httpBody = requestBodyData
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            defer { semaphore.signal() }
            
            if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Dados inválidos")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SimulacaoResponse.self, from: data)
                
                // Aqui você pode acessar os valores individualmente
                let codigoProduto = response.codigoProduto
                let descricaoProduto = response.descricaoProduto
                let taxaJuros = response.taxaJuros
                
                guard let resultado = response.resultadoSimulacao.first else {
                    return
                }
                    let tipo = resultado.tipo
                    
                    
                        
                        // Aqui você pode fazer o que desejar com os valores individualizados
                        print("Tipo: \(tipo)")
                    guard let parcela = resultado.parcelas.first else {
                        return
                    }
                    print("Número: \(parcela.numero)")
                    print("Valor Amortização: \(parcela.valorAmortizacao)")
                    print("Valor Juros: \(parcela.valorJuros)")
                    print("Valor Prestação: \(parcela.valorPrestacao)")
                closure(parcela)
                    
                
                
            } catch {
                print("Erro ao decodificar o JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
        semaphore.wait()
        
    } catch {
        print("Erro ao serializar os dados da requisição: \(error.localizedDescription)")
    }
}
