class Task
    def initialize(date, hour, tag, action, participant)
        @date = date
        @hour = hour
        @tag = tag
        @action = action
        @participant= participant
    end

    def text()
        return "#{@date}\n#{@hour}\n#{@tag}\n#{@action}\n#{@participant}"
    end

end
