import Foundation

final class HomeViewModel: ObservableObject {
    @Published var characters: [GOTResponse] = []
    @Published var searchText: String = ""
    @Published var filteredCharacters: [GOTResponse] = []
    
    var useCase: CharacterUseCaseProtocol
    
    init( useCase: CharacterUseCaseProtocol = CharacterUseCase()) {
        self.useCase = useCase
        setupBindings()
        loadCharacters()
    }
    
    func loadCharacters() {
        useCase.getCharacters { [weak self] result in
            switch result {
                
            case .success(let characters):
                DispatchQueue.main.async {
                    self?.characters = characters
                }    
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupBindings() {
            // Filtrar personajes según el texto
            $searchText
                .removeDuplicates()
        // Espera 300 milisegundos después de que el usuario deja de escribir para hacer el filtrado.
                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        // Combina dos publishers: searchText y characters.
                .combineLatest($characters)
                .map { (searchText, characters) in
                    guard !searchText.isEmpty else { return characters }
                    return characters.filter { $0.firstName.lowercased().contains(searchText.lowercased()) }
                }
                .assign(to: &$filteredCharacters)
        }

    
}
