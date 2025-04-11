import Foundation

enum ErrorApp: Error, CustomStringConvertible {
    
    case requestWasNil
    case errorFromServer(error: Error)
    case errorFromApi(statuscode: String)
    case noDataReceived
    case errorParsingData
    case badUrl
    case characterNotFound(idCharacter: Int)
    
    
    var description: String {
        
        switch self {
            
        case .requestWasNil:
            return "Error creating request"
        case .errorFromServer(error: let error):
            return "Received error from server \((error as NSError).code)"
        case .errorFromApi(statuscode: let statuscode):
            return "Received error from api status code \(statuscode)"
        case .noDataReceived:
            return "Data no received from server"
        case .errorParsingData:
            return "There was an error parsing data"
        case .badUrl:
            return "Bad url"
        case .characterNotFound(idCharacter: let idCharacter):
            return "Character with id \(idCharacter) not found"
        }
        
    }
}
