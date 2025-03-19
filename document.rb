class Document
    def initialize(path)
        @path = path
        @content = ""
    end

    def read_document()
        File.open(@path, "r") do |archive|
            @content = archive.read
            puts @content
        end
    end

    def search(flag)
        case flag
        when "d"
            data_regex = Regexp.new("([0-9]{2})((\/[0-9]{1,2}(\/[0-9]{4})?)|( de (janeiro|fevereiro|março|abril|maio|junho|julho|agosto|setembro|outubro|novembro|dezembro)( de (20)(21|22|23|24|25))?))")
            query = @content.match(data_regex)
            puts query ? "Datas: #{query[0]}" : "Não foi encontrado"
            
        when "h"
            
        when "t"
            
        when "u"
            
        when "e"
            
        when "a"
            
        when "p"
            
        end
    end
end