import Foundation

enum ErrorApp: Error, CustomStringConvertible, Equatable, LocalizedError {
    
    
    case requestWasNil
    case errorFromServer(error: Error)
    case errorFromApi(statuscode: Int)
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
    
    
    static func == (lhs: ErrorApp, rhs: ErrorApp) -> Bool {
        switch (lhs, rhs) {
        case (.requestWasNil, .requestWasNil),
            (.noDataReceived, .noDataReceived),
            (.errorParsingData, .errorParsingData),
            (.badUrl, .badUrl):
            return true
        case (.errorFromApi(let lhsStatus), .errorFromApi(let rhsStatus)):
            return lhsStatus == rhsStatus
        case (.characterNotFound(let lhsID), .characterNotFound(let rhsID)):
            return lhsID == rhsID
        case (.errorFromServer, .errorFromServer):
            // Podrías hacer una comparación más profunda si sabes que error será del tipo NSError
            return true // o false, según tu lógica
        default:
            return false
        }
    }
}
