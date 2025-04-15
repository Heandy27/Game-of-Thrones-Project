import Foundation

protocol CharacterNetworkProtocol {
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void)
}

final class CharacterNetwork: CharacterNetworkProtocol {
    
    private var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    static let shared: CharacterNetwork = CharacterNetwork()
    
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void) {
        let urlString = "\(ConstantsApp.CONS_API_URL)\(Endpoints.characters.rawValue)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error {
                return completion(.failure(ErrorApp.errorFromServer(error: error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == HttpResponseCode.SUCCESS else {
                return completion(.failure(ErrorApp.errorFromApi(statuscode: (response as? HTTPURLResponse)?.statusCode ?? 0)))
            }
            
            guard let data = data else {
                return completion(.failure(.noDataReceived))
            }
            
            do {
                let results = try JSONDecoder().decode([GOTResponse].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(ErrorApp.errorParsingData))
            }
        }
        task.resume()
        
    }
    
    
}
