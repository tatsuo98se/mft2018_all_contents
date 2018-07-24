# ignore sigabort
loop do
    begin
        sleep
    rescue SignalException
        next
    end
end
