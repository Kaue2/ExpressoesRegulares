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
        File.write(OUTPUT, "")
    end

    #regex constants
    OUTPUT = "output.txt"
    REGEX_DATE = '(?<day>[0-9]{2})((?<slash>\/[0-9]{1,2}(\/[0-9]{4})?)|( de (?<month>janeiro|fevereiro|março|abril|maio|junho|julho|agosto|setembro|outubro|novembro|dezembro)( de (?<year>20(21|22|23|24|25)))?))'
    REGEX_HOUR = '(([0-9]{1,2})(:|\ )(([0-9]{2})|(horas|hora)))|(às\ )([0-9]{2})'
    REGEX_TAGS = '(?<![\/\w])#[\p{L}\d_]+'
    REGEX_URL = '(https?|ftp)://(www\.)?[a-z0-9\-]+(\.[a-z]{2,})+(/[^\s]*)?(\?[^\s]*)?(\#[^\s]*)?'
    REGEX_EMAIL = '\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}\b'
    REGEX_ACTION = '\b[a-zA-Z]+(ar|er|ir)\b'
    REGEX_PERSON = '\b(([aAoO])|(com))( [a-zA-Z]+)\b'
    
    # kaue
    # params flag, char
    # a função a seguir deve receber uma flag para fazer a busca corretamente
    # sera retornado um arrau com as strings correspondes a flag
    # retorno array de string
    def search(flag)
        case flag
        when "d"
            data_regex = Regexp.new(REGEX_DATE, Regexp::IGNORECASE)
            dates = []
            groups = []
            warning = ""
            File.open(@path, "r") do |archive| # abrindo o arquivo novamente
                archive.each_line.with_index do |line, index| # para cada linha do arquivo
                    line.scan(data_regex) do |match| # para cada item que foi correspondido
                        groups = Regexp.last_match.named_captures
                        date = Regexp.last_match[0] # pego o item inteiro e o armazeno no array
                        valid = validate_dates(date, groups)
                        if valid 
                            dates << date
                        else
                            warning += "Na linha #{index + 1}, a data #{date} está incorreta\n"
                        end
                    end
                end
            end
            if warning != ""
                File.write(OUTPUT, "Avisos\n" + warning + "\n")
            end
            File.write(OUTPUT, "Output\n", mode: "a")
            File.write(OUTPUT, dates, mode: "a")
        when "h"
            hour_regex = Regexp.new(REGEX_HOUR, Regexp::IGNORECASE)
            hours = []
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line|
                    line.scan(hour_regex) do |match|
                        hour = Regexp.last_match[0]
                        hours << hour
                    end
                end
            end
            File.write(OUTPUT, hours, mode: "a")
        when "t"
            tags_regex = Regexp.new(REGEX_TAGS)
            tags = []
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line|
                    line.scan(tags_regex) do |match|
                        tag = Regexp.last_match[0]
                        tags << tag
                    end
                end
            end
            File.write(OUTPUT, tags)
        when "u"
            url_regex = Regexp.new(REGEX_URL)
            urls = []
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line|
                    line.scan(url_regex) do |match|
                        url = Regexp.last_match[0]
                        urls << url
                    end
                end
            end
            File.write(OUTPUT, urls)
        when "e"
            email_regex = Regexp.new(REGEX_EMAIL)
            emails = []
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line|
                    line.scan(email_regex) do |match|
                        email = Regexp.last_match[0]
                        emails << email
                    end
                end
            end
            File.write(OUTPUT, emails)
        when "a"
            action_regex = Regexp.new(REGEX_ACTION)
            actions = []
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line|
                    line.scan(action_regex) do |match|
                        action = Regexp.last_match[0]
                        actions << action
                    end
                end
            end
            File.write(OUTPUT, actions)
        when "p"
            person_regex = Regexp.new(REGEX_PERSON)
            people = []
            File.open(@path, "r") do |archive|
                archive.each_line.with_index do |line|
                    line.scan(person_regex) do |match|
                        person = Regexp.last_match[0]
                        people << person
                    end
                end
            end
            File.write(OUTPUT, people)
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