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
    var faceID:String=""

    
    public func getURL() -> String{
        return url;
    }
    public mutating func setURL(nueva:String){
        self.url=nueva
    }
    
    public func getImagen()->String{
        return imagen
    }
    
    public mutating func setImagen(nuevaImagen:String){
        self.imagen=nuevaImagen
    }
    
    public func getContador()->Int{
        return contador
    }
    
    public mutating func incrementar(){
        self.contador=contador+1
    }
    
    public func getLimite()->Int{
        return limite
    }
    
    public mutating func modificarLimite(nuevoLimite:Int){
        self.limite=nuevoLimite
    }
    
    public mutating func tipoSelfie(){
        self.selfie=true
    }
    
    public mutating func tipoOtro(){
        self.selfie=false
    }
    
    public func esSelfie()->Bool{
        return selfie
    }
    
    public mutating func setFaceId(nuevoFaceid:String){
        self.faceID=nuevoFaceid
    }
    
    public func getFaceId()->String{
        return faceID
    }
    
    
    public func crearConexion(completion: @escaping ((String) -> Void)){
        let Url = String(format: url)
        let serviceUrl = URL(string: Url)!
        let enviar = "data:image/png;base64,"+imagen
        let parameters: [String: Any];
        if(selfie){
            parameters = ["FACE_ID":faceID,"img": enviar]
        }else{
            parameters = ["img": enviar]
        }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        request.httpBody = httpBody
    
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
          // this is where the completion handler code goes
          if let response = response {
            print(response)
          }
            if let data = data {
                do {
                    let json:String = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! String
                    print("repuesta")
                    print(json)
                    completion(json)
                } catch {
                    print("Error")
                    print(error)
                }
            }
        }.resume()
    }

}

