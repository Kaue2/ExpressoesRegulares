class Document
    # kaue
    # inicializa o objeto documento
    def initialize(path)
        @path = path
        @content = ""
    end
    # kaue
    # le o documento e joga o conteudo para a variável da classe
    def read_document()
        File.open(@path, "r") do |archive|
            @content = archive.read
        end
    end
    # kaue
    # params flag, char
    # a função a seguir deve receber uma flag para fazer a busca corretamente
    # sera retornado um arrau com as strings correspondes a flag
    # retorno array de string
    def search(flag)
        case flag
        when "d"
            data_regex = Regexp.new("(?<dia>[0-9]{2})((?<barra>\/[0-9]{1,2}(\/[0-9]{4})?)|( de (?<mes>janeiro|fevereiro|março|abril|maio|junho|julho|agosto|setembro|outubro|novembro|dezembro)( de (?<ano>20(21|22|23|24|25)))?))", Regexp::IGNORECASE)
            dates = []
            grupos = []
            File.open(@path, "r") do |archive| # abrindo o arquivo novamente
                archive.each_line.with_index do |line| # para cada linha do arquivo
                    line.scan(data_regex) do |match| # para cada item que foi correspondido
                        grupos = Regexp.last_match.named_captures
                        dates << Regexp.last_match[0] # pego o item inteiro e o armazeno no array
                        puts Regexp.last_match[1]
                        puts grupos
                    end
                end
            end
            # implementar a verificação de datas aqui
            # caso uma data seja reconhecida porém seja inválida devemos informar isso ao usuário
            # caso não ocorra nenhum erro de validação prosseguimos
            puts "#{dates}"
        when "h"
            
        when "t"
            
        when "u"
            
        when "e"
            
        when "a"
            
        when "p"
            
        end
    end
end