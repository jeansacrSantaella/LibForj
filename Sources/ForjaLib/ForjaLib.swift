//
//  Conexion.swift
//  PeticionServidor
//
//

import Foundation

public struct ForjaLib{
    public init(){}
    
    var url: String="https://qh6ol1kw41.execute-api.us-east-1.amazonaws.com/prod/frontal/"
    var imagen: String =  "no declarada"
    var contador:Int = 0
    var limite:Int = 3
    var selfie:Bool=false
    
    public func getURL() -> String{
        return url;
    }
    public mutating func setURL(nueva:String){
        self.url=nueva
    }
    
    func getImagen()->String{
        return imagen
    }
    
    mutating func setImagen(nuevaImagen:String){
        self.imagen=nuevaImagen
    }
    
    func getContador()->Int{
        return contador
    }
    
    mutating func incrementar(){
        self.contador=contador+1
    }
    func getLimite()->Int{
        return limite
    }
    
    mutating func modificarLimite(nuevoLimite:Int){
        self.limite=nuevoLimite
    }
    
    mutating func tipoSelfie(){
        self.selfie=true
    }
    mutating func tipoOtro(){
        self.selfie=false
    }
    
    func esSelfie()->Bool{
        return selfie
    }
    func crearConexion(){
    let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        let enviar = "data:image/png;base64,"+imagen
        let parameters: [String: Any] = ["img": enviar]
    
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) else {
            return
        }
        request.httpBody = httpBody
    
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                //print("response")
                print(response)
            }
            if let data = data {
                do {
                    let json:String = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! String
                    print("repuesta")
                    print(json)
                } catch {
                    print("Error")
                    print(error)
                }
            }
        }.resume()
    }
    
    func crearConexionSelfie(faceID:String){
    let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        let enviar = "data:image/png;base64,"+imagen
        let parameters: [String: Any];
        if(selfie){
            parameters = ["FACE_ID":faceID,"img": enviar]
        }else{
            parameters = ["img": enviar]
        }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) else {
            return
        }
        request.httpBody = httpBody
    
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                //print("response")
                print(response)
            }
            if let data = data {
                do {
                    let json:String = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! String
                    print("repuesta")
                    print(json)
                } catch {
                    print("Error")
                    print(error)
                }
            }
        }.resume()
    }    
}

