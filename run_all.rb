require "timeout"

begin
processes = [
    {
        chdir: './3d_led_cube2',
        spawn: "python main_hw_controller_module.py",
        enable:true
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_hw_controller_module_dummy.py",
        enable:false
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_hw_controller_module.py",
        enable:true
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_realsense_service.py",
        enable:true
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_paint_service.py",
        enable:true
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_realsense_service.py",
        enable:true
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_block_service.py",
        enable:true
    },
    {
        chdir: './3d_led_cube2',
        spawn: "python main_block_test.py",
        enable:false
    },
    {
        chdir: './select_contents',
        spawn: "bundle exec rackup -P rack.pid",
        enable:true
    },
]
end

pids = processes.map do |process|
    if process[:enable] then
        spawn(process[:spawn], chdir:process[:chdir])
    else
        0
    end
end.reject do |i| i == 0 end

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
            Timeout.timeout(5) do
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