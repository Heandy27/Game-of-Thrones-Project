import Foundation

protocol CharacterRepositoryProtocol {
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void)
}
