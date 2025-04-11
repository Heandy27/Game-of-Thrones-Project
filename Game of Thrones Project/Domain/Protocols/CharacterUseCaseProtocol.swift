import Foundation

protocol CharacterUseCaseProtocol {
    var repo: CharacterRepositoryProtocol { get set }
    func getCharacters(completion: @escaping (Result<[GOTResponse], ErrorApp>) -> Void)
}
