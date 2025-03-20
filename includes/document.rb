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
            data_regex = Regexp.new("(?<day>[0-9]{2})((?<slash>\/[0-9]{1,2}(\/[0-9]{4})?)|( de (?<month>janeiro|fevereiro|março|abril|maio|junho|julho|agosto|setembro|outubro|novembro|dezembro)( de (?<year>20(21|22|23|24|25)))?))", Regexp::IGNORECASE)
            dates = []
            groups = []
            File.open(@path, "r") do |archive| # abrindo o arquivo novamente
                archive.each_line.with_index do |line, index| # para cada linha do arquivo
                    line.scan(data_regex) do |match| # para cada item que foi correspondido
                        groups = Regexp.last_match.named_captures
                        date = Regexp.last_match[0] # pego o item inteiro e o armazeno no array
                        valid = validate_dates(date, groups)
                        if valid 
                            dates << date
                            puts "Era válido #{date}"
                        else
                            puts "Na linha #{index + 1}, a data #{date} está incorreta"
                        end
                        return dates
                    end
                end
            end
            # implementar a verificação de datas aqui
            # caso uma data seja reconhecida porém seja inválida devemos informar isso ao usuário
            # caso não ocorra nenhum erro de validação prosseguimos
            puts "#{dates}"
        when "h"
            hour_regex = Regexp.new("(às)?\ ?(?<hour>[0-9]{1,2}):?\ ?(?<minutes>[0-9]{2})?\ ?((hora)(s)?)?", Regexp::IGNORECASE)
            hours = []
            groups = []
            groups
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line, index|
                    line.scan(hour_regex) do |match|
                        hour = Regexp.last_match[0]
                        groups = Regexp.last_match.named_captures
                        hours << hour
                    end
                end
            end
            puts "#{hours}"
        when "t"
            
        when "u"
            
        when "e"
            
        when "a"
            
        when "p"
            
        end
    end

    # kaue
    # params: recebe a data a ser validada e o grupo do regex a qual ela pertence
    # função para validação dos dias, meses e anos
    # return: verdadeiro caso sejá uma data válida, falso caso seja inválida
    def validate_dates(date, groups)
        day = ''
        month = ''
        year = ''

        if groups['slash']
            sub_string = date.split('/')
            puts "#{sub_string}"

            if sub_string.size != 2 && sub_string.size != 3
                return false
            end

            day = sub_string[0]
            month = sub_string[1]
            year = sub_string[2] if sub_string.size == 3

            unless (1..12).cover?(month.to_i)
                return false
            end

        elsif groups['month']
            months = ["janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]
            sub_string = date.split(' ')
            puts "#{sub_string}"

            day = sub_string[0]
            month = sub_string[2]

            if sub_string.size == 5
                year = sub_string[4]
            end

            if !months.include?(month.downcase)
                return false 
            end
        end

        unless (1..31).cover?(day.to_i)
            return false
        end
        if  year && !year.empty?
            year = year.to_i
            unless (1900..2100).cover?(year)
                return false
            end
        end

        true
    end
end