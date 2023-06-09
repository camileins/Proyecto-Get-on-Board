//Desde ProjectManager consumo la API

import Foundation
import UIKit

protocol dataManagerDelegate{
    func showCategoriesData(list: [Category])
    func foundOffer(ofertas: [Category])
}

struct categoriesManager{
    var delegador: dataManagerDelegate?
    
    func seeCategory(){
        
        let urlString = "https://www.getonbrd.com/api/v0/categories/"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { datos, respuesta, error in
                if error != nil{
                    
                    print("Error al obtener datos de la api", error?.localizedDescription)
                }
                if let datos =  datos{
                    var listaCategorias = parseJSON(listCompany: datos)
                    delegador?.showCategoriesData(list: listaCategorias ?? [])
                    
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
        
        
        
        
        
        
        func seeOffers(type: String){
            
            let urlString = "https://www.getonbrd.com/api/v0/categories/\(type)/jobs?per_page=1&page=1"
            
            if let url = URL(string: urlString){
                let session = URLSession(configuration: .default)
                
                let tarea = session.dataTask(with: url) { datos, respuesta, error in
                    if error != nil{
                        
                        print("Error al obtener datos de la api", error?.localizedDescription)
                        
                    }
                    if let datos =  datos{
                        var listaCategorias = parseJSON(listCompany: datos)
                        delegador?.foundOffer(ofertas: listaCategorias ?? [])
                        
                    }
                    
                }
                tarea.resume()
                
            }
        }
    }

         


