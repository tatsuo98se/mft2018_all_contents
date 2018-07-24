require "timeout"

def run_processes(processes)
    pids = processes.map do |process|
        spawn(process[:spawn], chdir:process[:chdir])
    end

    if pids.length == 0 then
        puts("[WARN] there are no process configured to run.")
        return
    else
        puts("[INFO] run process ids: #{pids}")
    end

    begin
        sleep
    rescue SignalException
        pids.each do |pid|
            begin
                Timeout.timeout(3) do
                    puts "[INFO] aborting PID:#{pid}. waiting..."
                    Process.kill("INT", pid)
                    Process.wait pid
                    puts "[INFO] PID:#{pid} has aborted successfully."
                end
            rescue Timeout::Error
                puts "[ERR] PID:#{pid} has not aborted. the process will be killed forcibly."
                Process.kill(:KILL, pid)
            end
        end
    end
end