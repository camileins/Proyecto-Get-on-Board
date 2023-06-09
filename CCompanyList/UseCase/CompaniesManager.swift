import Foundation
import UIKit
//Cambie el nonbre del protocolo para companias
protocol dataCompanyManagerDelegate{
    func showCompaniesData(list: [Category])
    func foundOfferCompany(oferta: [Category])
}

struct companiesManager{
    var delegador: dataCompanyManagerDelegate?
    
    func seeCompany(){
        
        let urlString = "https://www.getonbrd.com/api/v0/companies"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { datos, respuesta, error in
                if error != nil{
                    
                    print("Error al obtener datos de la api", error?.localizedDescription)
                    
                }
                if let datos =  datos{
                    var listaCompanias = parseJSON(listCompany: datos)
                    delegador?.showCompaniesData(list: listaCompanias ?? [])
                    
                }
                
            }
            tarea.resume()
            
        }
    }
        func parseJSON(listCompany: Data) ->[Category]?{
            let decodificador = JSONDecoder()
            do{
                let datosDecodificados = try decodificador.decode(CategoriesResponse.self, from: listCompany)
                return datosDecodificados.data
                
            }catch{
                print("Error al decodificar los datos", error.localizedDescription)
                return nil
            }
        }
        
        
    
    func seeOffersCompany(type: String){
            let urlString = "https://www.getonbrd.com/api/v0/companies/\(type)/jobs?per_page=1&page=1&expand=[%22company%22]"
            
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                
                let tarea = session.dataTask(with: url) { datos, respuesta, error in
                    if error != nil{
                        
                        print("Error al obtener datos de la api", error?.localizedDescription)
                        
                    }
                    if let datos =  datos{
                        var listaCompanias = parseJSON(listCompany: datos)
                        delegador?.foundOfferCompany(oferta: listaCompanias ?? [])
                        
                    }
                    
                }
                tarea.resume()
                
            }
        }
    }

         









//
//extension Data{
//                    func parseData(arreglarString palabra: String) -> Data? {
//                        let dataString = String(data: self, encoding: .utf8)
////                        let parseDataString = dataString?.replacingOccurrences(of: palabra, with: "")
////                        guard let data = parseDataString?.data(using: .utf8) else {return nil}
////                        let parseDataString = dataString?.replacingOccurrences(of: palabra, with: "")
//                        guard let data = dataString?.data(using: .utf8) else {return nil}
//                        return data
//
//
//                    }}
