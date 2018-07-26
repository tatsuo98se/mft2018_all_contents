require "timeout"
require "os"


def run_processes_win(processes)
    processes.each do |process|
        Dir.chdir process[:chdir] do
            system('start cmd /k ' + process[:spawn])
        end
    end
end

def run_processes_other(processes)
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
            rescue
                puts "[ERR] PID:#{pid} has not aborted. the process will be killed forcibly."
                Process.kill(:KILL, pid)
            end
        end
    end
end

def run_processes(processes)
    if OS.windows? then
        run_processes_win(processes)
    else
        run_processes_other(processes)
    end
end