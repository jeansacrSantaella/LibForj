//
//  Conexion.swift
//  PeticionServidor
//
//

import Foundation

public class ForjaLib{
    public init(){}
    
    var url: String="https://wp8mrbv9qd.execute-api.us-east-1.amazonaws.com/prod/frontal/"
    var imagen: String =  "no declarada"
    var contador:Int = 0
    var limite:Int = 3
    var selfie:Bool=false
    var faceID:String=""

    
    public func getURL() -> String{
        return url;
    }
    public func setURL(nueva:String){
        self.url=nueva
    }
    
    public func getImagen()->String{
        return imagen
    }
    
    public func setImagen(nuevaImagen:String){
        self.imagen=nuevaImagen
    }
    
    public func getContador()->Int{
        return contador
    }
    
    public func incrementar(){
        self.contador=contador+1
    }
    
    public func getLimite()->Int{
        return limite
    }
    
    public func modificarLimite(nuevoLimite:Int){
        self.limite=nuevoLimite
    }
    
    public func tipoSelfie(){
        self.selfie=true
    }
    
    public func tipoOtro(){
        self.selfie=false
    }
    
    public func esSelfie()->Bool{
        return selfie
    }
    
    public func setFaceId(nuevoFaceid:String){
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
    
        request.timeoutInterval = 200000
        //request.timeoutInterval = 200
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
          // this is where the completion handler code goes
          if let response = response {
            print(response)
          }
            if let httpStatus = response as? HTTPURLResponse, (httpStatus.statusCode != 200 && httpStatus.statusCode != 220)  {           // check for http errors
                    print("codigo de servidor \(httpStatus.statusCode)")
                completion("codigo de servidor \(httpStatus.statusCode)")
            }
            else if let data = data {
                print(data)
                do {
                    let json:String = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! String
                    print("repuesta")
                    print(json)
                    self.respuesta=json
                    completion(json)
                } catch let error as NSError {
                    print("Error")
                    print(error)
                    self.respuesta="Error"
                    completion(error as! String)
                }
            }else{
                print("No hay respuesta")
                self.respuesta="Time out"
                completion("Time out")
            }
        }.resume()
    }

}

