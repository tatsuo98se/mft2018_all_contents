require './process_def'
require './process_runner'

processes = [
    $hw_ctrl_module_dummy,
    $paint_service_offline,
    $block_test,
]

run_processes processes